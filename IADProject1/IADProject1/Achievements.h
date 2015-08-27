//
//  Achievements.h
//  IADProject1
//
//  Created by Brenna Pavlinchak on 8/27/15.
//  Copyright (c) 2015 Brenna Pavlinchak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>
#import "GameCenterManager.h"

@interface Achievements : NSObject

+(GKAchievement *)reportingAchievements:(NSString*) identifier percentComplete:(float) percent;

@end
