//
//  GameScene2.m
//  IADProject1
//
//  Created by Brenna Pavlinchak on 8/10/15.
//  Copyright (c) 2015 Brenna Pavlinchak. All rights reserved.
//

#import "GameScene2.h"
#import "GameOverScene.h"
#import "GameWinScene.h"

@interface GameScene2 ()

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

@import CoreMotion;

@implementation GameScene2

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
        startLabel.position = CGPointMake(70, 900);
        
        SKLabelNode *endLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        endLabel.text = @"End";
        endLabel.fontSize = 20;
        endLabel.position = CGPointMake(70, 50);
        
        self.countDown = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.countDown.fontSize = 25;
        self.countDown.position = CGPointMake(120,975);
        self.countDown.fontColor = [SKColor whiteColor];
        
        //self.anchorPoint = CGPointMake (0.5,0.5);
        
        /*SKNode *myWorld = [SKNode node];
         [self addChild:myWorld];
         
         SKNode *camera = [SKNode node];
         camera.name = @"camera";
         [myWorld addChild:camera];*/
        
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
    float radius = 28;
    self.ball = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
    CGPoint ballPoint = CGPointMake(size.width/2,size.height/2);
    self.ball.position = ballPoint;
    self.ball.fillColor = [SKColor redColor];
    self.ball.strokeColor = [SKColor blackColor];
    self.ball.physicsBody.categoryBitMask = ballCategory;
    self.ball.physicsBody.contactTestBitMask = wallCategory | holeCategory | hole2Category | winCategory;
    [self addChild:self.ball];
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
    
    SKSpriteNode *middleLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(435, 8)];
    [middleLeft setPosition:CGPointMake(55, 470)]; //Horizontal middle left line
    middleLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:middleLeft.frame.size];
    middleLeft.physicsBody.dynamic = NO;
    middleLeft.physicsBody.categoryBitMask = wallCategory;
    middleLeft.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:middleLeft];
    
    /*SKSpriteNode *bottomLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 350)];
    [bottomLeft setPosition:CGPointMake(140, 175)]; //Vertical bottom left line
    bottomLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomLeft.frame.size];
    bottomLeft.physicsBody.dynamic =  NO;
    bottomLeft.physicsBody.categoryBitMask = wallCategory;
    bottomLeft.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:bottomLeft];
    
    SKSpriteNode *topLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 350)];
    [topLeft setPosition:CGPointMake(140, 775)]; //Vertical top left line
    topLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topLeft.frame.size];
    topLeft.physicsBody.dynamic =  NO;
    topLeft.physicsBody.categoryBitMask = wallCategory;
    topLeft.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:topLeft];
    
    SKSpriteNode *bottomRight = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 700)];
    [bottomRight setPosition:CGPointMake(630, 150)]; //Vertical bottom right line
    bottomRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomRight.frame.size];
    bottomRight.physicsBody.dynamic =  NO;
    bottomRight.physicsBody.categoryBitMask = wallCategory;
    bottomRight.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:bottomRight];
    
    SKSpriteNode *bottomMiddle2 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(330, 8)];
    [bottomMiddle2 setPosition:CGPointMake(305, 230)]; //Horizontal middle bottom 2 line
    bottomMiddle2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomMiddle2.frame.size];
    bottomMiddle2.physicsBody.dynamic =  NO;
    bottomMiddle2.physicsBody.categoryBitMask = wallCategory;
    bottomMiddle2.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:bottomMiddle2];
    
    SKSpriteNode *bottomMiddle1 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(330, 8)];
    [bottomMiddle1 setPosition:CGPointMake(465, 110)]; //Horizontal middle bottom 1 line
    bottomMiddle1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomMiddle1.frame.size];
    bottomMiddle1.physicsBody.dynamic =  NO;
    bottomMiddle1.physicsBody.categoryBitMask = wallCategory;
    bottomMiddle1.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:bottomMiddle1];
    
    SKSpriteNode *leftMiddle = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 500)];
    [leftMiddle setPosition:CGPointMake(270, 600)]; //Vertical middle left line
    leftMiddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:leftMiddle.frame.size];
    leftMiddle.physicsBody.dynamic =  NO;
    leftMiddle.physicsBody.categoryBitMask = wallCategory;
    leftMiddle.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:leftMiddle];
    
    SKSpriteNode *topMiddle1 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(380, 8)];
    [topMiddle1 setPosition:CGPointMake(456, 847)]; //Horizontal top middle line
    topMiddle1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topMiddle1.frame.size];
    topMiddle1.physicsBody.dynamic =  NO;
    topMiddle1.physicsBody.categoryBitMask = wallCategory;
    topMiddle1.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:topMiddle1];
    
    SKSpriteNode *topMiddle2 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 250)];
    [topMiddle2 setPosition:CGPointMake(385, 620)]; //Vertical top middle line
    topMiddle2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topMiddle2.frame.size];
    topMiddle2.physicsBody.dynamic =  NO;
    topMiddle2.physicsBody.categoryBitMask = wallCategory;
    topMiddle2.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:topMiddle2];
    
    SKSpriteNode *middleRight1 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(250, 8)];
    [middleRight1 setPosition:CGPointMake(506, 745)]; //Horizontal middle right line
    middleRight1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:middleRight1.frame.size];
    middleRight1.physicsBody.dynamic =  NO;
    middleRight1.physicsBody.categoryBitMask = wallCategory;
    middleRight1.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:middleRight1];
    
    SKSpriteNode *middleRight2 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(250, 8)];
    [middleRight2 setPosition:CGPointMake(505, 496)]; //Horizontal middle lower right line
    middleRight2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:middleRight2.frame.size];
    middleRight2.physicsBody.dynamic =  NO;
    middleRight2.physicsBody.categoryBitMask = wallCategory;
    middleRight2.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:middleRight2];
    
    SKSpriteNode *rightMiddle = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(250, 8)];
    [rightMiddle setPosition:CGPointMake(645, 620)]; //Horizontal middle lower right line
    rightMiddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rightMiddle.frame.size];
    rightMiddle.physicsBody.dynamic =  NO;
    rightMiddle.physicsBody.categoryBitMask = wallCategory;
    rightMiddle.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:rightMiddle];
    
    SKSpriteNode *bottomMiddle3 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(250, 8)];
    [bottomMiddle3 setPosition:CGPointMake(391, 350)]; //Horizontal right middle line
    bottomMiddle3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomMiddle3.frame.size];
    bottomMiddle3.physicsBody.dynamic =  NO;
    bottomMiddle3.physicsBody.categoryBitMask = wallCategory;
    bottomMiddle3.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:bottomMiddle3]; */
}


