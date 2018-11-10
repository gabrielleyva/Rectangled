//
//  MyScene.m
//  Ball Drop Test
//
//  Created by Connor Mounts on 5/17/14.
//  Copyright (c) 2014 Lykos Technologies LLC. All rights reserved.
//

#import "MyScene.h"
#import "MainMenu.h"
#import "WorldScreen.h"

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface MyScene() <SKPhysicsContactDelegate>


typedef enum: int{
    left,
    mid,
    right,
}cupSide;

@end
static const uint32_t cupCatagory = 1;
static const uint32_t ballCatagory = 2;
static const uint32_t blueRecCatagory = 4;
static const uint32_t redRecCatagory = 8;
static const uint32_t purpleRecCatagory = 16;
static const uint32_t orangeRecCatagory = 32;
static const uint32_t yellowRecCatagory = 64;
static const uint32_t greenRecCatagory = 128;
static const uint32_t keyCatagory = 256;

@implementation MyScene {
    
    SKLabelNode *tapBall2;
    SKLabelNode *tapBall;
    SKLabelNode *moveRecs;
    SKLabelNode *clickRecButton;
    SKSpriteNode *ball;
    SKSpriteNode *cup;
    SKSpriteNode *start;
    SKSpriteNode *back;
    SKSpriteNode *key;
    SKSpriteNode *backGround;
    SKSpriteNode *secondGreenRec;
    SKNode *standardBackground;
    SKNode *objectHolder;
    SKNode *whiteRecs;
    long whatLevel;
    long levelUnlock;
    //NSString *nodeTouch;
    BOOL didHit;
    BOOL gameStart;
    BOOL keyHit;
    bool sliderHit;
    bool ballHit;
    bool recHit;
    BOOL gravitySwitched;
    bool scaleSwitched;
    bool rotated;
    BOOL firstTime;
    float yellowStarting;
    CGPoint ballStart;
    BOOL click;
    BOOL move;
    BOOL tap;
    
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
        
        if (self.size.width == 768) {
            backGround = [ SKSpriteNode spriteNodeWithImageNamed:@"IpadBackground"];
            self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(64, 32, 640, 960)];
            
        }
        
        else
        {
        backGround = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size: CGSizeMake(self.size.width, self.size.height)];
            self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];

        }
        backGround.position = CGPointMake(self.size.width/2, self.size.height/2);
        backGround.zPosition = -3;
        backGround.name = @"backGround";
        [self addChild:backGround];
        
        self.physicsWorld.contactDelegate = self;
        self.physicsBody.affectedByGravity= NO;
        self.name = @"screen";
        objectHolder = [SKNode node];
        standardBackground = [SKNode node];
        whiteRecs = [SKNode node];
        didHit = NO;
        whatLevel = [[NSUserDefaults standardUserDefaults] integerForKey: @"nextLevel"];
        levelUnlock = [[NSUserDefaults standardUserDefaults] integerForKey: @"levelUnlock"];
        keyHit = NO;
        scaleSwitched = NO;
        rotated = NO;
        if (self.size.height == 568) {
            ballStart = CGPointMake(160, 548);
        }
        else
        {
            
            ballStart = [self convertPoint:CGPointMake(160, 460)];
        }
        click = YES;
        move = NO;
        tap = NO;
        gravitySwitched = NO;
        NSLog(@"Level Unlock: %li", levelUnlock);
       //levelUnlock = 100;
        //[self saveLevelUnlock];
    }
    return self;
}

- (CGPoint)convertPoint:(CGPoint)point
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        NSLog(@"converting");
        return CGPointMake(64 + point.x*2, 32 + point.y*2);
        
    } else {
        return point;
    }
}

-(void)saveScore {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:whatLevel forKey:@"nextLevel"];
    [defaults synchronize];
}
-(void)saveLevelUnlock {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:levelUnlock forKey:@"levelUnlock"];
    [defaults synchronize];
}


-(void)callLevel:(int)numLevel {
    gameStart = YES;
    whatLevel = numLevel;
    switch (numLevel) {
        case 11:
            [self level11];
            break;
        case 12:
            [self level12];
            break;
        case 13:
            [self level13];
            break;
        case 14:
            [self level14];
            break;
        case 15:
            [self level15];
            break;
        case 21:
            [self level21];
            break;
        case 22:
            [self level22];
            break;
        case 23:
            [self level23];
            break;
        case 24:
            [self level24];
            break;
        case 25:
            [self level25];
            break;
        case 31:
            [self level31];
            break;
        case 32:
            [self level32];
            break;
        case 33:
            [self level33];
            break;
        case 34:
            [self level34];
            break;
        case 35:
            [self level35];
            break;
        case 41:
            [self level41];
            break;
        case 42:
            [self level42];
            break;
        case 43:
            [self level43];
            break;
        case 44:
            [self level44];
            break;
        case 45:
            [self level45];
            break;
        case 51:
            [self level51];
            break;
        case 52:
            [self level52];
            break;
        case 53:
            [self level53];
            break;
        case 54:
            [self level54];
            break;
        case 55:
            [self level55];
            break;
        case 61:
            [self level61];
            break;
        case 62:
            [self level62];
            break;
        case 63:
            [self level63];
            break;
        case 64:
            [self level64];
            break;
        case 65:
            [self level65];
            break;
        case 66:
            [self gameOver];
            break;

        default:
            break;
    }

}


-(void)level11 {
    
    
    clickRecButton = [SKLabelNode labelNodeWithFontNamed:@"Copperplate"];
    clickRecButton.fontSize = self.size.height/35;
    clickRecButton.text = @"Tap Slide For Rectangles";
    clickRecButton.fontColor = [UIColor cyanColor];
    clickRecButton.position = CGPointMake(self.size.width/2, (self.size.height/1.2));
    [self addChild:clickRecButton];
    clickRecButton.hidden = NO;
    
    moveRecs = [SKLabelNode labelNodeWithFontNamed:@"CopperPlate"];
    moveRecs.fontSize = self.size.height/35;
    moveRecs.text = @"Drag Rectangle To Desired Location";
    moveRecs.fontColor = [UIColor cyanColor];
    moveRecs.position = CGPointMake(self.size.width/2, (self.size.height/1.2));
    [self addChild:moveRecs];
    moveRecs.hidden = YES;
    
    tapBall = [SKLabelNode labelNodeWithFontNamed:@"CoppperPlate"];
    tapBall.fontSize = self.size.height/35;
    tapBall.text =  @"Tap Ball To Begin";
    tapBall.fontColor = [UIColor cyanColor];
    tapBall.position = CGPointMake(self.size.width/2, (self.size.height/1.2));
    [self addChild:tapBall];
    tapBall.hidden = YES;
    
    tapBall2 = [SKLabelNode labelNodeWithFontNamed:@"CoppperPlate"];
    tapBall2.fontSize = self.size.height/35;
    tapBall2.text =  @"Double Tap Screen To Reset Ball";
    tapBall2.fontColor = [UIColor cyanColor];
    tapBall2.position = CGPointMake(self.size.width/2, (self.size.height/1.2)-(self.size.height/24));
    [self addChild:tapBall2];
    tapBall2.hidden = YES;

    [self.MLDelegate hideAllButtons];
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:blue];
    
    [self createCup:[self convertPoint:CGPointMake(292 , 29.5)]];
    [self createKey:[self convertPoint:CGPointMake(78.5 , 52)]];
    [self addChild:[self createBackground]];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(258.5 , 58.5)] withName:@"w1"];
    [self addChild:[self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(151 , 58.499992)] withName:@"w2"]];
    
  
    
    
}
-(void)level12 {
    if (levelUnlock<1) {
        levelUnlock++;
        [self saveLevelUnlock];
        
    }
    [self.MLDelegate hideAllButtons];
    [self.MLDelegate addRecsToSlider:-45 HowMany:3 whatColor:blue];
    [self.MLDelegate addRecsToSlider:45 HowMany:2 whatColor:blue];
    
    [self createCup:[self convertPoint:CGPointMake(289.5, 32)]];
    [self createKey:[self convertPoint:CGPointMake(107.5, 307.5)]];
    [self addChild:[self createBackground]];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(57.5, 377.5)] withName:@"w1"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(156.500015, 377.5)] withName:@"w2"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(270.5, 274.5)] withName:@"w3"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(166, 274.5)] withName:@"w4"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(52, 154.5)] withName:@"w5"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(167, 154.5)] withName:@"w6"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(266.5 , 62.5)] withName:@"w7"];
    [self addChild:[self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(185,  62.500011)] withName:@"w8"]];
    
    [self.MLDelegate updateAchievements];
    
}
-(void)level13 {
    if (levelUnlock<2) {
        levelUnlock++;
        [self saveLevelUnlock];
        
    }
    [self.MLDelegate hideAllButtons];
    [self createCup:[self convertPoint:CGPointMake(45, 41.999992)]];
    [self createKey:[self convertPoint:CGPointMake(205, 370.5)]];
    
    [self addChild:[self createBackground]];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(86.5, 77)]withName:@"w1"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(117.500008, 156.5)]withName:@"w2"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(158.500015, 317.500061)]withName:@"w3"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(239,320.500061 ) ]withName:@"w4"];
    [self addChild:[self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(260.5, 56.999989)]withName:@"w5"]];
    
    [self.MLDelegate addRecsToSlider:-45 HowMany:2 whatColor:blue];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:blue];
    
}
-(void)level14 {
    if (levelUnlock<3) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    
    [self.MLDelegate hideAllButtons];
    [self createCup:[self convertPoint:CGPointMake(47.5, 41.999992)]];
    [self createKey:[self convertPoint:CGPointMake(153.5, 101)]];
    
    [self addChild:[self createBackground]];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(86, 80.5)]withName:@"w1"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(70.5, 117.500015)]withName:@"w2"];
    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(188, 321.5)]withName:@"w3"] ;
    [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(134.5, 321.000061)]withName:@"w4"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(250.500031, 39.000008)]withName:@"w5"];
    [self addChild:[self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(184, 425.000031)]withName:@"w6"]];
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:blue];
}
-(void)level15 {
    if (levelUnlock<4) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    [self.MLDelegate hideAllButtons];
    [self createCup:[self convertPoint:CGPointMake(158.500031, 30.499992)]];
    [self createKey:[self convertPoint:CGPointMake(114, 73.499992)]];
    
    [self addChild:[self createBackground]];
    
    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(189, 401.5)]withName:@"w1"];
    [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(136, 402)]withName:@"w2"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(218, 375)]withName:@"w3"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(103, 376)]withName:@"w4"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(1, 325.000092)]withName:@"w5"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(306, 321.000061)]withName:@"w6"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(159.000015, 327.499969)]withName:@"w7"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(180.5, 121.500008)] withName:@"w9"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(133.5, 121.500008)] withName:@"w10"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(260, 182.499985)] withName:@"w11"];
    
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(261, 3.500004)] withName:@"w14"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(63.000008, 18.000011)] withName:@"w15"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(120, 265.000031)] withName:@"w16"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(30, 194.500015)] withName:@"w17"];
    [self addChild:[self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(159.500031, 200.000046)]withName:@"w8"]];
    
    [self.MLDelegate addRecsToSlider:-45 HowMany:3 whatColor:blue];
    [self.MLDelegate addRecsToSlider:45 HowMany:2 whatColor:blue];
    [self.MLDelegate addRecsToSlider:0 HowMany:2 whatColor:blue];
    
    ;
    
    
    
}

