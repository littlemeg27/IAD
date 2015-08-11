//
//  GameOverScene.m
//  IADProject1
//
//  Created by Brenna Pavlinchak on 8/10/15.
//  Copyright (c) 2015 Brenna Pavlinchak. All rights reserved.
//

#import "GameOverScene.h"
#import "GameScene.h"

@implementation GameOverScene

-(instancetype)initWithSize:(CGSize)size
{
    if(self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor brownColor];
        
        SKLabelNode *loseLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        loseLabel.text = @"Game Over!";
        loseLabel.fontColor = [SKColor whiteColor];
        loseLabel.fontSize = 50;
        loseLabel.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        [self addChild:loseLabel];
        
        
        SKLabelNode *tryAgainLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        tryAgainLabel.text = @"Try Again!";
        tryAgainLabel.fontColor = [SKColor whiteColor];
        tryAgainLabel.fontSize = 35;
        tryAgainLabel.position = CGPointMake(size.width/2, size.height/2 - 90);
        [self addChild:tryAgainLabel];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    GameScene *gameScene = [GameScene sceneWithSize:self.size];
    [self.view presentScene:gameScene transition:[SKTransition fadeWithDuration:1.0]];
}

@end
