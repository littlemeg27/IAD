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

@interface MainMenu ()

@property (nonatomic) SKLabelNode *nameLabel;
@property (nonatomic) SKLabelNode *playLabel;
@property (nonatomic) SKLabelNode *creditsLabel;
@property (nonatomic) SKLabelNode *instructionsLabel;

@end

@implementation MainMenu

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
        self.playLabel.position = CGPointMake(CGRectGetMidX(self.frame),600);
        [self addChild:self.playLabel];
        
        self.creditsLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.creditsLabel.text = @"Credits";
        self.creditsLabel.fontColor = [SKColor whiteColor];
        self.creditsLabel.fontSize = 30;
        self.creditsLabel.name = @"button2";
        self.creditsLabel.position = CGPointMake(CGRectGetMidX(self.frame),500);
        [self addChild:self.creditsLabel];
        
        self.instructionsLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.instructionsLabel.text = @"Tutorial";
        self.instructionsLabel.fontColor = [SKColor whiteColor];
        self.instructionsLabel.fontSize = 30;
        self.instructionsLabel.name = @"button3";
        self.instructionsLabel.position = CGPointMake(CGRectGetMidX(self.frame),400);
        [self addChild:self.instructionsLabel];
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
    }
    
    
}

@end