-(void)level21 {
    if (levelUnlock<5) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    [self.MLDelegate hideAllButtons];
    [self createCup:[self convertPoint:CGPointMake(69.5, 86)]];
    [self createKey:[self convertPoint:CGPointMake(273.5, 400)]];
    
    [self addChild:[self createBackground]];
    
    
    [ball runAction:[SKAction moveTo:[self convertPoint:CGPointMake(76.5, 418.5)] duration:1]];
    ballStart = [self convertPoint:CGPointMake(76.5, 418.5)];
    
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(191.5, 118.499992)] withName:@"w1"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(39.000004, 118.999985)] withName:@"w2"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(118, 140.5)] withName:@"w3"];
    //[self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(118, 379)] withName:@"w9"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(196.500031, 196.000031)] withName:@"w4"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(118, 453)] withName:@"w5"];
    
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(197.000015, 157.000015)] withName:@"w7"];
    //[self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(198.000046, 473.500000)] withName:@"w9"];
    [self addChild: [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(198.000046, 473.500000)] withName:@"w9"]];
    
    
    
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:-45 HowMany:2 whatColor:red];
    [self.MLDelegate updateAchievements];
    
    
}
-(void)level22 {
    [self.MLDelegate hideAllButtons];
    if (levelUnlock<6) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    [self createCup:[self convertPoint:CGPointMake(33, 105.500008)]];
    [self createKey:[self convertPoint:CGPointMake(102.5, 263.5)]];
    
    [self addChild:[self createBackground]];
    
    
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(174.500015, 402.5)] withName:@"w1"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(103.5, 317.000061)] withName:@"w2"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(25.5, 402.5)] withName:@"w3"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(211.500015, 438.5)] withName:@"w4"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(72.5, 117.500023)] withName:@"w5"];
    
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(17.5, 75)] withName:@"w8"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(38, 228.000015)]withName:@"w9"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(153.5, 228.000015)] withName:@"w10"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(231.500015, 251.500015)] withName:@"w11"];
    [self addChild:[self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(166.5, 146.5)] withName:@"w12"]];
    
    [self.MLDelegate addRecsToSlider:45 HowMany:2 whatColor:blue];
    [self.MLDelegate addRecsToSlider:-45 HowMany:2 whatColor:blue];
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:red];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:red];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:red];
    
}
-(void)level23 {
    [self.MLDelegate hideAllButtons];
    if (levelUnlock<7) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    [self createCup:[self convertPoint:CGPointMake(198.5, 302)]];
    [self createKey:[self convertPoint:CGPointMake(64, 138.000015)]];
    
    [self addChild:[self createBackground]];
    
    [ball runAction:[SKAction moveTo:[self convertPoint:CGPointMake(35.5, 415)] duration:1]];
    ballStart = [self convertPoint:CGPointMake(35.5, 415)];
    
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(198.000015, 417.5)] withName:@"w1"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(199, 264)] withName:@"w2"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(16.5, 309)] withName:@"w3"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(217.5, 19.499989)] withName:@"w4"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(160.500031, 286.5)] withName:@"w5"];
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(107.500015, 363)] withName:@"w6"];
    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(186.5, 163.5)] withName:@"w8"];
    
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(160.500031, 226.000015)] withName:@"w10"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(235.500046, 340.5)] withName:@"w11"];
    [self addChild:[self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(119, 53.500015)] withName:@"w12"]];
    
    
    [self.MLDelegate addRecsToSlider:45 HowMany:2 whatColor:red];
    [self.MLDelegate addRecsToSlider:-45 HowMany:2 whatColor:red];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:red];
    
    
}
-(void)level24 {
    [self.MLDelegate hideAllButtons];
    if (levelUnlock<8) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    [self createCup:[self convertPoint:CGPointMake(35.5, 112)]];
    [self createKey:[self convertPoint:CGPointMake(283.500031, 263.5)]];
    
    [self addChild:[self createBackground]];
    
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(109.5, 77.500008)] withName:@"w1"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(174.000015, 248.000015)] withName:@"w2"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(34, 152.000015)] withName:@"w3"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(146, 114.500008)] withName:@"w4"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(72.5, 115.500008)] withName:@"w5"];
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(40.5, 296.5)] withName:@"w6"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(72.5, 142)] withName:@"w8"];
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(119.5, 375)] withName:@"w9"];
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(265.5, 304)] withName:@"w12"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(249.000015, 65.500015)] withName:@"w13"];
    [self addChild:[self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(167.5, 281)] withName:@"w10"]];
    
    [self.MLDelegate addRecsToSlider:-45 HowMany:2 whatColor:blue];
    [self.MLDelegate addRecsToSlider:45 HowMany:2 whatColor:blue];
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:red];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:red];
}
-(void)level25 {
    [self.MLDelegate hideAllButtons];
    if (levelUnlock<9) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    [self createCup:[self convertPoint:CGPointMake(32.5, 113)]];
    [self createKey:[self convertPoint:CGPointMake(83.5, 230)]];
    
    [self addChild:[self createBackground]];
    [ball runAction:[SKAction moveTo:[self convertPoint:CGPointMake(80, 400)] duration:1]];
    ballStart = [self convertPoint:CGPointMake(80, 400)];
    
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(261.5, 18.5)] withName:@"w8"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(118.5, 2.5)] withName:@"w1"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(36, 88)] withName:@"w2"];
    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(176.000015, 78.500008)] withName:@"w3"];
    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(307.5, 349.5)] withName:@"w4"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(150.5 , 142)] withName:@"w5"];
    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(234.5, 422.5)] withName:@"w6"];
    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(142.5, 514.5) ]withName:@"w9"];
    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(130.5, 309.5)] withName:@"w11"];
    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(44, 396) ]withName:@"w12"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(72, 178.5) ]withName:@"w13"];
    [self addChild:[self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(150, 341)] withName:@"w10"]];
    
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:red];
    [self.MLDelegate addRecsToSlider:-45 HowMany:2 whatColor:red];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:red];
    
    
    
    
}

