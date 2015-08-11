//
//  Tutorial.m
//  IADProject1
//
//  Created by Brenna Pavlinchak on 8/10/15.
//  Copyright (c) 2015 Brenna Pavlinchak. All rights reserved.
//

#import "Tutorial.h"
#import "MainMenu.h"

@implementation Tutorial

-(instancetype)initWithSize:(CGSize)size
{
    if(self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor brownColor];
        
        SKLabelNode *label1 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label1.text = @"Tutorial:";
        label1.fontColor = [SKColor whiteColor];
        label1.fontSize = 50;
        label1.position = CGPointMake(CGRectGetMidX(self.frame),800);
        [self addChild:label1];
        
        SKLabelNode *label2 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label2.text = @"To move the ball:";
        label2.fontColor = [SKColor whiteColor];
        label2.fontSize = 35;
        label2.position = CGPointMake(CGRectGetMidX(self.frame),700);
        [self addChild:label2];
        
        SKLabelNode *label3 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label3.text = @"Tilt screen Left, Right, Up and Down";
        label3.fontColor = [SKColor whiteColor];
        label3.fontSize = 35;
        label3.position = CGPointMake(CGRectGetMidX(self.frame),650);
        [self addChild:label3];
        
        SKLabelNode *label4 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label4.text = @"Objective:";
        label4.fontColor = [SKColor whiteColor];
        label4.fontSize = 35;
        label4.position = CGPointMake(CGRectGetMidX(self.frame),500);
        [self addChild:label4];
        
        SKLabelNode *label5 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label5.text = @"Move the ball from Start to End";
        label5.fontColor = [SKColor whiteColor];
        label5.fontSize = 35;
        label5.position = CGPointMake(CGRectGetMidX(self.frame),450);
        [self addChild:label5];
        
        SKLabelNode *label6 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label6.text = @"Don't hit any holes!";
        label6.fontColor = [SKColor whiteColor];
        label6.fontSize = 35;
        label6.position = CGPointMake(CGRectGetMidX(self.frame),350);
        [self addChild:label6];
        
        SKLabelNode *label7 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label7.text = @"Or its Game Over!";
        label7.fontColor = [SKColor whiteColor];
        label7.fontSize = 35;
        label7.position = CGPointMake(CGRectGetMidX(self.frame),300);
        [self addChild:label7];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    MainMenu *menu = [MainMenu sceneWithSize:self.size];
    [self.view presentScene:menu transition:[SKTransition fadeWithDuration:1.0]];
}

@end
