//
//  GameViewController.m
//  IADProject1
//
//  Created by Brenna Pavlinchak on 8/10/15.
//  Copyright (c) 2015 Brenna Pavlinchak. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "MainMenu.h"
#import "GameScene5.h"
#import "ActionSheet.h"

@interface GameViewController ()

@property (nonatomic) BOOL gameCenterEnabled;
@property (nonatomic, strong) NSString *leaderboardIdentifier;
@property (nonatomic) int lives;
@property (nonatomic) int timerValue;

-(void)reportScore;
-(void)authenticateLocalPlayer;
-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard;

@end

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file
{
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
#ifdef DEBUG
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
#endif
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    MainMenu *scene = [MainMenu sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    [self authenticateLocalPlayer];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

-(void)reportScore
{
    GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:_leaderboardIdentifier];
    score.value = score;
    
    [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error)
    {
        if (error != nil)
        {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

- (IBAction)handleAnswer:(id)sender
{
    if (_lives == 0)
    {
        [self reportScore];
    }
}

-(void)updateTimerLabel:(NSTimer *)timer
{
    if (_timerValue > 60)
    {
        [self reportScore];
    }
}

-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard
{
    GKGameCenterViewController *gcViewController = [[GKGameCenterViewController alloc] init];
    
    gcViewController.gameCenterDelegate = self;
    
    if (shouldShowLeaderboard) {
        gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gcViewController.leaderboardIdentifier = _leaderboardIdentifier;
    }
    else{
        gcViewController.viewState = GKGameCenterViewControllerStateAchievements;
    }
    
    [self presentViewController:gcViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (IBAction)showGCOptions:(id)sender
{
    [_ActionSheet showInView:self.view
             withCompletionHandler:^(NSString *buttonTitle, NSInteger buttonIndex)
    {
                 
        if([buttonTitle isEqualToString:@"View Leaderboard"])
        {
            [self showLeaderboardAndAchievements:YES];
        }
        else if([buttonTitle isEqualToString:@"View Achievements"])
        {
            [self showLeaderboardAndAchievements:NO];
        }
        else
        {
                     
        }
    }];
}

-(void)authenticateLocalPlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error)
    {
        if (viewController != nil)
        {
            [self presentViewController:viewController animated:YES completion:nil];
        }
        else
        {
            if ([GKLocalPlayer localPlayer].authenticated)
            {
                self.gameCenterEnabled = YES;
                
                // Get the default leaderboard identifier.
                [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error)
                {
                    
                    if (error != nil)
                    {
                        NSLog(@"%@", [error localizedDescription]);
                    }
                    else
                    {
                        self.leaderboardIdentifier = leaderboardIdentifier;
                    }
                }];
            }
            
            else
            {
                self.gameCenterEnabled = NO;
            }
        }
    };
}

@end
