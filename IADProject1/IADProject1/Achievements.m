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

+(GKAchievement *)reportingAchievements:(NSString*) identifier percentComplete:(float) percent
{
    GKAchievement *achievement= [[GKAchievement alloc] initWithIdentifier:identifier ];
    
    achievement.percentComplete = percent;
    achievement.showsCompletionBanner = YES;
    
    [achievement reportAchievementWithCompletionHandler:^(NSError *error)
     
    {
        
        if (error != nil)
            
        {
            
            NSLog(@"Issues reporting achievements: %@", error);
            
        }
        
    }];
    
}

@end
