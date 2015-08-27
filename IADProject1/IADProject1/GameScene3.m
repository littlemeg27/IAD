//
//  GameScene3.m
//  IADProject1
//
//  Created by Brenna Pavlinchak on 8/10/15.
//  Copyright (c) 2015 Brenna Pavlinchak. All rights reserved.
//

#import "GameScene3.h"
#import "GameOverScene.h"
#import "GameWinScene.h"
#import "MainMenu.h"
#import <CoreMotion/CoreMotion.h>
#include "Achievements.h"

@interface GameScene3 ()
{
    CMMotionManager *motion; //Gets in the four types of motion
}

@property (nonatomic) SKShapeNode *ball;
@property (nonatomic) SKShapeNode *pause;
@property (nonatomic) SKLabelNode *countDown;
@property (nonatomic) BOOL startGamePlay;
@property (nonatomic) NSTimeInterval startTime;
@property (readwrite) BOOL gameIsPaused;

@end

static const uint32_t holeCategory = 1;
static const uint32_t wallCategory = 2;
static const uint32_t edgeCategory = 4;
static const uint32_t ballCategory = 8;
static const uint32_t hole2Category = 16;
static const uint32_t winCategory = 32;

@implementation GameScene3

CMMotionManager *motion; //Gets in the four types of motion

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        /* Setup your scene here */
        self.backgroundColor = [SKColor brownColor];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.categoryBitMask = edgeCategory;
        self.physicsWorld.contactDelegate = self; //Might need for later
        
        motion = [[CMMotionManager alloc] init];
        
        SKLabelNode *startLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        startLabel.text = @"Start";
        startLabel.fontSize = 20;
        startLabel.position = CGPointMake(725, 910);
        
        SKLabelNode *endLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        endLabel.text = @"End";
        endLabel.fontSize = 20;
        endLabel.position = CGPointMake(150, 50);
        
        self.countDown = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.countDown.fontSize = 25;
        self.countDown.position = CGPointMake(120,975);
        self.countDown.fontColor = [SKColor whiteColor];
        
        [self addChild:self.countDown];
        [self addChild:startLabel];
        [self addChild:endLabel];
        [self addBall:size];
        [self addWalls:size];
        [self addHoles:size];
        [self addNodes:size];
        [self startGame];
    }
    return self;
}

-(void) addBall:(CGSize) size
{
    float radius = 22;
    self.ball = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
    CGPoint ballPoint = CGPointMake(size.width/2,size.height/2);
    self.ball.position = ballPoint;
    self.ball.fillColor = [SKColor redColor];
    self.ball.strokeColor = [SKColor blackColor];
    self.ball.physicsBody.categoryBitMask = ballCategory;
    self.ball.physicsBody.contactTestBitMask = wallCategory | holeCategory | hole2Category | winCategory;
    [self addChild:self.ball];
    
    SKShapeNode *ball2 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
    CGPoint ballPoint2 = CGPointMake(size.width/2,size.height/2);
    ball2.position = ballPoint2;
    ball2.fillColor = [SKColor purpleColor];
    ball2.strokeColor = [SKColor blackColor];
    ball2.physicsBody.categoryBitMask = ballCategory;
    ball2.physicsBody.contactTestBitMask = wallCategory | holeCategory | hole2Category | winCategory;
    [self addChild:ball2];
    
    int minDuration = 2.0;
    int maxDuration = 50.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    //Create the actions
    SKAction *moveBall =  [SKAction moveByX:100.0 y:100.0 duration:actualDuration];
    SKAction *moveBallDone = [SKAction removeFromParent];
    [ball2 runAction:[SKAction sequence:@[moveBall, moveBallDone]]];
}

