//
//  Credits.m
//  IADProject1
//
//  Created by Brenna Pavlinchak on 8/10/15.
//  Copyright (c) 2015 Brenna Pavlinchak. All rights reserved.
//

#import "Credits.h"
#import "MainMenu.h"

@implementation Credits
-(instancetype)initWithSize:(CGSize)size
{
    if(self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor brownColor];
        
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label.text = @"Credits:";
        label.fontColor = [SKColor whiteColor];
        label.fontSize = 35;
        label.position = CGPointMake(CGRectGetMidX(self.frame),600);
        [self addChild:label];
        
        SKLabelNode *label1 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label1.text = @"Labyrinth";
        label1.fontColor = [SKColor whiteColor];
        label1.fontSize = 35;
        label1.position = CGPointMake(CGRectGetMidX(self.frame),550);
        [self addChild:label1];
        
        SKLabelNode *label2 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label2.text = @"Mobile Game Design";
        label2.fontColor = [SKColor whiteColor];
        label2.fontSize = 35;
        label2.position = CGPointMake(CGRectGetMidX(self.frame),500);
        [self addChild:label2];
        
        SKLabelNode *label3 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label3.text = @"Full Sail University";
        label3.fontColor = [SKColor whiteColor];
        label3.fontSize = 35;
        label3.position = CGPointMake(CGRectGetMidX(self.frame),450);
        [self addChild:label3];
        
        SKLabelNode *label4 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label4.text = @"Developer: Brenna Pavlinchak";
        label4.fontColor = [SKColor whiteColor];
        label4.fontSize = 35;
        label4.position = CGPointMake(CGRectGetMidX(self.frame),400);
        [self addChild:label4];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    MainMenu *menu = [MainMenu sceneWithSize:self.size];
    [self.view presentScene:menu transition:[SKTransition fadeWithDuration:1.0]];
}

@end