-(void) addHoles:(CGSize) size
{
    /*float radius = 32;
    SKShapeNode *hole1 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
    CGPoint ballPoint1 = CGPointMake(35,510);
    hole1.position = ballPoint1;
    hole1.fillColor = [SKColor grayColor]; //Right after start left corner
    hole1.strokeColor = [SKColor blackColor]; //Hole 1
    hole1.physicsBody.categoryBitMask = holeCategory;
    hole1.physicsBody.collisionBitMask = 0;
    hole1.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:hole1];
    
    SKShapeNode *hole2 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
    CGPoint ballPoint2 = CGPointMake(230,510);
    hole2.position = ballPoint2;
    hole2.fillColor = [SKColor grayColor]; //Right after start right corner
    hole2.strokeColor = [SKColor blackColor]; //Hole 2
    hole2.physicsBody.categoryBitMask = holeCategory;
    hole2.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:hole2];
    
    SKShapeNode *hole3 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
    CGPoint ballPoint3 = CGPointMake(180,910);
    hole3.position = ballPoint3;
    hole3.fillColor = [SKColor grayColor]; //Upper left corner third turn
    hole3.strokeColor = [SKColor blackColor]; //Hole 3
    hole3.physicsBody.categoryBitMask = holeCategory;
    hole3.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:hole3];
    
    SKShapeNode *hole4 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
    CGPoint ballPoint4 = CGPointMake(730,910);
    hole4.position = ballPoint4;
    hole4.fillColor = [SKColor grayColor]; //Upper right corner
    hole4.strokeColor = [SKColor blackColor]; //Hole 4
    hole4.physicsBody.categoryBitMask = holeCategory;
    hole4.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:hole4];
    
    SKShapeNode *hole5 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
    CGPoint ballPoint5 = CGPointMake(310,390);
    hole5.position = ballPoint5;
    hole5.fillColor = [SKColor grayColor]; //Middle left corner
    hole5.strokeColor = [SKColor blackColor]; //Hole 5
    hole5.physicsBody.categoryBitMask = holeCategory;
    hole5.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:hole5];
    
    SKShapeNode *hole6 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
    CGPoint ballPoint6 = CGPointMake(590,455);
    hole6.position = ballPoint6;
    hole6.fillColor = [SKColor grayColor]; //Middle right corner
    hole6.strokeColor = [SKColor blackColor]; //Hole 6
    hole6.physicsBody.categoryBitMask = holeCategory;
    hole6.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:hole6];
    
    SKShapeNode *hole7 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
    CGPoint ballPoint7 = CGPointMake(590,150);
    hole7.position = ballPoint7;
    hole7.fillColor = [SKColor grayColor];
    hole7.strokeColor = [SKColor blackColor]; //Hole 7
    hole7.physicsBody.categoryBitMask = holeCategory;
    hole7.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:hole7];
    
    SKShapeNode *hole8 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
    CGPoint ballPoint8 = CGPointMake(180,190);
    hole8.position = ballPoint8;
    hole8.fillColor = [SKColor grayColor];
    hole8.strokeColor = [SKColor blackColor]; //Hole 8
    hole8.physicsBody.categoryBitMask = holeCategory;
    hole8.physicsBody.contactTestBitMask = wallCategory | ballCategory;
    [self addChild:hole8]; */
}

