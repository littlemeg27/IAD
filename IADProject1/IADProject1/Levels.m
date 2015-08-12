//
//  Levels.m
//  IADProject1
//
//  Created by Brenna Pavlinchak on 8/11/15.
//  Copyright (c) 2015 Brenna Pavlinchak. All rights reserved.
//

#import "Levels.h"
#import "MainMenu.h"
#import "GameScene.h"
#import "GameScene2.h"
#import "GameScene3.h"
#import "GameScene4.h"
#import "GameScene5.h"
#import "GameScene6.h"

@interface Levels ()

@property (nonatomic) SKLabelNode *levelOneLabel;
@property (nonatomic) SKLabelNode *levelTwoLabel;
@property (nonatomic) SKLabelNode *levelThreeLabel;
@property (nonatomic) SKLabelNode *levelFourLabel;
@property (nonatomic) SKLabelNode *levelFiveLabel;
@property (nonatomic) SKLabelNode *levelSixLabel;
@property (nonatomic) SKLabelNode *backLabelLabel;

@end

@implementation Levels

-(instancetype)initWithSize:(CGSize)size
{
    if(self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor brownColor];
        
        self.levelOneLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.levelOneLabel.text = @"Level 1";
        self.levelOneLabel.fontColor = [SKColor whiteColor];
        self.levelOneLabel.fontSize = 20;
        self.levelOneLabel.name = @"button1";
        self.levelOneLabel.position = CGPointMake(CGRectGetMidX(self.frame),900);
        [self addChild:self.levelOneLabel];
        
        self.levelTwoLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.levelTwoLabel.text = @"Level 2";
        self.levelTwoLabel.fontColor = [SKColor whiteColor];
        self.levelTwoLabel.fontSize = 20;
        self.levelTwoLabel.name = @"button2";
        self.levelTwoLabel.position = CGPointMake(CGRectGetMidX(self.frame),800);
        [self addChild:self.levelTwoLabel];
        
        self.levelThreeLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.levelThreeLabel.text = @"Level 3";
        self.levelThreeLabel.fontColor = [SKColor whiteColor];
        self.levelThreeLabel.fontSize = 20;
        self.levelThreeLabel.name = @"button3";
        self.levelThreeLabel.position = CGPointMake(CGRectGetMidX(self.frame),600);
        [self addChild:self.levelThreeLabel];
        
        self.levelFourLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.levelFourLabel.text = @"Level 4";
        self.levelFourLabel.fontColor = [SKColor whiteColor];
        self.levelFourLabel.fontSize = 20;
        self.levelFourLabel.name = @"button4";
        self.levelFourLabel.position = CGPointMake(CGRectGetMidX(self.frame),500);
        [self addChild:self.levelFourLabel];
        
        self.levelFiveLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.levelFiveLabel.text = @"Level 5";
        self.levelFiveLabel.fontColor = [SKColor whiteColor];
        self.levelFiveLabel.fontSize = 20;
        self.levelFiveLabel.name = @"button5";
        self.levelFiveLabel.position = CGPointMake(CGRectGetMidX(self.frame),400);
        [self addChild:self.levelFiveLabel];
        
        self.levelSixLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.levelSixLabel.text = @"Level 6";
        self.levelSixLabel.fontColor = [SKColor whiteColor];
        self.levelSixLabel.fontSize = 20;
        self.levelSixLabel.name = @"button6";
        self.levelSixLabel.position = CGPointMake(CGRectGetMidX(self.frame),300);
        [self addChild:self.levelSixLabel];
        
        self.backLabelLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.backLabelLabel.text = @"Back";
        self.backLabelLabel.fontColor = [SKColor whiteColor];
        self.backLabelLabel.fontSize = 20;
        self.backLabelLabel.name = @"button7";
        self.backLabelLabel.position = CGPointMake(50,900);
        [self addChild:self.backLabelLabel];
        
        
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
            GameScene2 *gameScene2 = [GameScene2 sceneWithSize:self.size];
            [self.view presentScene:gameScene2 transition:[SKTransition fadeWithDuration:1.0]];
        }
        else if  ([node.name isEqualToString:@"button3"])
        {
            GameScene3 *gameScene3 = [GameScene3 sceneWithSize:self.size];
            [self.view presentScene:gameScene3 transition:[SKTransition fadeWithDuration:1.0]];
        }
        else if  ([node.name isEqualToString:@"button4"])
        {
            GameScene4 *gameScene4 = [GameScene4 sceneWithSize:self.size];
            [self.view presentScene:gameScene4 transition:[SKTransition fadeWithDuration:1.0]];
        }
        else if  ([node.name isEqualToString:@"button5"])
        {
            GameScene5 *gameScene5 = [GameScene5 sceneWithSize:self.size];
            [self.view presentScene:gameScene5 transition:[SKTransition fadeWithDuration:1.0]];
        }
        else if  ([node.name isEqualToString:@"button6"])
        {
            GameScene6 *gameScene6 = [GameScene6 sceneWithSize:self.size];
            [self.view presentScene:gameScene6 transition:[SKTransition fadeWithDuration:1.0]];
        }
        else if  ([node.name isEqualToString:@"button7"])
        {
            MainMenu *menu = [MainMenu sceneWithSize:self.size];
            [self.view presentScene:menu transition:[SKTransition fadeWithDuration:1.0]];
        }
    }
    
    
}


@end