-(void)level31 {
    [self.MLDelegate hideAllButtons];
    if (levelUnlock<10) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    [self createCup:[self convertPoint:CGPointMake(37.5, 37.5)]];
    [self createKey:[self convertPoint:CGPointMake(160, 237.5)]];
    [self addChild:[self createBackground]];
    
    //[self createWhiteRectangle:smallRec withAngle:90 withPosition:CGPointMake(100,100) withName:@"w8"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(176.500031, 22.999996)] withName:@"w1"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(105.5,80)] withName:@"w2"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(37.5,80)] withName:@"w3"];
    //[self createWhiteRectangle:smallRec withAngle:-45 withPosition:CGPointMake(100,100) withName:@"w4"];
    //[self createWhiteRectangle:smallRec withAngle:90 withPosition:CGPointMake(100,100) withName:@"w5"];
    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(62.500008, 292.500031)] withName:@"w6"];
    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(201.5,293.5)] withName:@"w9"];
    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(116.000008, 375.500000)] withName:@"w11"];
    [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(115.500008, 291.5)] withName:@"w12"];
    [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(253.000046, 293)] withName:@"w13"];
    [self addChild:[self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(201.5, 375)] withName:@"w10"]];
    
    [self.MLDelegate addRecsToSlider:-45 HowMany:2 whatColor:purple];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:blue];
    [self.MLDelegate updateAchievements];
    
    
    
    
    
}
-(void)level32 {
    [self.MLDelegate hideAllButtons];
    if (levelUnlock<11) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    [self createCup:[self convertPoint:CGPointMake(281.5, 116)]];
    [self createKey:[self convertPoint:CGPointMake(33, 53)]];
    [self addChild:[self createBackground]];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(148.5, 155.500015)] withName:@"w1"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(130.5, 377)] withName:@"w2"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(32.5,108.5)] withName:@"w3"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(186.5,117.5)] withName:@"w4"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(218, 258.500031)] withName:@"w5"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(35.5, 335)] withName:@"w6"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(209.5,340)] withName:@"w9"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(112,258.5)] withName:@"w11"];
    [self addChild:[self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(277, 172.000015)] withName:@"w10"]];
    
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:-45 HowMany:2 whatColor:red];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:red];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:purple];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:red];
    
    
    
}
-(void)level33 {
    [self.MLDelegate hideAllButtons];
    if (levelUnlock<12) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    [self createCup:[self convertPoint:CGPointMake(209, 40.5)]];
    [self createKey:[self convertPoint:CGPointMake(121, 363.5)]];
    [self addChild:[self createBackground]];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(303.5, 252.499985)] withName:@"w8"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(297, 411.5)] withName:@"w1"];
    [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(233.500031, 385.000031)] withName:@"w2"];
    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(180, 383.5)] withName:@"w3"];
    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(177.000031, 274.5)] withName:@"w4"];
    [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(231.500031, 275.500031)] withName:@"w5"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(149.5,224)] withName:@"w6"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(78.5,332)] withName:@"w9"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(116.500015, 409.000000)] withName:@"w12"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(150, 75.5)] withName:@"w13"];
    [self addChild:[self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(236,36)] withName:@"w10"]];
    
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:45 HowMany:3 whatColor:blue];
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:red];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:red];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:purple];
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:purple];
    
    
    
}
-(void)level34 {
    [self.MLDelegate hideAllButtons];
    if (levelUnlock<13) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    [self createCup:[self convertPoint:CGPointMake(84.5, 18.9)]];
    [self createKey:[self convertPoint:CGPointMake(144.5, 334)]];
    [self addChild:[self createBackground]];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(169.5, 113.000008)] withName:@"w3"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(275.5, 26)] withName:@"w14"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(108.5, 196.500031)] withName:@"w15"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint: CGPointMake(205.5, 76.000008)] withName:@"w17"];
    
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(137.5, 233.000031)] withName:@"w4"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(174.500015, 484)] withName:@"w5"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(47, 74.500008)] withName:@"w9"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(61.5, 353.000061)] withName:@"w11"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(213.000031, 309.5)] withName:@"w12"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(79.000008, 484)] withName:@"w13"];
    [self addChild:[self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(128, 72.5)] withName:@"w10"]];
    
    [self.MLDelegate addRecsToSlider:-45 HowMany:2 whatColor:blue];
    [self.MLDelegate addRecsToSlider:45 HowMany:2 whatColor:blue];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:red];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:purple];
    
    
}
-(void)level35 {
    [self.MLDelegate hideAllButtons];
    if (levelUnlock<14) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    [self createCup:[self convertPoint:CGPointMake(189, 294)]];
    [self createKey:[self convertPoint:CGPointMake(100, 201)]];
    [self addChild:[self createBackground]];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(132, 206.5)] withName:@"w8"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(209.5, 113)] withName:@"w2"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(152, 73.499992)] withName:@"w3"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(146.5, 330)] withName:@"w4"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(228, 254.5)] withName:@"w5"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(73.5, 63.999996)] withName:@"w6"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(68.5, 323.5)] withName:@"w9"];
    [self addChild:[self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(144.5, 246)] withName:@"w11"]];
    
    [self.MLDelegate addRecsToSlider:0 HowMany:2 whatColor:red];
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:red];
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:purple];
    
    
    
    
}

-(void)level41 {
   
    if (levelUnlock<15) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    
    
    [self.MLDelegate hideAllButtons];
    [self.MLDelegate addRecsToSlider:45 HowMany:2 whatColor:blue];
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:orange];
    [self.MLDelegate addRecsToSlider:-45 HowMany:2 whatColor:purple];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:orange];
    [self.MLDelegate updateAchievements];

    
    
    
    [self createCup:[self convertPoint:CGPointMake(160.5, 233.5)]];
    [self createKey:[self convertPoint:CGPointMake(105, 26.5)]];
[self addChild:[self createBackground]];
    
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(89.500015, 130.500015)] withName:@"w1"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(245, 129)] withName:@"w4"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(88.5, 285) ]withName:@"w5"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(244.5, 285)] withName:@"w6"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(166, 361.5)] withName:@"w7"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(166, 53)] withName:@"w8"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(129, 53)] withName:@"w9"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(166, 121.5)] withName:@"w10"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(205.5, 121.5)] withName:@"w11"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(202, 234)] withName:@"w13"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(163, 271)] withName:@"w14"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(129, 196.5)] withName:@"w15"];
    [self addChild:[self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(163.5,196.5)] withName:@"w16"]];

    
}
-(void)level42 {
    if (levelUnlock<16) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    [self.MLDelegate hideAllButtons];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:red];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:purple];
 
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:orange];
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:purple];


    
    
    [self createCup:[self convertPoint:CGPointMake (264.5, 397)]];
    [self createKey:[self convertPoint:CGPointMake (34.5, 182.5)]];
[self addChild:[self createBackground]];
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(87.500008 , 166.500000)] withName:@"w1"];
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(205 , 191.5)] withName:@"w4"];
    
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(203 , 397)] withName:@"w6"];
    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(175.5 , 273.5)] withName:@"w7"];
    [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(124 , 110)] withName:@"w8"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(64.5 , 260.5)] withName:@"w9"];
   
    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(93.5 , 356.000061)] withName:@"w11"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(203.5 , 285)] withName:@"w13"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(102 , 221)] withName:@"w14"];
   
    [self addChild:[self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(191 , 140.5)] withName:@"w16"]];

  

    
}
-(void)level43 {
    if (levelUnlock<17) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    [self.MLDelegate hideAllButtons];

    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:-45 HowMany:2 whatColor:blue];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:orange];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:red];

    
    
    [self createCup:[self convertPoint:CGPointMake(264.5, 404.5)]];
    [self createKey:[self convertPoint:CGPointMake(29, 109.5)]];
[self addChild:[self createBackground]];
    
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(226.5,18) ]withName:@"w1"];
        [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(209.5,221.5)] withName:@"w3"];
    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(110,84)] withName:@"w4"];
  
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(203,448)] withName:@"w6"];
  
  
    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(124,177)] withName:@"w10"];
   
 
    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(117.5,275)] withName:@"w13"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(289.5,307) ]withName:@"w14"];
    [self addChild:[self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(147,356)] withName:@"w15"]];

    
       }
-(void)level44 {
    if (levelUnlock<18) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    [self.MLDelegate hideAllButtons];
    
    
   
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:purple];
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:orange];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:red];
    
    
    
    [self createCup:[self convertPoint:CGPointMake(294.5, 400)]];
    [self createKey:[self convertPoint:CGPointMake(21, 204.000000)]];
    [self addChild:[self createBackground]];
    
    
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(189.000000 , 115.500015)]  withName:@"w2"];
    
    [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(36.5 , 116)]withName:@"w8"];
        [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(2.500000 , 82.000008)]withName:@"w10"];
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(135.000000 , 345.000000)] withName:@"w11"];
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(200 , 250.500031)] withName:@"w12"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(141.500000 , 75.000000)] withName:@"w13"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(241.500000 , 75.000000)] withName:@"w14"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(255.000000 , 227)] withName:@"w15"];
    [self addChild:[self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(143.500000 , 272.500031)] withName:@"w16"]];
    
    
}
-(void)level45 {
    if (levelUnlock<19) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    [self.MLDelegate hideAllButtons];

    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:red];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:red];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:orange];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:orange];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:blue];
   
    
    
    [self createCup:[self convertPoint:CGPointMake(231.5, 27.5)]];
    [self createKey:[self convertPoint:CGPointMake(284, 426)]];
