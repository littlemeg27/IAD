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

@implementation Achievements
{
    GameCenterManager* _gameCenterManager;
}

+(void)reportingAchievements:(NSString*) identifier percentComplete:(float) percent
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