-(void) addWalls:(CGSize) size
{
    SKSpriteNode *topWall = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(765, 8)];
    [topWall setPosition:CGPointMake(384, 950)];
    topWall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topWall.frame.size];
    topWall.physicsBody.dynamic = NO;
    topWall.physicsBody.categoryBitMask = wallCategory;
    topWall.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:topWall];
    
    SKSpriteNode *topRight = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(690, 8)];
    [topRight setPosition:CGPointMake(450, 860)]; //Horizontal top right line
    topRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topRight.frame.size];
    topRight.physicsBody.dynamic = NO;
    topRight.physicsBody.categoryBitMask = wallCategory;
    topRight.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:topRight];
    
     SKSpriteNode *topLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 100)];
     [topLeft setPosition:CGPointMake(101, 814)]; //Vertical topLeft line
     topLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topLeft.frame.size];
     topLeft.physicsBody.dynamic =  NO;
     topLeft.physicsBody.categoryBitMask = wallCategory;
     topLeft.physicsBody.contactTestBitMask = wallCategory | ballCategory;
     [self addChild:topLeft];
     
     SKSpriteNode *middleTop = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(490, 8)];
     [middleTop setPosition:CGPointMake(435, 780)]; //Horizontal top middle line
     middleTop.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:middleTop.frame.size];
     middleTop.physicsBody.dynamic =  NO;
     middleTop.physicsBody.categoryBitMask = wallCategory;
     middleTop.physicsBody.contactTestBitMask = wallCategory | ballCategory;
     [self addChild:middleTop];
     
     SKSpriteNode *topRightVertical = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 100)];
     [topRightVertical setPosition:CGPointMake(680, 734)]; //Vertical top right line
     topRightVertical.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topRightVertical.frame.size];
     topRightVertical.physicsBody.dynamic =  NO;
     topRightVertical.physicsBody.categoryBitMask = wallCategory;
     topRightVertical.physicsBody.contactTestBitMask = wallCategory | ballCategory;
     [self addChild:topRightVertical];
     
     SKSpriteNode *topLeftVertical = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 100)];
     [topLeftVertical setPosition:CGPointMake(190, 734)]; //Vertical top left line
     topLeftVertical.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topLeftVertical.frame.size];
     topLeftVertical.physicsBody.dynamic =  NO;
     topLeftVertical.physicsBody.categoryBitMask = wallCategory;
     topLeftVertical.physicsBody.contactTestBitMask = wallCategory | ballCategory;
     [self addChild:topLeftVertical];
     
     SKSpriteNode *topRightHorizontal = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(100, 8)];
     [topRightHorizontal setPosition:CGPointMake(634, 680)]; //Horizontal top right line
     topRightHorizontal.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topRightHorizontal.frame.size];
     topRightHorizontal.physicsBody.dynamic =  NO;
     topRightHorizontal.physicsBody.categoryBitMask = wallCategory;
     topRightHorizontal.physicsBody.contactTestBitMask = wallCategory | ballCategory;
     [self addChild:topRightHorizontal];
     
     SKSpriteNode *topLeftHorizontal = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(100, 8)];
     [topLeftHorizontal setPosition:CGPointMake(144, 680)]; //Horizontal top left line
     topLeftHorizontal.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topLeftHorizontal.frame.size];
     topLeftHorizontal.physicsBody.dynamic =  NO;
     topLeftHorizontal.physicsBody.categoryBitMask = wallCategory;
     topLeftHorizontal.physicsBody.contactTestBitMask = wallCategory | ballCategory;
     [self addChild:topLeftHorizontal];
     
     SKSpriteNode *leftMiddle = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 290)];
     [leftMiddle setPosition:CGPointMake(98, 538)]; //Vertical left middle line
     leftMiddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:leftMiddle.frame.size];
     leftMiddle.physicsBody.dynamic =  NO;
     leftMiddle.physicsBody.categoryBitMask = wallCategory;
     leftMiddle.physicsBody.contactTestBitMask = wallCategory | ballCategory;
     [self addChild:leftMiddle];
     
     SKSpriteNode *leftbottom = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 290)];
     [leftbottom setPosition:CGPointMake(98, 138)]; //Vertical bottom left line
     leftbottom.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:leftbottom.frame.size];
     leftbottom.physicsBody.dynamic =  NO;
     leftbottom.physicsBody.categoryBitMask = wallCategory;
     leftbottom.physicsBody.contactTestBitMask = wallCategory | ballCategory;
     [self addChild:leftbottom];
     
     SKSpriteNode *leftBottomHorizontal = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(220, 8)];
     [leftBottomHorizontal setPosition:CGPointMake(205, 280)]; //Horizontal middle right line
     leftBottomHorizontal.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:leftBottomHorizontal.frame.size];
     leftBottomHorizontal.physicsBody.dynamic =  NO;
     leftBottomHorizontal.physicsBody.categoryBitMask = wallCategory;
     leftBottomHorizontal.physicsBody.contactTestBitMask = wallCategory | ballCategory;
     [self addChild:leftBottomHorizontal];
     
     SKSpriteNode *middleRight = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 410)];
     [middleRight setPosition:CGPointMake(680, 390)]; //Vertical middle right line
     middleRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:middleRight.frame.size];
     middleRight.physicsBody.dynamic =  NO;
     middleRight.physicsBody.categoryBitMask = wallCategory;
     middleRight.physicsBody.contactTestBitMask = wallCategory | ballCategory;
     [self addChild:middleRight];
     
     SKSpriteNode *rightMiddle = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 315)];
     [rightMiddle setPosition:CGPointMake(190, 440)]; //Vertical middle lower right line
     rightMiddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rightMiddle.frame.size];
     rightMiddle.physicsBody.dynamic =  NO;
     rightMiddle.physicsBody.categoryBitMask = wallCategory;
     rightMiddle.physicsBody.contactTestBitMask = wallCategory | ballCategory;
     [self addChild:rightMiddle];
     
     SKSpriteNode *bottomRight = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(100, 8)];
     [bottomRight setPosition:CGPointMake(627, 189)]; //Horizontal right middle line
     bottomRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomRight.frame.size];
     bottomRight.physicsBody.dynamic =  NO;
     bottomRight.physicsBody.categoryBitMask = wallCategory;
     bottomRight.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:bottomRight];
    
    SKSpriteNode *bottomRightVertical = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 220)];
    [bottomRightVertical setPosition:CGPointMake(575, 295)]; //Vertical right middle line
    bottomRightVertical.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomRightVertical.frame.size];
    bottomRightVertical.physicsBody.dynamic =  NO;
    bottomRightVertical.physicsBody.categoryBitMask = wallCategory;
    bottomRightVertical.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:bottomRightVertical];
    
    SKSpriteNode *bottomMiddle = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(290, 8)];
    [bottomMiddle setPosition:CGPointMake(338, 191)]; //Horizontal right middle line
    bottomMiddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomMiddle.frame.size];
    bottomMiddle.physicsBody.dynamic =  NO;
    bottomMiddle.physicsBody.categoryBitMask = wallCategory;
    bottomMiddle.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:bottomMiddle];
    
    SKSpriteNode *leftbottom2 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 200)];
    [leftbottom2 setPosition:CGPointMake(190, 95)]; //Vertical bottom left line
    leftbottom2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:leftbottom2.frame.size];
    leftbottom2.physicsBody.dynamic =  NO;
    leftbottom2.physicsBody.categoryBitMask = wallCategory;
    leftbottom2.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:leftbottom2];
    
    SKSpriteNode *middleVertical = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 400)];
    [middleVertical setPosition:CGPointMake(312, 480)]; //Vertical middle line
    middleVertical.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:middleVertical.frame.size];
    middleVertical.physicsBody.dynamic =  NO;
    middleVertical.physicsBody.categoryBitMask = wallCategory;
    middleVertical.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:middleVertical];
    
    SKSpriteNode *middleHorizontal = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(100, 8)];
    [middleHorizontal setPosition:CGPointMake(358, 680)]; //Vertical middle line
    middleHorizontal.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:middleHorizontal.frame.size];
    middleHorizontal.physicsBody.dynamic =  NO;
    middleHorizontal.physicsBody.categoryBitMask = wallCategory;
    middleHorizontal.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:middleHorizontal];
    
    SKSpriteNode *middleVertical1 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 100)];
    [middleVertical1 setPosition:CGPointMake(585, 634)]; //Vertical middle line
    middleVertical1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:middleVertical1.frame.size];
    middleVertical1.physicsBody.dynamic =  NO;
    middleVertical1.physicsBody.categoryBitMask = wallCategory;
    middleVertical1.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:middleVertical1];
    
    SKSpriteNode *middleHorizontal2 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(270, 8)];
    [middleHorizontal2 setPosition:CGPointMake(450, 588)]; //Vertical middle line
    middleHorizontal2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:middleHorizontal2.frame.size];
    middleHorizontal2.physicsBody.dynamic =  NO;
    middleHorizontal2.physicsBody.categoryBitMask = wallCategory;
    middleHorizontal2.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:middleHorizontal2];
    
    SKSpriteNode *middleHorizontal3 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(280, 8)];
    [middleHorizontal3 setPosition:CGPointMake(540, 500)]; //Vertical middle line
    middleHorizontal3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:middleHorizontal3.frame.size];
    middleHorizontal3.physicsBody.dynamic =  NO;
    middleHorizontal3.physicsBody.categoryBitMask = wallCategory;
    middleHorizontal3.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:middleHorizontal3];
    
    SKSpriteNode *middleVertical4 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 310)];
    [middleVertical4 setPosition:CGPointMake(404, 345)]; //Vertical middle line
    middleVertical4.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:middleVertical4.frame.size];
    middleVertical4.physicsBody.dynamic =  NO;
    middleVertical4.physicsBody.categoryBitMask = wallCategory;
    middleVertical4.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:middleVertical4];
    
    SKSpriteNode *bottomRightVertical2 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 220)];
    [bottomRightVertical2 setPosition:CGPointMake(485, 297)]; //Vertical right middle line
    bottomRightVertical2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomRightVertical.frame.size];
    bottomRightVertical2.physicsBody.dynamic =  NO;
    bottomRightVertical2.physicsBody.categoryBitMask = wallCategory;
    bottomRightVertical2.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:bottomRightVertical2];
    
    SKSpriteNode *bottomRight2 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(600, 8)];
    [bottomRight2 setPosition:CGPointMake(600, 95)]; //Vertical right middle line
    bottomRight2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomRight2.frame.size];
    bottomRight2.physicsBody.dynamic =  NO;
    bottomRight2.physicsBody.categoryBitMask = wallCategory;
    bottomRight2.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:bottomRight2];
}