[self addChild:[self createBackground]];
    

    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(228,156)] withName:@"w3"];

    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(265,195)] withName:@"w5"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(112,369)] withName:@"w6"];
    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(283.5,35.5)] withName:@"w7"];
    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(48,221.5)] withName:@"w8"];
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(207.5,424.5)] withName:@"w9"];
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(195.5,338.5)] withName:@"w10"];
   
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(150.5,90)] withName:@"w12"];
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(159,223.5)] withName:@"w13"];

    [self addChild:[self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(127.5,344.5)] withName:@"w15"]];

    
}

-(void)level51 {
    if (levelUnlock<20) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    
    [self.MLDelegate hideAllButtons];

    [self.MLDelegate addRecsToSlider:45 HowMany:3 whatColor:red];
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:red];
    [self.MLDelegate addRecsToSlider:-45 HowMany:2 whatColor:blue];
    [self.MLDelegate addRecsToSlider:0 HowMany:2 whatColor:orange];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:blue];
    [self.MLDelegate updateAchievements];
    

    
    
    [self createCup:[self convertPoint:CGPointMake(212.5, 116)]];
    [self createKey:[self convertPoint:CGPointMake(182, 343)]];
[self addChild:[self createBackground]];
    
    
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(166.5,16.5) ]withName:@"w3"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(123,113) ]withName:@"w4"];
   

    [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(84,252)] withName:@"w7"];

    [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(75.5,27.5)] withName:@"w8"];

    [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(187.5,141)] withName:@"w9"];

    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(104.5,219.5)] withName:@"w10"];

    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(158,166)] withName:@"w11"];

    
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(211,276.5)] withName:@"w12"];
    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(268,113.5)] withName:@"w13"];
    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(154,318)] withName:@"w14"];
    
    [self addChild:[self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(178,373)] withName:@"w15"]];

  
    

   
    
}
-(void)level52 {
    if (levelUnlock<21) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    [self.MLDelegate hideAllButtons];

    
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:yellow];
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:red];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:red];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:purple];
    
    
    
    
    [self createCup:[self convertPoint:CGPointMake(26.5, 24)]];
    [self createKey:[self convertPoint:CGPointMake(179.5, 205)]];
[self addChild:[self createBackground]];
    
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(61,1)] withName:@"w1"];
  
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(211,124)] withName:@"w4"];

    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(58,129)] withName:@"w7"];
    [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(199,74)] withName:@"w8"];
    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(118,178)] withName:@"w9"];
    [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(249,124)] withName:@"w10"];
    
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(167,238)] withName:@"w12"];
 
  
    [self addChild:[self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(159,311)] withName:@"w16"]];

    
}
-(void)level53 {
    if (levelUnlock<22) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    
    [self.MLDelegate hideAllButtons];

    
    [self.MLDelegate addRecsToSlider:45 HowMany:2 whatColor:blue];
    [self.MLDelegate addRecsToSlider:-45 HowMany:2 whatColor:red];
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:red];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:orange];
    

    
    
    
    [self createCup:[self convertPoint:CGPointMake(148.5, 258)]];
    [self createKey:[self convertPoint:CGPointMake(41, 389.5)]];
[self addChild:[self createBackground]];
    

    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(72.5 , 162.5) ]withName:@"w5"];
    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(124, 110.5) ]withName:@"w6"];
    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(157 , 203.5)]withName:@"w7"];
    [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(185.000000 , 231)]  withName:@"w8"];
    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(266.000000 , 312.000031) ]withName:@"w9"];
    [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(127.5,379.5)] withName:@"w10"];
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(206.500000 , 139.000000)]withName:@"w11"];
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(157 , 311.5) ]withName:@"w12"];

    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(25,353.5)] withName:@"w14"];
    
    [self addChild:[self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(244.000000 , 1.999998)] withName:@"w16"]];

    
}
-(void)level54 {
    if (levelUnlock<23) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    
    
    [self.MLDelegate hideAllButtons];

    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:purple];
      [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:orange];
      [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:blue];
      [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:red];

    
    
    
    [self createCup:[self convertPoint:CGPointMake(121.500000, 297.000000)]];
    [self createKey:[self convertPoint:CGPointMake(260.5, 95)]];
[self addChild:[self createBackground]];
    
   
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(113.5 , 35.5)] withName:@"w3"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(127.000023 , 378.000000)] withName:@"w4"];
    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(75 , 124)] withName:@"w5"];
    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(224.000000 , 303.000000)] withName:@"w6"];
  
    [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(180.500000 , 176.500031) ]withName:@"w8"];
   
    [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(127.500000 , 123.500008)] withName:@"w10"];
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(143.000000 , 275.500000)] withName:@"w11"];
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(206.000000 , 90.000000) ]withName:@"w12"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(237.500000 , 378.000000) ]withName:@"w13"];
  
    [self addChild:[self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(89 , 299.5) ]withName:@"w16"]];

    
    
    
}
-(void)level55 {
    if (levelUnlock<24) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    
    [self.MLDelegate hideAllButtons];

    
    [self.MLDelegate addRecsToSlider:-45 HowMany:2 whatColor:blue];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:purple];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:red];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:orange];
  
    
    
    
    [self createCup:[self convertPoint:CGPointMake( 118.5, 390)]];
    [self createKey:[self convertPoint:CGPointMake(290, 387.5)]];
[self addChild:[self createBackground]];
    
   
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(298.500000 , 345.000000)] withName:@"w3"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(227.000000 , 269.000000)] withName:@"w4"];
  
    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(160 , 294)] withName:@"w6"];
   

    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(140.500000 , 143.000000)] withName:@"w9"];
    
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(209.000000 , 214.499985)] withName:@"w11"];
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(117.500015 , 122.500000)] withName:@"w12"];
   
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(162.500000 , 421.500031)] withName:@"w14"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(185.5 , 345)] withName:@"w15"];
    [self addChild:[self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(85.000000 , 342.500000)] withName:@"w16"]];

    
    
    
}

-(void)level61 {
    if (levelUnlock<25) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    [self.MLDelegate hideAllButtons];

    
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:green];
    [self.MLDelegate updateAchievements];
    

    
    
    
    [self createCup:[self convertPoint:CGPointMake(75.000000, 28.000002)]];
    [self createKey:[self convertPoint:CGPointMake(286.000000, 31.000015)]];
[self addChild:[self createBackground]];
    
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(164.000000 , 48.500004)] withName:@"w1"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(245.500000 , 34.499989) ]withName:@"w2"];

    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(108.500000 , 210.500015)] withName:@"w7"];
   
    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(109.000000 , 142.500000)] withName:@"w9"];
    [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(168.500000 , 292.500000)] withName:@"w10"];
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(23.500000 , 26.000004)] withName:@"w11"];
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(108.000023 , 323.000000)] withName:@"w12"];
   
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(65.500000 , 266.000000)] withName:@"w14"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(245.000000 , 147.500015)] withName:@"w15"];
    [self addChild:[self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(244.2 , 299.000000)] withName:@"w16"]];

    
}
-(void)level62 {
    if (levelUnlock<26) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    
    
    [self.MLDelegate hideAllButtons];
    
    [self.MLDelegate addRecsToSlider:45 HowMany:2 whatColor:red];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:green];
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:purple];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:orange];
    
    
    [self createCup:[self convertPoint:CGPointMake(79, 397)]];
    [self createKey:[self convertPoint:CGPointMake(260, 383.5)]];
    [self addChild:[self createBackground]];
    
    
    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(24.5,271.5)] withName:@"w2"];
    
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(247,29) ]withName:@"w4"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(120.5,283.5) ]withName:@"w5"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(236,319)] withName:@"w10"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(197,397.5) ]withName:@"w11"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(120,395.5)] withName:@"w12"];
    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(277,190)] withName:@"w13"];
    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(177.5,190.5)] withName:@"w14"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(80,65)] withName:@"w15"];
    [self addChild:[self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(154.5,132)] withName:@"w16"]];
    
    
    
    
    
    
}
-(void)level63 {
    if (levelUnlock<27) {
        levelUnlock++;
        [self saveLevelUnlock];
        
        
        
        
        
    }
    [self.MLDelegate hideAllButtons];

    
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:red];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:green];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:orange];
    [self.MLDelegate addRecsToSlider:45 HowMany:1 whatColor:blue];
   

    
    
    
    [self createCup:[self convertPoint:CGPointMake(81, 200.000031)]];
    [self createKey:[self convertPoint:CGPointMake(25.5, 315.500031)]];
