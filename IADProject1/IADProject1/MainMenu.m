//
//  MainMenu.m
//  IADProject1
//
//  Created by Brenna Pavlinchak on 8/10/15.
//  Copyright (c) 2015 Brenna Pavlinchak. All rights reserved.
//

#import "MainMenu.h"
#import "GameScene.h"
#import "Credits.h"
#import "Tutorial.h"
#import "Levels.h"

@interface MainMenu ()

@property (nonatomic) SKLabelNode *nameLabel;
@property (nonatomic) SKLabelNode *playLabel;
@property (nonatomic) SKLabelNode *creditsLabel;
@property (nonatomic) SKLabelNode *instructionsLabel;
@property (nonatomic) SKLabelNode *levelsLabel;
@property (nonatomic) SKLabelNode *GCLabel;

@end

@implementation MainMenu
{
    GameCenterManager* _gameCenterManager;
}

-(instancetype)initWithSize:(CGSize)size
{
    if(self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor brownColor];
        
        self.nameLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.nameLabel.text = @"Labyrinth";
        self.nameLabel.fontColor = [SKColor whiteColor];
        self.nameLabel.fontSize = 60;
        self.nameLabel.position = CGPointMake(CGRectGetMidX(self.frame),800);
        [self addChild:self.nameLabel];
        
        self.playLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.playLabel.text = @"Play";
        self.playLabel.fontColor = [SKColor whiteColor];
        self.playLabel.fontSize = 30;
        self.playLabel.name = @"button1";
        self.playLabel.position = CGPointMake(CGRectGetMidX(self.frame),700);
        [self addChild:self.playLabel];
        
        self.creditsLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.creditsLabel.text = @"Credits";
        self.creditsLabel.fontColor = [SKColor whiteColor];
        self.creditsLabel.fontSize = 30;
        self.creditsLabel.name = @"button2";
        self.creditsLabel.position = CGPointMake(CGRectGetMidX(self.frame),600);
        [self addChild:self.creditsLabel];
        
        self.instructionsLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.instructionsLabel.text = @"Tutorial";
        self.instructionsLabel.fontColor = [SKColor whiteColor];
        self.instructionsLabel.fontSize = 30;
        self.instructionsLabel.name = @"button3";
        self.instructionsLabel.position = CGPointMake(CGRectGetMidX(self.frame),500);
        [self addChild:self.instructionsLabel];
        
        self.levelsLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.levelsLabel.text = @"Levels";
        self.levelsLabel.fontColor = [SKColor whiteColor];
        self.levelsLabel.fontSize = 30;
        self.levelsLabel.name = @"button4";
        self.levelsLabel.position = CGPointMake(CGRectGetMidX(self.frame),400);
        [self addChild:self.levelsLabel];
        
        self.GCLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.GCLabel.text = @"Game Center";
        self.GCLabel.fontColor = [SKColor whiteColor];
        self.GCLabel.fontSize = 30;
        self.GCLabel.name = @"button5";
        self.GCLabel.position = CGPointMake(CGRectGetMidX(self.frame),300);
        [self addChild:self.GCLabel];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        if ([node.name isEqualToString:@"button1"])
        {
            GameScene *gameScene = [GameScene sceneWithSize:self.size];
            [self.view presentScene:gameScene transition:[SKTransition fadeWithDuration:1.0]];
        }
        else if ([node.name isEqualToString:@"button2"])
        {
            Credits *credits = [Credits sceneWithSize:self.size];
            [self.view presentScene:credits transition:[SKTransition fadeWithDuration:1.0]];
        }
        else if  ([node.name isEqualToString:@"button3"])
        {
            Tutorial *tutorial = [Tutorial sceneWithSize:self.size];
            [self.view presentScene:tutorial transition:[SKTransition fadeWithDuration:1.0]];
        }
        else if  ([node.name isEqualToString:@"button4"])
        {
            Levels *levels = [Levels sceneWithSize:self.size];
            [self.view presentScene:levels transition:[SKTransition fadeWithDuration:1.0]];
        }
        else if ([node.name isEqualToString:@"button5"])
        {
            [self showLeaderboard];
        }
    }
}

-(void)showLeaderboard
{
    GKGameCenterViewController *leaderboardController = [[GKGameCenterViewController alloc] init];
    
    if (leaderboardController != NULL)
    {
        leaderboardController.leaderboardIdentifier = @"1";
        leaderboardController.viewState = GKGameCenterViewControllerStateLeaderboards;
        leaderboardController.gameCenterDelegate = self;
        UIViewController *vc = self.view.window.rootViewController;
        [vc presentViewController: leaderboardController animated: YES completion:nil];
    }
}

- (void) reportAchievement: (NSString*) identifier percentComplete: (float) percent
{
    GKAchievement *achievement = [[GKAchievement alloc] initWithIdentifier: identifier];
    if (achievement)
    {
        achievement.percentComplete = percent;
        
        [achievement reportAchievementWithCompletionHandler:^(NSError *error)
        {
            if (error != nil)
            {
                NSLog(@"Error with achievements: %@", error);
            }
        }];
        achievement.showsCompletionBanner = YES;
    }
}

- (void)didMoveToView:(SKView *)view
{
    if ([GameCenterManager isGameCenterAvailable])
    {
        _gameCenterManager = [[GameCenterManager alloc] init];
        [_gameCenterManager setDelegate:self];
        [_gameCenterManager authenticateLocalUser];
    }
    else
    {
        //_gameCenterManager.viewState = GKGameCenterViewControllerStateAchievements;
        // The current device does not support Game Center.
    }
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)viewController
{
    UIViewController *vc = self.view.window.rootViewController;
    [vc dismissViewControllerAnimated:YES completion:nil];
}



@end