-(void) addNodes:(CGSize) size
{
    /*float radius = 28;
    SKNode *hole1 = [SKNode node];
    hole1.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
    CGPoint ballPoint1 = CGPointMake(35,510);
    hole1.position = ballPoint1;
    hole1.physicsBody.categoryBitMask = hole2Category;
    [self addChild: hole1];
    
    SKNode *hole2 = [SKNode node];
    CGPoint ballPoint2 = CGPointMake(230,510);
    hole2.position = ballPoint2;
    hole2.physicsBody.categoryBitMask = hole2Category;
    [self addChild: hole2];
    
    SKNode *hole3 = [SKNode node];
    CGPoint ballPoint3 = CGPointMake(180,910);
    hole3.position = ballPoint3;
    hole3.physicsBody.categoryBitMask = hole2Category;
    [self addChild: hole3];
    
    SKNode *hole4 = [SKNode node];
    hole4.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
    CGPoint ballPoint4 = CGPointMake(730,910);
    hole4.position = ballPoint4;
    hole4.physicsBody.categoryBitMask = hole2Category;
    [self addChild: hole4];
    
    SKNode *hole5 = [SKNode node];
    hole5.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
    CGPoint ballPoint5 = CGPointMake(310,390);
    hole5.position = ballPoint5;
    hole5.physicsBody.categoryBitMask = hole2Category;
    [self addChild: hole5];
    
    SKNode *hole6 = [SKNode node];
    hole6.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
    CGPoint ballPoint6 = CGPointMake(590,455);
    hole6.position = ballPoint6;
    hole6.physicsBody.categoryBitMask = hole2Category;
    [self addChild: hole6];
    
    SKNode *hole7 = [SKNode node];
    hole7.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
    CGPoint ballPoint7 = CGPointMake(590,150);
    hole7.position = ballPoint7;
    hole7.physicsBody.categoryBitMask = hole2Category;
    [self addChild: hole7];
    
    SKNode *hole8 = [SKNode node];
    hole8.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
    CGPoint ballPoint8 = CGPointMake(180,190);
    hole8.position = ballPoint8;
    hole8.physicsBody.categoryBitMask = hole2Category;
    [self addChild: hole8];
    
    SKNode *endBox = [SKNode node];
    endBox.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0,100) toPoint:CGPointMake(140, 100)];
    endBox.physicsBody.categoryBitMask = winCategory;
    [self addChild: endBox]; */
    
}

- (void)startGame
{
    self.ball.hidden = NO;   //reset ball position for new game
    self.ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.ball.frame.size.width/2];
    CGPoint ballPoint = CGPointMake(75,875);
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