[self addChild:[self createBackground]];
    
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(50 , 126.499985)]withName:@"w1"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(57.000000 , 312.500031)] withName:@"w2"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(227.500000 , 166.000015)]withName:@"w3"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(40.500000 , 415.500000) ]withName:@"w4"];
    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(168.000000 , 25.500011)]  withName:@"w5"];
 
    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(112.500000 , 221.999985)] withName:@"w7"];

    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(130.500000 , 362.000000)] withName:@"w9"];
    [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(191.500000 , 198.000031)] withName:@"w10"];

    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(1.500000 , 223.000000)] withName:@"w12"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(126.500008 , 166.000015)] withName:@"w13"];

    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(268.5 , 248.000015)] withName:@"w15"];
    [self addChild:[self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(269.000000 , 133.999985) ]withName:@"w16"]];
   
    
}
-(void)level64 {
    if (levelUnlock<28) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    
    [self.MLDelegate hideAllButtons];

    
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:blue];
    [self.MLDelegate addRecsToSlider:45 HowMany:2 whatColor:red];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:green];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:blue];
   

    
    
    
    
    [self createCup:[self convertPoint:CGPointMake(35.5, 397.000000)]];
    [self createKey:[self convertPoint:CGPointMake(29, 159.000031)]];
[self addChild:[self createBackground]];
    
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(244 , 126.5)] withName:@"w1"];
    
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(208 , 163.5) ]withName:@"w3"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(36.500000 , 431.000061) ]withName:@"w4"];
    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(143.000000 , 189.500000)] withName:@"w5"];
    [self createWhiteRectangle:smallRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(95.500000 , 28.499994) ]withName:@"w6"];
    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(212.500015 , 24.000006)  ]withName:@"w7"];
    [self createWhiteRectangle:smallRec withAngle:45 withPosition:[self convertPoint:CGPointMake(199.500000 , 190.000000)] withName:@"w8"];
    [self createWhiteRectangle:regRec withAngle:-45 withPosition:[self convertPoint:CGPointMake(56.000000 , 184.000000) ]withName:@"w9"];

    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(133.500000 , 335.500000)] withName:@"w12"];
  
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(153 , 276.5)] withName:@"w14"];
  
    [self addChild:[self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(74.5 , 353)] withName:@"w16"]];

    
}
-(void)level65 {
    if (levelUnlock<29) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    
    [self.MLDelegate hideAllButtons];

    
    [self.MLDelegate addRecsToSlider:45 HowMany:3 whatColor:blue];
    [self.MLDelegate addRecsToSlider:-45 HowMany:1 whatColor:orange];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:red];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:orange];
    [self.MLDelegate addRecsToSlider:0 HowMany:1 whatColor:green];
   

    
    
    
    [self createCup:[self convertPoint:CGPointMake(288.500000, 30.5)]];
    [self createKey:[self convertPoint:CGPointMake(290, 372.500000)]];
    [self addChild:[self createBackground]];
    
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(189.500000 , 287.000000)] withName:@"w1"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(250.5 , 375)] withName:@"w2"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(89.500015 , 411.500000)] withName:@"w3"];
    [self createWhiteRectangle:smallRec withAngle:0 withPosition:[self convertPoint:CGPointMake(290.500000 , 411.000000)] withName:@"w4"];
    [self createWhiteRectangle:smallRec withAngle:90 withPosition:[self convertPoint:CGPointMake(120.500000 , 369.000000)] withName:@"w5"];
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(213.000015 , 153.500000)] withName:@"w11"];
    [self createWhiteRectangle:regRec withAngle:45 withPosition:[self convertPoint:CGPointMake(266.000000 , 102.500008) ]withName:@"w12"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(79.5 , 99)] withName:@"w13"];
    [self createWhiteRectangle:regRec withAngle:0 withPosition:[self convertPoint:CGPointMake(171.000000 , 411.500000)] withName:@"w14"];
    [self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(53.000000 , 332.500031) ]withName:@"w15"];
    [self addChild:[self createWhiteRectangle:regRec withAngle:90 withPosition:[self convertPoint:CGPointMake(117.000023 , 176.999985)] withName:@"w16"]];

    
    
    
}

-(void)gameOver{
    if (levelUnlock<30) {
        levelUnlock++;
        [self saveLevelUnlock];
    }
    
    SKSpriteNode *tittle = [SKSpriteNode spriteNodeWithImageNamed:@"title1.PNG"];
   [tittle setScale:self.size.height/1244.44];
    tittle.position = CGPointMake(self.size.width / 2, - self.size.height / 48);
    [self addChild:tittle];
    
    

    SKTexture *title1 = [SKTexture textureWithImageNamed:@"title1.PNG"];
    SKTexture *title2 = [SKTexture textureWithImageNamed:@"title2.PNG"];
    SKTexture *title3 = [SKTexture textureWithImageNamed:@"title3.PNG"];
    SKTexture *title4 = [SKTexture textureWithImageNamed:@"title4.PNG"];
    SKTexture *title5 = [SKTexture textureWithImageNamed:@"title5.PNG"];
    
    
    SKAction *titleAction = [SKAction animateWithTextures:@[title1,title2,title3,title4,title5] timePerFrame:.15];
    [tittle runAction:[SKAction repeatActionForever:titleAction]];
    
    SKLabelNode *thanksLabel = [SKLabelNode labelNodeWithFontNamed:@"Copperplate"];
    thanksLabel.text = @"Thank You";
    thanksLabel.position = CGPointMake(self.size.width / 2, -self.size.height / 6.857);
    [thanksLabel setScale:1];
    [self addChild:thanksLabel];
    
    SKLabelNode *thanksLabel2 = [SKLabelNode labelNodeWithFontNamed:@"Copperplate"];
    thanksLabel2.text = @"For Playing";
    thanksLabel2.position = CGPointMake(self.size.width / 2, -self.size.height / 3.692);
    [thanksLabel setScale:1];
    [self addChild:thanksLabel2];
    
    [self spawnBackgroundEffect];
    
    [self runAction:[SKAction sequence:@[[SKAction waitForDuration:1],[SKAction runBlock:^{
        [tittle runAction:[SKAction moveTo:CGPointMake(self.size.width/2, self.size.height/1.47) duration:10]];
        [thanksLabel runAction:[SKAction moveTo:CGPointMake(self.size.width / 2, self.size.height / 2) duration:10]];
        [thanksLabel2 runAction:[SKAction moveTo:CGPointMake(self.size.width / 2, self.size.height / 2.2) duration:10]];
        
    }], [SKAction waitForDuration:15],[SKAction runBlock:^{
        MainMenu *newScene = [MainMenu sceneWithSize:self.view.bounds.size];
        newScene.MMDelegate = self.MLDelegate;
        SKTransition *reveal = [SKTransition  fadeWithDuration:1];
        [self.MLDelegate MainMenuDidShow];
        [self.view presentScene: newScene transition: reveal];
        
    }]]]];
    
    
    
    
    
    
}

-(void) createCup: (CGPoint)setPosition {
    
    cup = [SKSpriteNode spriteNodeWithImageNamed:@"target"];
    cup.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:1];
    
    cup.name = @"cup";
    cup.physicsBody.affectedByGravity = NO;
    cup.physicsBody.dynamic = NO;
    cup.physicsBody.categoryBitMask = cupCatagory;
    cup.physicsBody.collisionBitMask = ballCatagory;
    cup.physicsBody.contactTestBitMask = ballCatagory;
    cup.zPosition = 1;
    [cup setPosition:setPosition];
    
    [self addChild:cup];
}
-(void) instructions
{
    if (click) {
        clickRecButton.hidden = NO;
    }
    else
    {
        clickRecButton.hidden = YES;
    }
    if (move) {
        moveRecs.hidden = NO;
    }
    else
    {
        moveRecs.hidden = YES;
    }
    if (tap) {
        tapBall.hidden = NO;
        tapBall2.hidden = NO;
    }
    else
    {
        tapBall.hidden = YES;
        tapBall2.hidden = YES;
    }
}

- (void)createKey: (CGPoint)position {
    key = [SKSpriteNode spriteNodeWithImageNamed:@"key"];
   
    key.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(key.size.width, key.size.height)];
    key.name = @"key";
    key.physicsBody.affectedByGravity = NO;
    key.physicsBody.dynamic = NO;
    key.zPosition = 2;
    key.physicsBody.categoryBitMask = keyCatagory;
    key.physicsBody.collisionBitMask = ballCatagory;
    key.physicsBody.contactTestBitMask = ballCatagory;
    [key setPosition:position];
    [self addChild:key];
}