-(void) addHoles:(CGSize) size
{
     float radius = 26;
     SKShapeNode *hole1 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
     CGPoint ballPoint1 = CGPointMake(50,290);
     hole1.position = ballPoint1;
     hole1.fillColor = [SKColor grayColor]; //Right after start left corner
     hole1.strokeColor = [SKColor blackColor]; //Hole 1
     hole1.physicsBody.categoryBitMask = holeCategory;
     hole1.physicsBody.collisionBitMask = 0;
     hole1.physicsBody.contactTestBitMask = wallCategory | ballCategory;
     [self addChild:hole1];
     
     SKShapeNode *hole2 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
     CGPoint ballPoint2 = CGPointMake(250,330);
     hole2.position = ballPoint2;
     hole2.fillColor = [SKColor grayColor]; //Right after start right corner
     hole2.strokeColor = [SKColor blackColor]; //Hole 2
     hole2.physicsBody.categoryBitMask = holeCategory;
     hole2.physicsBody.contactTestBitMask = wallCategory | ballCategory;
     [self addChild:hole2];
     
     SKShapeNode *hole3 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
     CGPoint ballPoint3 = CGPointMake(630,730);
     hole3.position = ballPoint3;
     hole3.fillColor = [SKColor grayColor]; //Upper left corner third turn
     hole3.strokeColor = [SKColor blackColor]; //Hole 3
     hole3.physicsBody.categoryBitMask = holeCategory;
     hole3.physicsBody.contactTestBitMask = wallCategory | ballCategory;
     [self addChild:hole3];
     
     SKShapeNode *hole4 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
     CGPoint ballPoint4 = CGPointMake(735,130);
     hole4.position = ballPoint4;
     hole4.fillColor = [SKColor grayColor]; //Upper right corner
     hole4.strokeColor = [SKColor blackColor]; //Hole 4
     hole4.physicsBody.categoryBitMask = holeCategory;
     hole4.physicsBody.contactTestBitMask = wallCategory | ballCategory;
     [self addChild:hole4];
     
     SKShapeNode *hole5 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
     CGPoint ballPoint5 = CGPointMake(370,225);
     hole5.position = ballPoint5;
     hole5.fillColor = [SKColor grayColor]; //Middle left corner
     hole5.strokeColor = [SKColor blackColor]; //Hole 5
     hole5.physicsBody.categoryBitMask = holeCategory;
     hole5.physicsBody.contactTestBitMask = wallCategory | ballCategory;
     [self addChild:hole5];
     
     SKShapeNode *hole6 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
     CGPoint ballPoint6 = CGPointMake(630,245);
     hole6.position = ballPoint6;
     hole6.fillColor = [SKColor grayColor]; //Middle right corner
     hole6.strokeColor = [SKColor blackColor]; //Hole 6
     hole6.physicsBody.categoryBitMask = holeCategory;
     hole6.physicsBody.contactTestBitMask = wallCategory | ballCategory;
     [self addChild:hole6];
     
     SKShapeNode *hole7 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
     CGPoint ballPoint7 = CGPointMake(30,915);
     hole7.position = ballPoint7;
     hole7.fillColor = [SKColor grayColor];
     hole7.strokeColor = [SKColor blackColor]; //Hole 7
     hole7.physicsBody.categoryBitMask = holeCategory;
     hole7.physicsBody.contactTestBitMask = wallCategory | ballCategory;
     [self addChild:hole7];
     
     SKShapeNode *hole8 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
     CGPoint ballPoint8 = CGPointMake(135,825);
     hole8.position = ballPoint8;
     hole8.fillColor = [SKColor grayColor];
     hole8.strokeColor = [SKColor blackColor]; //Hole 8
     hole8.physicsBody.categoryBitMask = holeCategory;
     hole8.physicsBody.contactTestBitMask = wallCategory | ballCategory;
     [self addChild:hole8];
}

