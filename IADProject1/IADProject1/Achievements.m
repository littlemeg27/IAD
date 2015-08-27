//
//  Achievements.m
//  IADProject1
//
//  Created by Brenna Pavlinchak on 8/27/15.
//  Copyright (c) 2015 Brenna Pavlinchak. All rights reserved.
//

#import "Achievements.h"
#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>
#import "GameCenterManager.h"

static NSString* const level1LoseID = @"com.RavenDesign.labyrinth.level1Lose";
static NSString* const level2LoseID = @"com.RavenDesign.labyrinth.level2Lose";
static NSString* const level3LoseID = @"com.RavenDesign.labyrinth.level3Lose";
static NSString* const level4LoseID = @"com.RavenDesign.labyrinth.level4Lose";
static NSString* const level5LoseID = @"com.RavenDesign.labyrinth.level5Lose";
static NSString* const level6LoseID = @"com.RavenDesign.labyrinth.level6Lose";
static NSString* const level1WinID = @"com.RavenDesign.labyrinth.level1Win";
static NSString* const level2WinID = @"com.RavenDesign.labyrinth.level2Win";
static NSString* const level3WinID = @"com.RavenDesign.labyrinth.level3Win";
static NSString* const level4WinID = @"com.RavenDesign.labyrinth.level4Win";
static NSString* const level5WinID = @"com.RavenDesign.labyrinth.level5Win";
static NSString* const level6WinID = @"com.RavenDesign.labyrinth.level6Win";


@implementation Achievements
{
    GameCenterManager* _gameCenterManager;
}

+(GKAchievement *)AchievementLevels:(NSUInteger)AchievementLevels
{
    
    float percentComplete;
    NSString *IDOfAchievement = @"";
    
    if (coinCollected == 1)
    {
        IDOfAchievement = level1LoseID;
        percentComplete = 100;
    }
    else if (coinCollected == 25)
    {
        IDOfAchievement = level2LoseID;
        percentComplete = 100;
    }
    else if (coinCollected == 50)
    {
        IDOfAchievement = level3LoseID;
        percentComplete = 100;
    }
    else if (coinCollected == 100)
    {
        IDOfAchievement = level4LoseID;
        percentComplete = 100;
    }
    else if (coinCollected == 250)
    {
        IDOfAchievement = level5LoseID;
        percentComplete = 100;
    }
    else if (coinCollected == 500)
    {
        IDOfAchievement = level6LoseID;
        percentComplete = 100;
    }
    else if (coinCollected == 500)
    {
        IDOfAchievement = level1WinID;
        percentComplete = 100;
    }
    else if (coinCollected == 500)
    {
        IDOfAchievement = level2WinID;
        percentComplete = 100;
    }
    else if (coinCollected == 500)
    {
        IDOfAchievement = level3WinID;
        percentComplete = 100;
    }
    else if (coinCollected == 500)
    {
        IDOfAchievement = level4WinID;
        percentComplete = 100;
    }
    else if (coinCollected == 500)
    {
        IDOfAchievement = level5WinID;
        percentComplete = 100;
    }
    else if (coinCollected == 500)
    {
        IDOfAchievement = level6WinID;
        percentComplete = 100;
    }
    else if (coinCollected == 500)
    {
        IDOfAchievement = level1WinID;
        percentComplete = 100;
    }
    else if (coinCollected == 500)
    {
        IDOfAchievement = level1WinID;
        percentComplete = 100;
    }
    
    GKAchievement *achievement= [[GKAchievement alloc] initWithIdentifier:IDOfAchievement];
    
    achievement.percentComplete = percentComplete;
    achievement.showsCompletionBanner = YES;
    return achievement;
    
}

/*static Achievements  *_achievement = nil;

+(Achievements*)achievement //We are creating the singleton for the application
{
    @synchronized([Achievements class])
    {
        if(!_achievement) //Check to see if it is the applicationState so that we can create it for the first time
        {
            _achievement = [[self alloc] init];
        }
        
        return _achievement;
    }
    
    return nil;
}

+(id)alloc
{
    @synchronized([Achievements class])
    {
        NSAssert(_achievement == nil, @"You have already created a singleton, you do not need a second one!");
        _achievement = [super alloc];
        return _achievement;
    }
    
    return nil;
}

+(GKAchievement *)reportingAchievements:(NSString*) identifier percentComplete:(float) percent
{
    if (_achievement)
    {
        _achievement.percentComplete = percent;
        
        [_achievement reportAchievementWithCompletionHandler:^(NSError *error)
        {
            if (error != nil)
            {
                NSLog(@"Issues reporting achievements: %@", error);
            }
        }];
        _achievement.showsCompletionBanner = YES;
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
}*/

@end