-(SKNode *) createBackground {
    
    start = [SKSpriteNode spriteNodeWithImageNamed:@"backButton"];
    start.name = @"back";
    [standardBackground addChild:start];
   
    
   
    back = [SKSpriteNode spriteNodeWithImageNamed:@"sliderButton"];
    
    back.name = @"start";
    [standardBackground addChild:back];
    
    if (self.size.height == 568) {
        [start setPosition: CGPointMake(50, 548)];
    }
    else
    {
        [start setPosition:[self convertPoint:CGPointMake(50, 460)]];
    }
    
    if (self.size.height == 568) {
        [back setPosition:CGPointMake(270, 548)];
    }
    else
    {
    
        [back setPosition:[self convertPoint:CGPointMake(270, 460)]];
    }
    if (self.size.height == 568) {
        [ball setPosition:CGPointMake(270, 548)];
    }
    else
    {
        
        [ball setPosition:[self convertPoint:CGPointMake(270, 460)]];
    }


    
    
    
    ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball"];
  
    [ball setPosition:[self convertPoint:CGPointMake(0, 0)]];
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.size.height/2];
    ball.zPosition = 1.1;
    ball.physicsBody.restitution = 0;
    ball.physicsBody.dynamic = NO;
    ball.name =@"ball";
    ball.physicsBody.mass = .5;
    ball.physicsBody.categoryBitMask = ballCatagory;
    ball.physicsBody.collisionBitMask = blueRecCatagory | redRecCatagory | purpleRecCatagory | orangeRecCatagory | yellowRecCatagory | greenRecCatagory ;

    ball.physicsBody.contactTestBitMask = cupCatagory | blueRecCatagory | redRecCatagory | purpleRecCatagory | orangeRecCatagory | yellowRecCatagory | greenRecCatagory| keyCatagory ;
    [standardBackground addChild:ball];
    if (self.size.height == 568) {
        [start setPosition: CGPointMake(50, 548)];
    }
    else
    {
        [start setPosition:[self convertPoint:CGPointMake(50, 460)]];
    }
    
    if (self.size.height == 568) {
        [back setPosition:CGPointMake(270, 548)];
    }
    else
    {
        
        [back setPosition:[self convertPoint:CGPointMake(270, 460)]];
    }
    if (self.size.height == 568) {
        [ball setPosition:CGPointMake(160, 548)];
    }
    else
    {
        
        [ball setPosition:[self convertPoint:CGPointMake(160, 460)]];
    }

    standardBackground.zPosition = 2;
    return standardBackground;
    
}

-(void) createRec: (typeRect ) type withAngle:(int) degrees withColor:(colorRec)  color withPosition:(CGPoint) position withNumber:(NSString*)Number
{
    move = YES;
    tap = NO;
    click = NO;
    [self instructions];
  
   
    SKSpriteNode *rec;
    
    if(color == blue)
    {
        
        if (type == regRec) {
            rec = [SKSpriteNode spriteNodeWithImageNamed:@"BlueRec"];
            rec.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(rec.size.width/1.15, rec.size.height/8)];
        }
        if (type == smallRec) {
            rec = [SKSpriteNode spriteNodeWithImageNamed:@"BlueRec"];
            rec.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(rec.size.width/1.15, rec.size.height/8)];

        }
          rec.physicsBody.categoryBitMask = blueRecCatagory;
    }
    if(color == red)
    {
        
                if (type == regRec) {
            rec = [SKSpriteNode spriteNodeWithImageNamed:@"RedRec"];
            rec.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(rec.size.width/1.15, rec.size.height/8)];
                    
        }
        if (type == smallRec) {
            rec = [SKSpriteNode spriteNodeWithImageNamed:@"RedRec"];
            rec.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(rec.size.width/1.15, rec.size.height/8)];

        }
        rec.physicsBody.categoryBitMask = redRecCatagory;


    }
    if(color == purple)
    {
                if (type == regRec) {
            rec = [SKSpriteNode spriteNodeWithImageNamed:@"PurpleRec"];
            rec.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(rec.size.width/1.15, rec.size.height/8)];
        }
        if (type == smallRec) {
            rec = [SKSpriteNode spriteNodeWithImageNamed:@"PurpleRec"];
            rec.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(rec.size.width/1.15, rec.size.height/8)];

        }
        rec.physicsBody.categoryBitMask = purpleRecCatagory;


    }
    if(color == orange)
    {
                if (type == regRec) {
            rec = [SKSpriteNode spriteNodeWithImageNamed:@"OrangeRec"];
            rec.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(rec.size.width/1.15, rec.size.height/8)];
        }
        if (type == smallRec) {
            rec = [SKSpriteNode spriteNodeWithImageNamed:@"OrangeRec"];
            rec.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(rec.size.width/1.15, rec.size.height/8)];

        }
        rec.physicsBody.categoryBitMask = orangeRecCatagory;


    }
    if(color == yellow)
    {
        
        if (type == regRec) {
            rec = [SKSpriteNode spriteNodeWithImageNamed:@"YellowRec"];
            rec.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(rec.size.width/1.15, rec.size.height/8)];
        }
        if (type == smallRec) {
            rec = [SKSpriteNode spriteNodeWithImageNamed:@"YellowRec"];
            rec.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(rec.size.width/1.15, rec.size.height/8)];

        }
        _yellowRec = rec;
        

        rec.physicsBody.categoryBitMask = yellowRecCatagory;

    }
    if(color == green)
    {
        
                if (type == regRec) {
                   
            rec = [SKSpriteNode spriteNodeWithImageNamed:@"GreenRec"];
            rec.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(rec.size.width/1.15, rec.size.height/8)];
        }
        if (type == smallRec) {
           
            rec = [SKSpriteNode spriteNodeWithImageNamed:@"GreenRec"];
            rec.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(rec.size.width/1.15, rec.size.height/8)];

        }
        secondGreenRec =[SKSpriteNode spriteNodeWithImageNamed:@"GreenRec"];
        secondGreenRec.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(rec.size.width/1.15, rec.size.height/8)];
        secondGreenRec.position = position;
        secondGreenRec.name = @"sG";
        secondGreenRec.physicsBody.affectedByGravity = NO;
        secondGreenRec.physicsBody.mass = .5;
        secondGreenRec.physicsBody.dynamic = NO;
        secondGreenRec.physicsBody.collisionBitMask = cupCatagory;
        secondGreenRec.physicsBody.contactTestBitMask = ballCatagory;
        secondGreenRec.physicsBody.categoryBitMask = greenRecCatagory;
        rec.physicsBody.categoryBitMask = greenRecCatagory;
        [self addChild: secondGreenRec];
    }
    
    rec.position = position;
   
    rec.name = Number;
    rec.zPosition = 1.3;
    rec.physicsBody.affectedByGravity = NO;
    rec.physicsBody.mass = .5;
    rec.physicsBody.dynamic = NO;
    rec.physicsBody.collisionBitMask = cupCatagory;
    rec.physicsBody.contactTestBitMask = ballCatagory;
    
    
    if (degrees==45) {
        
        rec.zRotation = 3.14/4;
        
    }
    else if (degrees==-45)
    {
        
        rec.zRotation = -3.14/4;
        
        
    }
   
    yellowStarting = _yellowRec.zRotation;
     NSLog(@"%f",yellowStarting);
    _lastNode = rec;
    [self addChild:rec];
}

-(SKNode *) createWhiteRectangle: (typeRect)size withAngle:(int)angle withPosition:(CGPoint)placement withName: (NSString*)nameWhite {
    SKSpriteNode *wRec;
    
    if (size == regRec) {
        wRec = [SKSpriteNode spriteNodeWithImageNamed:@"WhiteRecLarge"];
        wRec.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(wRec.size.width/1.15,wRec.size.height/8)];
    }
    if (size == smallRec) {
        wRec = [SKSpriteNode spriteNodeWithImageNamed:@"WhiteRecSmall"];
        wRec.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(wRec.size.width/1.15,wRec.size.height/8)];

    }
    
    [wRec setPosition:placement];
    wRec.physicsBody.dynamic = NO;
    wRec.name = nameWhite;
    
if (angle == 45) {
    
    wRec.zRotation = 3.14/4;
    
}
else if (angle == -45)
{
    
    wRec.zRotation = -3.14/4;
    
    
}
else if (angle == 90)
{
    wRec.zRotation = 3.15/2;
}
  
    [whiteRecs addChild:wRec];
    return whiteRecs;
   
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
  
    [self.MLDelegate LevelSceneDidShowOn];
    
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKSpriteNode *node = (SKSpriteNode *)[self nodeAtPoint:location];
    
if([node.name isEqualToString:@"start"])
{
    click = NO;
    tap = NO;
    move = NO;
    [self instructions];
     sliderHit = YES;
    if ([self.MLDelegate isSliderClosed]) {
        [self.MLDelegate openSlider];
    }
    else{
    [self.MLDelegate shutSlider];
    }
}
    
    if ([node.name isEqualToString:@"ball"]) {
         ballHit = YES;
         ball.physicsBody.dynamic = YES;
        self.physicsWorld.gravity = CGVectorMake(0,-3);
        gameStart =NO;
    }
    if ([node.name isEqualToString:@"back"]){
        if (![self.MLDelegate isSliderClosed]) {
            NSLog(@"closed");
            [self.MLDelegate shutSlider];
        }
        [self.MLDelegate LevelSceneDidShowOff];
        WorldScreen *newScene = [WorldScreen sceneWithSize:self.view.bounds.size];
        newScene.MWDelegate = self.MLDelegate;
        SKTransition *reveal = [SKTransition pushWithDirection:SKTransitionDirectionRight duration:1];
        [self.view presentScene: newScene transition: reveal];
    }
    if ([touch tapCount] == 2) {
        
        //reseting for purple effects to work
        [ball setScale:1];
        SKPhysicsBody *temp = ball.physicsBody;
        temp.dynamic = NO;
        ball.physicsBody = temp;
        scaleSwitched = NO;
        
        
        gameStart = YES;
        gravitySwitched = NO;
        didHit = NO;
        if (keyHit == YES) {
            keyHit = NO;
            
          

        [self addChild:key];
        }
        if (rotated == YES) {
            [_yellowRec removeAllActions];
            [_yellowRec runAction:[SKAction rotateToAngle:yellowStarting duration:0]];
            
                   rotated = NO;
        }
        [ball runAction:[SKAction moveTo:ballStart duration:0]];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
    }
    