-(void) addNodes:(CGSize) size
{
     float radius = 22;
     SKNode *hole1 = [SKNode node];
     hole1.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
     CGPoint ballPoint1 = CGPointMake(50,290);
     hole1.position = ballPoint1;
     hole1.physicsBody.categoryBitMask = hole2Category;
     [self addChild: hole1];
     
     SKNode *hole2 = [SKNode node];
     CGPoint ballPoint2 = CGPointMake(250,330);
     hole2.position = ballPoint2;
     hole2.physicsBody.categoryBitMask = hole2Category;
     [self addChild: hole2];
     
     SKNode *hole3 = [SKNode node];
     CGPoint ballPoint3 = CGPointMake(630,730);
     hole3.position = ballPoint3;
     hole3.physicsBody.categoryBitMask = hole2Category;
     [self addChild: hole3];
     
     SKNode *hole4 = [SKNode node];
     hole4.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
     CGPoint ballPoint4 = CGPointMake(735,130);
     hole4.position = ballPoint4;
     hole4.physicsBody.categoryBitMask = hole2Category;
     [self addChild: hole4];
     
     SKNode *hole5 = [SKNode node];
     hole5.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
     CGPoint ballPoint5 = CGPointMake(370,225);
     hole5.position = ballPoint5;
     hole5.physicsBody.categoryBitMask = hole2Category;
     [self addChild: hole5];
     
     SKNode *hole6 = [SKNode node];
     hole6.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
     CGPoint ballPoint6 = CGPointMake(630,245);
     hole6.position = ballPoint6;
     hole6.physicsBody.categoryBitMask = hole2Category;
     [self addChild: hole6];
     
     SKNode *hole7 = [SKNode node];
     hole7.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
     CGPoint ballPoint7 =CGPointMake(30,915);
     hole7.position = ballPoint7;
     hole7.physicsBody.categoryBitMask = hole2Category;
     [self addChild: hole7];
     
     SKNode *hole8 = [SKNode node];
     hole8.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
     CGPoint ballPoint8 = CGPointMake(135,825);
     hole8.position = ballPoint8;
     hole8.physicsBody.categoryBitMask = hole2Category;
     [self addChild: hole8];
     
     SKNode *endBox = [SKNode node];
     endBox.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(100,75) toPoint:CGPointMake(190, 75)];
     endBox.physicsBody.categoryBitMask = winCategory;
     [self addChild: endBox];
    
}