//    if ((gameStart == YES) &&[node.name isEqualToString:@"key"]) {
//        _nodeTouch = @"key";
//    }
//   
//    if((gameStart == YES) && [node.name isEqualToString:@"cup"])
//    {
//        
//        _nodeTouch = @"cup";
//        NSLog(@"%@",_nodeTouch);
//        
//    }
//    if((gameStart == YES) && [node.name isEqualToString:@"ball"])
//    {
//        
//        _nodeTouch = @"ball";
//        NSLog(@"%@",_nodeTouch);
//        
//    }


    if((gameStart == YES) && [node.name isEqualToString:@"sG"])
    {
        _nodeTouch = @"sG";
    }
    
    
    if((gameStart == YES) && [node.name isEqualToString:@"fG"])
    {
        _nodeTouch = @"fG";
        
    }
    if((gameStart == YES) && [node.name isEqualToString:@"1"]){
        _nodeTouch = @"1";
        
    }

    if((gameStart == YES) && [node.name isEqualToString:@"2"]){
        _nodeTouch = @"2";

           }
    if((gameStart == YES) && [node.name isEqualToString:@"3"]){
        
        _nodeTouch = @"3";

    }
    if((gameStart == YES) && [node.name isEqualToString:@"4"]){
        _nodeTouch = @"4";

    }
    if((gameStart == YES) && [node.name isEqualToString:@"5"]){
        _nodeTouch = @"5";

    }
    if((gameStart == YES) && [node.name isEqualToString:@"6"]){
        _nodeTouch = @"6";

    }
    if((gameStart == YES) && [node.name isEqualToString:@"7"]){
        _nodeTouch = @"7";

    }
    if((gameStart == YES) && [node.name isEqualToString:@"8"]){
        _nodeTouch = @"8";

    }
    if((gameStart == YES) && [node.name isEqualToString:@"9"]){
        _nodeTouch = @"9";

    }
    if((gameStart == YES) && [node.name isEqualToString:@"10"]){
        _nodeTouch = @"10";

    }
    if((gameStart == YES) && [node.name isEqualToString:@"11"]){
        _nodeTouch = @"11";
        
    }
    if((gameStart == YES) && [node.name isEqualToString:@"12"]){
        _nodeTouch = @"12";
        
    }
    if((gameStart == YES) && [node.name isEqualToString:@"13"]){
        _nodeTouch = @"13";
        
    }
    if((gameStart == YES) && [node.name isEqualToString:@"14"]){
        _nodeTouch = @"15";
        
    }
//    if((gameStart == YES) && [node.name isEqualToString:@"w1"]){
//        _nodeTouch = @"w1";
//        
//    }
//    
//    if((gameStart == YES) && [node.name isEqualToString:@"w2"]){
//        _nodeTouch = @"w2";
//        
//    }
//    if((gameStart == YES) && [node.name isEqualToString:@"w3"]){
//        
//        _nodeTouch = @"w3";
//        
//    }
//    if((gameStart == YES) && [node.name isEqualToString:@"w4"]){
//        _nodeTouch = @"w4";
//        
//    }
//    if((gameStart == YES) && [node.name isEqualToString:@"w5"]){
//        _nodeTouch = @"w5";
//        
//    }
//    if((gameStart == YES) && [node.name isEqualToString:@"w6"]){
//        _nodeTouch = @"w6";
//        
//    }
//    if((gameStart == YES) && [node.name isEqualToString:@"w7"]){
//        _nodeTouch = @"w7";
//        
//    }
//    if((gameStart == YES) && [node.name isEqualToString:@"w8"]){
//        _nodeTouch = @"w8";
//        
//    }
//    if((gameStart == YES) && [node.name isEqualToString:@"w9"]){
//        _nodeTouch = @"w9";
//        
//    }
//    if((gameStart == YES) && [node.name isEqualToString:@"w10"]){
//        _nodeTouch = @"w10";
//        
//    }
//    if((gameStart == YES) && [node.name isEqualToString:@"w11"]){
//        _nodeTouch = @"w11";
//        
//    }
//    
//    if((gameStart == YES) && [node.name isEqualToString:@"w12"]){
//        _nodeTouch = @"w12";
//        
//    }
//    if((gameStart == YES) && [node.name isEqualToString:@"w13"]){
//        
//        _nodeTouch = @"w13";
//        
//    }
//    if((gameStart == YES) && [node.name isEqualToString:@"w14"]){
//        _nodeTouch = @"w14";
//        
//    }
//    if((gameStart == YES) && [node.name isEqualToString:@"w15"]){
//        _nodeTouch = @"w15";
//        
//    }
//    if((gameStart == YES) && [node.name isEqualToString:@"w16"]){
//        _nodeTouch = @"w16";
//        
//    }
//    if((gameStart == YES) && [node.name isEqualToString:@"w17"]){
//        _nodeTouch = @"w17";
//        
//    }
//    if((gameStart == YES) && [node.name isEqualToString:@"w18"]){
//        _nodeTouch = @"w18";
//        
//    }
//    if((gameStart == YES) && [node.name isEqualToString:@"w19"]){
//        _nodeTouch = @"w19";
//        
//    }
//    if((gameStart == YES) && [node.name isEqualToString:@"w20"]){
//        _nodeTouch = @"w20";
//        
//    }
    
//    if((gameStart == YES) && [node.name isEqualToString:@"backGround"]){
//        _nodeTouch = @"backGround";
    
  //  }
    
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _nodeTouch = @"penis";
 

    if (sliderHit
        ) {
        clickRecButton.hidden = YES;
        
    }
    if (recHit) {
        moveRecs.hidden = YES;
        tapBall.hidden = NO;
        tapBall2.hidden = NO;
    }
    if (ballHit) {
        tapBall2.hidden = YES;
        tapBall.hidden = YES;
    }

}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    move = NO;
    tap = YES;
    click = NO;
    [self instructions];
    if ([_nodeTouch isEqualToString:@"key"]) {
        [key runAction:[SKAction moveTo:[[touches anyObject]locationInNode:self] duration:0]];
        float keyPositionX = key.position.x;
        
        float keyPositionY = key.position.y;
        NSLog(@"cup : %f",keyPositionX);
        NSLog(@"cup : %f",keyPositionY);
    }
      else if([_nodeTouch  isEqualToString: @"cup"])
      {
             [cup runAction:[SKAction moveTo:[[touches anyObject]locationInNode:self] duration:0]];
          float cupPositionX = cup.position.x;
  
          float cupPositionY = cup.position.y;
          NSLog(@"cup : %f",cupPositionX);
          NSLog(@"cup : %f",cupPositionY);
      }
     else if ([_nodeTouch  isEqualToString: @"w1"] || [_nodeTouch  isEqualToString: @"w2"] || [_nodeTouch  isEqualToString: @"w3"] || [_nodeTouch  isEqualToString: @"w4"] || [_nodeTouch  isEqualToString: @"w5"] || [_nodeTouch  isEqualToString: @"w6"] || [_nodeTouch  isEqualToString: @"w7"] || [_nodeTouch  isEqualToString: @"w8"] || [_nodeTouch  isEqualToString: @"w9"] || [_nodeTouch  isEqualToString: @"w10"] || [_nodeTouch  isEqualToString: @"w11"] || [_nodeTouch  isEqualToString: @"w12"] || [_nodeTouch  isEqualToString: @"w13"] || [_nodeTouch  isEqualToString: @"w14"] || [_nodeTouch  isEqualToString: @"w15"] || [_nodeTouch  isEqualToString: @"w16"] || [_nodeTouch  isEqualToString: @"w17"] || [_nodeTouch  isEqualToString: @"w18"] || [_nodeTouch  isEqualToString: @"w19"] || [_nodeTouch  isEqualToString: @"w20"]) {
        [[whiteRecs childNodeWithName:_nodeTouch] runAction:[SKAction moveTo:[[touches anyObject]locationInNode:self] duration:0]];
        float whitePositionX = [whiteRecs childNodeWithName:_nodeTouch].position.x;
        float whitePositionY = [whiteRecs childNodeWithName:_nodeTouch].position.y;
        NSLog(@"white: (%f , %f) %@",whitePositionX,whitePositionY,_nodeTouch);
         
    }
    
     else if ([_nodeTouch isEqualToString:@"ball"])
     {
         [ball runAction:[SKAction moveTo:[[touches anyObject]locationInNode:self] duration:0]];
         float ballPositionX = ball.position.x;
         
         float ballPositionY = ball.position.y;
         NSLog(@"ball : %f",ballPositionX);
         NSLog(@"ball : %f",ballPositionY);
     }
    
     else if ([_nodeTouch isEqualToString:@"backGround"])
     {
         NSLog(@"nothing");
     }
    
     else if(gameStart == YES ){
        
        [[self childNodeWithName:_nodeTouch] runAction:[SKAction moveTo:[[touches anyObject]locationInNode:self] duration:0]];
        float positionX = [objectHolder childNodeWithName:_nodeTouch].position.x;
        float positionY = [objectHolder childNodeWithName:_nodeTouch].position.y;
        NSLog(@"x: %f",positionX);
        NSLog(@"y: %f",positionY);
    }
    
   }

-(void) didBeginContact:(SKPhysicsContact *)contact {
    NSLog(@"contact");
    if(contact.bodyA.categoryBitMask == keyCatagory || contact.bodyB.categoryBitMask == keyCatagory)
    {
        keyHit = YES;
        [key removeFromParent];
    }
   if(contact.bodyA.categoryBitMask == cupCatagory || contact.bodyB.categoryBitMask == cupCatagory)
   {
       NSLog(@"cup contact ");
       if(keyHit)
       {
       
       if (whatLevel == 15 || whatLevel == 25 || whatLevel == 35 || whatLevel == 45 || whatLevel == 55 )
       {
           whatLevel = whatLevel + 6;
       }
       else {
       whatLevel++;
       }
       [self saveScore];
       SKTransition *tran = [SKTransition pushWithDirection:SKTransitionDirectionUp duration:1];
       MyScene* scene = [MyScene sceneWithSize:self.view.bounds.size];
       scene.MLDelegate = self.MLDelegate;
       scene.scaleMode = SKSceneScaleModeAspectFill;
       [(MyScene *)scene callLevel:whatLevel];
             [self.view presentScene:scene transition:tran];
       }
   }
       
   
    if(contact.bodyA.categoryBitMask == redRecCatagory || contact.bodyB.categoryBitMask == redRecCatagory)
    {
        SKNode *hitTangle;
       
        
        if(contact.bodyA.node == ball)
        {
            hitTangle = contact.bodyB.node;
        }
        else
        {
            hitTangle = contact.bodyA.node;
        }
        
        if (gravitySwitched == NO) {
            
            if (hitTangle.zRotation == .785f) {
                NSLog(@"45");
                [ball.physicsBody applyImpulse:CGVectorMake(-self.size.height / 2.84, self.size.height / 2.84)];
            }
            if (hitTangle.zRotation == -.785f) {
                NSLog(@"-45");
                [ball.physicsBody applyImpulse:CGVectorMake(self.size.height / 2.84, self.size.height / 2.84)];
            }
            if (hitTangle.zRotation == 0) {
                NSLog(@"0");
                [ball.physicsBody applyImpulse:CGVectorMake(0, self.size.height / 2.84)];
            }
        }

        
        if (gravitySwitched == YES) {
        
       
        if (hitTangle.zRotation == .785f) {
            NSLog(@"45");
            [ball.physicsBody applyImpulse:CGVectorMake(self.size.height / 2.84, -self.size.height / 2.84)];
        }
        if (hitTangle.zRotation == -.785f) {
            NSLog(@"-45");
            [ball.physicsBody applyImpulse:CGVectorMake(-self.size.height / 2.84, -self.size.height / 2.84)];
        }
        if (hitTangle.zRotation == 0) {
            NSLog(@"0");
            [ball.physicsBody applyImpulse:CGVectorMake(0, -self.size.height / 2.84)];
        }
        }
       
        
        
        
     
    }
    if(contact.bodyA.categoryBitMask == purpleRecCatagory || contact.bodyB.categoryBitMask == purpleRecCatagory)
    {

    if (scaleSwitched == YES) {
            [ball setScale:1.0f];
            scaleSwitched = NO;
        }
        
        else{
            
     
        [ball setScale:.5];
        
        scaleSwitched = YES;
        }
        }
    if(contact.bodyA.categoryBitMask == orangeRecCatagory || contact.bodyB.categoryBitMask == orangeRecCatagory)
    {
        if (gravitySwitched == YES)
        {
        self.physicsWorld.gravity = CGVectorMake(0, -3);
            gravitySwitched = NO;
        }
        else{
            self.physicsWorld.gravity =  CGVectorMake(0, 3);
        
        gravitySwitched = YES;
        }
    }
    if(contact.bodyA.categoryBitMask == yellowRecCatagory || contact.bodyB.categoryBitMask == yellowRecCatagory)
    {
                SKNode *hitTangle;
        if(contact.bodyA.node == ball)
        {
            hitTangle = contact.bodyB.node;
        }
        else
        {
            hitTangle = contact.bodyA.node;
        }
        _yellowRec = hitTangle;
        if(rotated == NO)
        {
        NSLog(@"%f",hitTangle.zRotation);
        if (hitTangle.zRotation == .785f || hitTangle.zRotation == .7875f) {
            NSLog(@"45");
            SKAction *changeRotation = [SKAction rotateToAngle:3.15/-4 duration:2 ];
            [hitTangle runAction:changeRotation];
        }
        if (hitTangle.zRotation == -.785f || hitTangle.zRotation == -.7875f) {
            NSLog(@"-45");
            SKAction *changeRotation = [SKAction rotateToAngle:3.15/4 duration:2];
            [hitTangle runAction:changeRotation];
        }
        if (hitTangle.zRotation == 0 ) {
            NSLog(@"0");
            SKAction *changeRotation = [SKAction rotateToAngle:3.15 duration:2 ];
            [hitTangle runAction:changeRotation];
        }
            rotated = YES;
        }

        
    }
    if(contact.bodyA.categoryBitMask == greenRecCatagory || contact.bodyB.categoryBitMask == greenRecCatagory)
    {
        
        SKNode *hitTangle;
        if(contact.bodyA.node == ball)
        {
            hitTangle = contact.bodyB.node;
        }
        else
        {
            hitTangle = contact.bodyA.node;
        }
        if(didHit == NO)
        {
            
        if ([hitTangle.name isEqualToString: @"sG"]) {
            NSLog(@"greenHit");
            SKNode *otherGreen = [self childNodeWithName:@"fG"];
            [ball runAction:[SKAction moveTo:CGPointMake(otherGreen.position.x, otherGreen.position.y) duration:0]];
            
        }
        if ([hitTangle.name isEqualToString:@"fG"]) {
            NSLog(@"greenHit");
            SKNode *otherGreen = [self childNodeWithName:@"sG"];
            [ball runAction:[SKAction moveTo:CGPointMake(otherGreen.position.x, otherGreen.position.y) duration:0]];
        }
            
            
            didHit = YES;
        }
        
        
        
    }


}

-(void)update:(CFTimeInterval)currentTime {
    
    

    /* Called before each frame is rendered */
}

-(void)spawnBackgroundEffect{
    
    SKEmitterNode *b = [SKEmitterNode bomb_emitterNamed:@"backgroundeffect"];
    [b setScale:self.size.height / 631.111];
    b.targetNode = self;
    b.particleScale /= 2;
    [b setPosition:CGPointMake(self.size.width/2, self.size.height)];
    [b setName:@"bom"];
    [b advanceSimulationTime:20];
    [self addChild:b];
    
    SKEmitterNode *b2 = [SKEmitterNode bomb_emitterNamed:@"backgroundEffect2"];
    [b2 setScale:self.size.height / 631.111];
    b2.targetNode = self;
    b2.particleScale /= 2;
    [b2 setPosition:CGPointMake(self.size.width/2, self.size.height)];
    [b2 setName:@"bom"];
    [b2 advanceSimulationTime:20];
    [self addChild:b2];
    
    SKEmitterNode *b3 = [SKEmitterNode bomb_emitterNamed:@"backgroundEffect3"];
    [b3 setScale:self.size.height / 631.111];
    b3.targetNode = self;
    b3.particleScale /= 2;
    [b3 setPosition:CGPointMake(self.size.width/2, self.size.height)];
    [b3 setName:@"bom"];
    [b3 advanceSimulationTime:20];
    [self addChild:b3];
    
    SKEmitterNode *b4 = [SKEmitterNode bomb_emitterNamed:@"backgroundEffect4"];
    [b4 setScale:self.size.height / 631.111];
    b4.targetNode = self;
    b4.particleScale /= 2;
    [b4 setPosition:CGPointMake(self.size.width/2, self.size.height)];
    [b4 setName:@"bom"];
    [b4 advanceSimulationTime:20];
    [self addChild:b4];
    
    SKEmitterNode *b5 = [SKEmitterNode bomb_emitterNamed:@"backgroundEffect5"];
    [b5 setScale:self.size.height / 631.111];
    b5.targetNode = self;
    b5.particleScale /= 2;
    [b5 setPosition:CGPointMake(self.size.width/2, self.size.height)];
    [b5 setName:@"bom"];
    [b5 advanceSimulationTime:20];
    [self addChild:b5];
}

@end