- (void)startGame
{
    self.ball.hidden = NO;   //reset ball position for new game
    self.ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.ball.frame.size.width/2];
    CGPoint ballPoint = CGPointMake(750,900);
    self.ball.position = ballPoint;
    self.ball.physicsBody.dynamic = YES; //Not sitting still
    self.ball.physicsBody.affectedByGravity = NO; //Not affected
    self.ball.physicsBody.mass = 0.05; //Give mass
    self.ball.physicsBody.categoryBitMask = ballCategory;
    self.ball.physicsBody.contactTestBitMask = wallCategory | hole2Category | winCategory;
    
    self.startGamePlay = YES; //Starts timer at 0 when the game starts
    
    //setup to handle accelerometer readings using CoreMotion Framework
    [self startAccelerationOn]; //Yeah not sure
}

- (void)startAccelerationOn
{
    if (motion.accelerometerAvailable)
    {
        [motion startAccelerometerUpdates];
        NSLog(@"on");
    }
}

- (void)stopAccelerationOff
{
    if (motion.accelerometerAvailable && motion.accelerometerActive)
    {
        [motion stopAccelerometerUpdates];
        NSLog(@"off");
    }
}

- (void)updateBallPosition
{
    CMAccelerometerData* data = motion.accelerometerData;
    if (fabs(data.acceleration.x) > 0.2)
    {
        //NSLog(@"acceleration value = %f", data.acceleration.x);
        [self.ball.physicsBody applyForce:CGVectorMake(50.0 * data.acceleration.x, 50.0 * data.acceleration.y)];
    }
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    NSLog(@"Test");
    //Makes sound when the ball hits the wall or hits a hole
    SKPhysicsBody *notBall;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        notBall = contact.bodyB;
    }
    else
    {
        notBall = contact.bodyA;
    }
    
    if (notBall.categoryBitMask == wallCategory)
    {
        SKAction *playSFX1 = [SKAction playSoundFileNamed:@"shake.caf" waitForCompletion:NO];
        [self runAction:playSFX1];
        NSLog(@"Ball has hit the wall or edge"); //Makes sound when the ball hits the wall
    }
    
    if (notBall.categoryBitMask == hole2Category)
    {
        SKAction *playSFX1 = [SKAction playSoundFileNamed:@"explosion_small.caf" waitForCompletion:NO];
        [self runAction:playSFX1];
        NSLog(@"Ball has hit the hole"); //Makes sound when the ball hits the hole
        
        GameOverScene *gameOver = [GameOverScene sceneWithSize:self.size];
        [self.view presentScene:gameOver transition:[SKTransition fadeWithDuration:2.0]]; //What happens when you lose
    }
    
    if (notBall.categoryBitMask == winCategory)
    {
        GameWinScene *gameWin = [GameWinScene sceneWithSize:self.size];
        [self.view presentScene:gameWin transition:[SKTransition fadeWithDuration:2.0]]; //What happens when you win
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    /*for (UITouch *touch in touches)
     {
     self.pause.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.pause.frame.size];
     self.pause.physicsBody.dynamic =  NO;
     CGPoint pausePoint = CGPointMake(300,250);
     self.pause.position = pausePoint;
     
     if([self.gameIsPaused containsPoint:pausePoint])
     {
     CGPoint pausePoint = [touch locationInNode:self];
     self.scene.view.paused = YES;
     }
     }*/
    
}

-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
    
    //Update the ball position
    [self updateBallPosition];
    
    //reset counter if starting
    if (self.startGamePlay)
    {
        self.startTime = currentTime;
        self.startGamePlay = NO;
    }
    self.countDown.text = [NSString stringWithFormat:@"Time: %i", (int)(currentTime-self.startTime)];
}

@end
