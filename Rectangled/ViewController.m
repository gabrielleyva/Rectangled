//
//  ViewController.m
//  Ball Drop Test
//
//  Created by Connor Mounts on 5/17/14.
//  Copyright (c) 2014 Lykos Technologies LLC. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"
#import "WorldScreen.h"
#import "NLMButton.h"
#import "CustomActionSheet.h"




#define RECTANGLEDACHIEVEMENT_ID1 @"level1"
#define RECTANGLEDACHIEVEMENT_ID2 @"world1"
#define RECTANGLEDACHIEVEMENT_ID3 @"world2"
#define RECTANGLEDACHIEVEMENT_ID4 @"world3"
#define RECTANGLEDACHIEVEMENT_ID5 @"world4"
#define RECTANGLEDACHIEVEMENT_ID6 @"world5"
#define RECTANGLEDACHIEVEMENT_ID7 @"world6"
#define RECTANGLEDACHIEVEMENT_ID8 @"finishedgame"


@interface ViewController ();

-(void)authenticateLocalPlayer;

-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard;

-(void)updateAchievements;

// A flag indicating whether the Game Center features can be used after a user has been authenticated.
@property (nonatomic) BOOL gameCenterEnabled;

// This property stores the default leaderboard's identifier.
@property (nonatomic, strong) NSString *leaderboardIdentifier;

// The player's score. Its type is int64_t so as to match the expected type by the respective method of GameKit.
@property (nonatomic) int64_t score;

// It will be used to display the Game Center related options and handle the user selection in a block.
@property (nonatomic) CustomActionSheet *customActionSheet;

// The current round of a level.
@property (nonatomic) int currentAdditionCounter;

// The current level.
@property (nonatomic) int level;
@end

@implementation ViewController{
    __weak NLMButton *_reportScoreButton;
    __weak NLMButton *_shareButton;
    __weak NLMButton *_playButton;
    __weak NLMButton *_redRec;
    __weak NLMButton *_purpleRec;
    __weak NLMButton *_blueRec;
    __weak NLMButton *_greenRec;
    __weak NLMButton *_yellowRec;
    __weak NLMButton *_orangeRec;
    __weak NLMButton *_red45Rec;
    __weak NLMButton *_purple45Rec;
    __weak NLMButton *_blue45Rec;
    __weak NLMButton *_green45Rec;
    __weak NLMButton *_yellow45Rec;
    __weak NLMButton *_orange45Rec;
    __weak NLMButton *_redneg45Rec;
    __weak NLMButton *_purpleneg45Rec;
    __weak NLMButton *_blueneg45Rec;
    __weak NLMButton *_greenneg45Rec;
    __weak NLMButton *_yellowneg45Rec;
    __weak NLMButton *_orangeneg45Rec;
    __weak UIButton *_helpButton;
    UILabel *_x;
    UILabel *_x2;
    UILabel *_x3;
    UILabel *_x4;
    UILabel *_x5;
    UILabel *_x6;
    UILabel *_x7;
    UILabel *_x8;
    UILabel *_x9;
    UILabel *_x10;
    UILabel *_x11;
    UILabel *_x12;
    UILabel *_x13;
    UILabel *_x14;
    UILabel *_x15;
    UILabel *_x16;
    UILabel *_x17;
    UILabel *_x18;
    
    
    int nextButtonSpot;
    bool sliderShow;
    bool sliderMove;
    
    NSInteger numOfTimes[18];
    int numOfRec;
    
    UIDocumentInteractionController* _shareController;
    
    __weak SKView *_skView;
    
    long unlocked;
    
    
    
}

@synthesize menuDrawerWidth,menuDrawerX,open,close;

-(void)drawerAnimation{
    
}
-(int)convertPoint:(int) point
{
    int divider = self.view.frame.size.height/point;
    return self.view.frame.size.height/divider;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    nextButtonSpot =
    menuDrawerWidth = self.view.frame.size.width * .5;
    menuDrawerX = self.view.frame.origin.x - menuDrawerWidth;
    menuDrawer = [[UIView alloc]initWithFrame:CGRectMake(menuDrawerX, self.view.frame.origin.y, menuDrawerWidth, self.view.frame.size.height)];
    menuDrawer.backgroundColor = [UIColor colorWithWhite:.75 alpha:1];
    
    //    close = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipes:)];
    //    open = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    //    close.direction = UISwipeGestureRecognizerDirectionLeft;
    //    open.direction = UISwipeGestureRecognizerDirectionRight;
    //    _remove = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    //    _remove.direction = UISwipeGestureRecognizerDirectionUp;
    numOfRec = 1;
    
    //    [self.view addGestureRecognizer:open];
    //    [self.view addGestureRecognizer:close];
    sliderMove = YES;
    
    CGFloat s = self.view.frame.size.height;
    NSLog(@"%f", s);
    // Configure the view.
    SKView * skView = [[SKView alloc] initWithFrame:self.view.bounds];
    skView.layer.anchorPoint = CGPointMake(.5f, 1.f);
    skView.layer.position = CGPointMake(self.view.frame.size.width / 2.f, self.view.frame.size.height);
    self.view.backgroundColor = [UIColor blackColor];
    //    skView.showsFPS = YES;
    //    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    MainMenu * scene = [MainMenu sceneWithSize:skView.bounds.size];
    scene.MMDelegate = self;
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [skView presentScene:scene];
    [self.view addSubview:skView];
    
    
    // Present the scene.
    [skView presentScene:scene];
    _skView =skView;
    
    //Buttons
    CGSize buttonSize = CGSizeMake(self.view.frame.size.width/2.4, self.view.frame.size.height/13);
    NLMButton *reportScoreButton = [[NLMButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3.5, self.view.frame.size.height /1.23, buttonSize.width, buttonSize.height)];
    [reportScoreButton setImage:[UIImage imageNamed:@"gamecenterrectangled.png"] forState:UIControlStateNormal];
    [reportScoreButton show:NO];
    [reportScoreButton addTarget:self action:@selector(reportScoreButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [reportScoreButton addTarget:self action:@selector(showGCOptions:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reportScoreButton];
    _reportScoreButton = reportScoreButton;
    
    NLMButton *shareButton = [[NLMButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/20, self.view.frame.size.height/1.5, buttonSize.width, buttonSize.height)];
    [shareButton setImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    [shareButton show:NO];
    [shareButton addTarget:self action:@selector(shareButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
    _shareButton = shareButton;
    
    NLMButton *playButton = [[NLMButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 1.8, self.view.frame.size.height / 1.5, buttonSize.width, buttonSize.height)];
    [playButton setImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
    [playButton show:NO];
    [playButton addTarget:self action:@selector(playButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    _playButton = playButton;
    
    
    [self.view addSubview:menuDrawer];
    
    UILabel *zero = [[UILabel alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, 0, buttonSize.width, buttonSize.height)];
    [zero setFont:[UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    zero.numberOfLines = 0;
    zero.text = @"0˚";
    [menuDrawer addSubview:zero];
    
    NLMButton *redRec = [[NLMButton alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, self.view.frame.size.height/24,buttonSize.width , buttonSize.height)];
    [redRec setImage:[UIImage imageNamed:@"RedRec"] forState:UIControlStateNormal];
    [redRec addTarget:self action:@selector(RedAvailable:) forControlEvents:UIControlEventTouchUpInside];
    [menuDrawer addSubview:redRec];
    redRec.hidden = YES;
    _redRec = redRec;
    
    UILabel *x = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.46153846, self.view.frame.size.height/14.54545454, self.view.frame.size.width/16,self.view.frame.size.height/48)];
    x.text = @"x";
    [x setFont: [UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    [menuDrawer addSubview:x];
    x.hidden = YES;
    _x = x;
    
    NLMButton *purpleRec = [[NLMButton alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, self.view.frame.size.height/12,buttonSize.width , buttonSize.height)];
    [purpleRec setImage:[UIImage imageNamed:@"PurpleRec"] forState:UIControlStateNormal];
    [purpleRec addTarget:self action:@selector(PurpleAvailable:) forControlEvents:UIControlEventTouchUpInside];
    [menuDrawer addSubview:purpleRec];
    purpleRec.hidden = YES;
    _purpleRec = purpleRec;
    
    UILabel *x2 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.46153846, self.view.frame.size.height/9.05660377, self.view.frame.size.width/16, self.view.frame.size.height/48)];
    x2.text = @"x";
    [x2 setFont: [UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    [menuDrawer addSubview:x2];
    x2.hidden = YES;
    _x2 = x2;
    
    NLMButton *greenRec = [[NLMButton alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, self.view.frame.size.height/8,buttonSize.width , buttonSize.height)];
    [greenRec setImage:[UIImage imageNamed:@"GreenRec"] forState:UIControlStateNormal];
    [greenRec addTarget:self action:@selector(GreenAvailable:) forControlEvents:UIControlEventTouchUpInside];
    [menuDrawer addSubview:greenRec];
    greenRec.hidden = YES;
    _greenRec = greenRec;
    
    UILabel *x3 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.46153846, self.view.frame.size.height/6.57534247, self.view.frame.size.width/16, self.view.frame.size.height/48)];
    x3.text = @"x";
    [x3 setFont: [UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    [menuDrawer addSubview:x3];
    x3.hidden = YES;
    _x3 = x3;
    
    NLMButton *orangeRec = [[NLMButton alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, self.view.frame.size.height/6,buttonSize.width , buttonSize.height)];
    [orangeRec setImage:[UIImage imageNamed:@"OrangeRec"] forState:UIControlStateNormal];
    [orangeRec addTarget:self action:@selector(OrangeAvailable:) forControlEvents:UIControlEventTouchUpInside];
    [menuDrawer addSubview:orangeRec];
    orangeRec.hidden = YES;
    _orangeRec = orangeRec;
    
    UILabel *x4 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.46153846,self.view.frame.size.height/5.16129032, self.view.frame.size.width/16, self.view.frame.size.height/48)];
    x4.text = @"x";
    [x4 setFont: [UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    [menuDrawer addSubview:x4];
    x4.hidden = YES;
    _x4 = x4;
    
    NLMButton *yellowRec = [[NLMButton alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, self.view.frame.size.height/4.8,buttonSize.width , buttonSize.height)];
    [yellowRec setImage:[UIImage imageNamed:@"YellowRec"] forState:UIControlStateNormal];
    [yellowRec addTarget:self action:@selector(YellowAvailable:) forControlEvents:UIControlEventTouchUpInside];
    [menuDrawer addSubview:yellowRec];
    yellowRec.hidden = YES;
    _yellowRec = yellowRec;
    
    UILabel *x5 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.46153846, self.view.frame.size.height/4.24778761, self.view.frame.size.width/16, self.view.frame.size.height/48)];
    x5.text = @"x";
    [x5 setFont: [UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    [menuDrawer addSubview:x5];
    x5.hidden = YES;
    _x5 = x5;
    
    NLMButton *recRec = [[NLMButton alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, self.view.frame.size.height/4,buttonSize.width , buttonSize.height)];
    [recRec setImage:[UIImage imageNamed:@"BlueRec"] forState:UIControlStateNormal];
    [recRec addTarget:self action:@selector(BlueAvailable:) forControlEvents:UIControlEventTouchUpInside];
    [menuDrawer addSubview:recRec];
    recRec.hidden = YES;
    _blueRec = recRec;
    
    UILabel *x6 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.46153846, self.view.frame.size.height/3.60902256, self.view.frame.size.width/16, self.view.frame.size.height/48)];
    x6.text = @"x";
    [x6 setFont: [UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    [menuDrawer addSubview:x6];
    x6.hidden = YES;
    _x6 = x6;
    
    UILabel *fortyFive = [[UILabel alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, self.view.frame.size.height/3.42857143, buttonSize.width, buttonSize.height)];
    [fortyFive setFont:[UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    fortyFive.text = @"45˚";
    [menuDrawer addSubview:fortyFive];
    
    NLMButton *redRec45 = [[NLMButton alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, self.view.frame.size.height/3,buttonSize.width , buttonSize.height)];
    [redRec45 setImage:[UIImage imageNamed:@"RedRec"] forState:UIControlStateNormal];
    [redRec45 addTarget:self action:@selector(Red45Available:) forControlEvents:UIControlEventTouchUpInside];
    [menuDrawer addSubview:redRec45];
    redRec45.hidden = YES;
    _red45Rec = redRec45;
    
    UILabel *x7 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.46153846, self.view.frame.size.height/2.77456647, self.view.frame.size.width/16, self.view.frame.size.height/48)];
    x7.text = @"x";
    [x7 setFont: [UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    [menuDrawer addSubview:x7];
    x7.hidden = YES;
    _x7 = x7;
    
    NLMButton *purpleRec45 = [[NLMButton alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, self.view.frame.size.height/2.6666666667,buttonSize.width , buttonSize.height)];
    [purpleRec45 setImage:[UIImage imageNamed:@"PurpleRec"] forState:UIControlStateNormal];
    [purpleRec45 addTarget:self action:@selector(Purple45Available:) forControlEvents:UIControlEventTouchUpInside];
    [menuDrawer addSubview:purpleRec45];
    purpleRec45.hidden = YES;
    _purple45Rec = purpleRec45;
    
    UILabel *x8 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.46153846, self.view.frame.size.height/2.48704663, self.view.frame.size.width/16, self.view.frame.size.height/48)];
    x8.text = @"x";
    [x8 setFont: [UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    [menuDrawer addSubview:x8];
    x8.hidden = YES;
    _x8 = x8;
    
    NLMButton *greenRec45 = [[NLMButton alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, self.view.frame.size.height/2.4,buttonSize.width , buttonSize.height)];
    [greenRec45 setImage:[UIImage imageNamed:@"GreenRec"] forState:UIControlStateNormal];
    [greenRec45 addTarget:self action:@selector(Green45Available:) forControlEvents:UIControlEventTouchUpInside];
    [menuDrawer addSubview:greenRec45];
    greenRec45.hidden = YES;
    _green45Rec = greenRec45;
    
    UILabel *x9 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.46153846, self.view.frame.size.height/2.25352113, self.view.frame.size.width/16, self.view.frame.size.height/48)];
    x9.text = @"x";
    [x9 setFont: [UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    [menuDrawer addSubview:x9];
    x9.hidden = YES;
    _x9 = x9;
    
    NLMButton *orangeRec45 = [[NLMButton alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, self.view.frame.size.height/2.18181818,buttonSize.width , buttonSize.height)];
    [orangeRec45 setImage:[UIImage imageNamed:@"OrangeRec"] forState:UIControlStateNormal];
    [orangeRec45 addTarget:self action:@selector(Orange45Available:) forControlEvents:UIControlEventTouchUpInside];
    [menuDrawer addSubview:orangeRec45];
    orangeRec45.hidden = YES;
    _orange45Rec = orangeRec45;
    
    UILabel *x10 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.46153846, self.view.frame.size.height/2.06008584, self.view.frame.size.width/16, self.view.frame.size.height/48)];
    x10.text = @"x";
    [x10 setFont: [UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    [menuDrawer addSubview:x10];
    x10.hidden = YES;
    _x10 = x10;
    
    NLMButton *yellowRec45 = [[NLMButton alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, self.view.frame.size.height/2,buttonSize.width , buttonSize.height)];
    [yellowRec45 setImage:[UIImage imageNamed:@"YellowRec"] forState:UIControlStateNormal];
    [yellowRec45 addTarget:self action:@selector(Yellow45Available:) forControlEvents:UIControlEventTouchUpInside];
    [menuDrawer addSubview:yellowRec45];
    yellowRec45.hidden = YES;
    _yellow45Rec = yellowRec45;
    
    UILabel *x11 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.46153846, self.view.frame.size.height/1.8972332, self.view.frame.size.width/16, self.view.frame.size.height/48)];
    x11.text = @"x";
    [x11 setFont: [UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    [menuDrawer addSubview:x11];
    x11.hidden = YES;
    _x11 = x11;
    
    NLMButton *recRec45 = [[NLMButton alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, self.view.frame.size.height/1.884615385,buttonSize.width , buttonSize.height)];
    [recRec45 setImage:[UIImage imageNamed:@"BlueRec"] forState:UIControlStateNormal];
    [recRec45 addTarget:self action:@selector(Blue45Available:) forControlEvents:UIControlEventTouchUpInside];
    [menuDrawer addSubview:recRec45];
    recRec45.hidden = YES;
    _blue45Rec = recRec45;
    
    UILabel *x12 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.46153846, self.view.frame.size.height/1.79104478, self.view.frame.size.width/16, self.view.frame.size.height/48)];
    x12.text = @"x";
    [x12 setFont: [UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    [menuDrawer addSubview:x12];
    x12.hidden = YES;
    _x12 = x12;
    
    UILabel *fortyFiveNeg = [[UILabel alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, self.view.frame.size.height/1.71428571, buttonSize.width, buttonSize.height)];
    [fortyFiveNeg setFont:[UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    fortyFiveNeg.text = @"-45˚";
    [menuDrawer addSubview:fortyFiveNeg];
    
    NLMButton *redRecneg45 = [[NLMButton alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, self.view.frame.size.height/1.6,buttonSize.width , buttonSize.height)];
    [redRecneg45 setImage:[UIImage imageNamed:@"RedRec"] forState:UIControlStateNormal];
    [redRecneg45 addTarget:self action:@selector(Redneg45Available:) forControlEvents:UIControlEventTouchUpInside];
    [menuDrawer addSubview:redRecneg45];
    redRecneg45.hidden = YES;
    _redneg45Rec = redRecneg45;
    
    UILabel *x13 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.46153846, self.view.frame.size.height/1.53354633, self.view.frame.size.width/16, self.view.frame.size.height/48)];
    x13.text = @"x";
    [x13 setFont: [UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    [menuDrawer addSubview:x13];
    x13.hidden = YES;
    _x13 = x13;
    
    NLMButton *purpleRecneg45 = [[NLMButton alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, self.view.frame.size.height/1.5,buttonSize.width , buttonSize.height)];
    [purpleRecneg45 setImage:[UIImage imageNamed:@"PurpleRec"] forState:UIControlStateNormal];
    [purpleRecneg45 addTarget:self action:@selector(Purpleneg45Available:) forControlEvents:UIControlEventTouchUpInside];
    [menuDrawer addSubview:purpleRecneg45];
    purpleRecneg45.hidden = YES;
    _purpleneg45Rec = purpleRecneg45;
    
    UILabel *x14 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.46153846, self.view.frame.size.height/1.44144144, self.view.frame.size.width/16, self.view.frame.size.height/48)];
    x14.text = @"x";
    [x14 setFont: [UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    [menuDrawer addSubview:x14];
    x14.hidden = YES;
    _x14 = x14;
    
    NLMButton *greenRecneg45 = [[NLMButton alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, self.view.frame.size.height/1.41176471,buttonSize.width , buttonSize.height)];
    [greenRecneg45 setImage:[UIImage imageNamed:@"GreenRec"] forState:UIControlStateNormal];
    
    [greenRecneg45 addTarget:self action:@selector(Greenneg45Available:) forControlEvents:UIControlEventTouchUpInside];
    [menuDrawer addSubview:greenRecneg45];
    greenRecneg45.hidden = YES;
    _greenneg45Rec = greenRecneg45;
    
    UILabel *x15 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.46153846, self.view.frame.size.height/1.35977337, self.view.frame.size.width/16, self.view.frame.size.height/48)];
    x15.text = @"x";
    [x15 setFont: [UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    [menuDrawer addSubview:x15];
    x15.hidden = YES;
    _x15 = x15;
    
    NLMButton *orangeRecneg45 = [[NLMButton alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, self.view.frame.size.height/1.33333333,buttonSize.width , buttonSize.height)];
    [orangeRecneg45 setImage:[UIImage imageNamed:@"OrangeRec"] forState:UIControlStateNormal];
    
    [orangeRecneg45 addTarget:self action:@selector(Orangeneg45Available:) forControlEvents:UIControlEventTouchUpInside];
    [menuDrawer addSubview:orangeRecneg45];
    orangeRecneg45.hidden = YES;
    _orangeneg45Rec = orangeRecneg45;
    
    UILabel *x16 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.46153846, self.view.frame.size.height/1.28686327, self.view.frame.size.width/16, self.view.frame.size.height/48)];
    x16.text = @"x";
    [x16 setFont: [UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    [menuDrawer addSubview:x16];
    x16.hidden = YES;
    _x16 = x16;
    
    NLMButton *yellowRecneg45 = [[NLMButton alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, self.view.frame.size.height/1.26315789,buttonSize.width , buttonSize.height)];
    [yellowRecneg45 setImage:[UIImage imageNamed:@"YellowRec"] forState:UIControlStateNormal];
    
    [yellowRecneg45 addTarget:self action:@selector(Yellowneg45Available:) forControlEvents:UIControlEventTouchUpInside];
    [menuDrawer addSubview:yellowRecneg45];
    yellowRecneg45.hidden = YES;
    _yellowneg45Rec = yellowRecneg45;
    
    UILabel *x17 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.46153846,self.view.frame.size.height/1.22137405, self.view.frame.size.width/16, self.view.frame.size.height/48)];
    x17.text = @"x";
    [x17 setFont: [UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    [menuDrawer addSubview:x17];
    x17.hidden = YES;
    _x17 = x17;
    
    NLMButton *recRecneg45 = [[NLMButton alloc] initWithFrame:CGRectMake(menuDrawer.frame.size.width/10, self.view.frame.size.height/1.2,buttonSize.width , buttonSize.height)];
    [recRecneg45 setImage:[UIImage imageNamed:@"BlueRec"] forState:UIControlStateNormal];
    [recRecneg45 addTarget:self action:@selector(Blueneg45Available:) forControlEvents:UIControlEventTouchUpInside];
    [menuDrawer addSubview:recRecneg45];
    recRecneg45.hidden = YES;
    _blueneg45Rec = recRecneg45;
    
    UILabel *x18 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.46153846, self.view.frame.size.height/1.1622276, self.view.frame.size.width/16, self.view.frame.size.height/48)];
    x18.text = @"x";
    [x18 setFont: [UIFont fontWithName:@"Copperplate" size:self.view.frame.size.height / 35.5]];
    [menuDrawer addSubview:x18];
    x18.hidden = YES;
    _x18 = x18;
    
    [self createSliderBackGround];
    
    //Game Center
    //[self authenticateLocalPlayer];
}


-(void)hideAllButtons{
    _redRec.hidden = YES;
    _purpleRec.hidden = YES;
    _blueRec.hidden = YES;
    _greenRec.hidden = YES;
    _yellowRec.hidden = YES;
    _orangeRec.hidden = YES;
    _red45Rec.hidden = YES;
    _purple45Rec.hidden = YES;
    _blue45Rec.hidden = YES;
    _green45Rec.hidden = YES;
    _yellow45Rec.hidden = YES;
    _orange45Rec.hidden = YES;;
    _redneg45Rec.hidden = YES;
    _purpleneg45Rec.hidden = YES;
    _blueneg45Rec.hidden = YES;
    _greenneg45Rec.hidden = YES;
    _yellowneg45Rec.hidden = YES;
    _orangeneg45Rec.hidden = YES;
    _x.hidden = YES;
    _x2.hidden = YES;
    _x3.hidden = YES;
    _x4.hidden = YES;
    _x5.hidden = YES;
    _x6.hidden = YES;
    _x7.hidden = YES;
    _x8.hidden = YES;
    _x9.hidden = YES;
    _x10.hidden = YES;
    _x11.hidden = YES;
    _x12.hidden = YES;
    _x13.hidden = YES;
    _x14.hidden = YES;
    _x15.hidden = YES;
    _x16.hidden = YES;
    _x17.hidden = YES;
    _x18.hidden = YES;
    
}

-(void)createSliderBackGround
{
    UIImage *image = [UIImage imageNamed:@"sliderBack"];
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, menuDrawer.frame.size.width,self.view.frame.size.height/3.2 )];
    [iv setImage:image];
    [menuDrawer addSubview:iv];
    [menuDrawer sendSubviewToBack:iv];
    
    UIImage *image2 = [UIImage imageNamed:@"sliderBack"];
    UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/3.42857143, menuDrawer.frame.size.width,self.view.frame.size.height/3.2 )];
    [iv2 setImage:image2];
    [menuDrawer addSubview:iv2];
    [menuDrawer sendSubviewToBack:iv2];
    
    UIImage *image3 = [UIImage imageNamed:@"sliderBack"];
    UIImageView *iv3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/1.71428571, menuDrawer.frame.size.width,self.view.frame.size.height/3.2 )];
    [iv3 setImage:image3];
    [menuDrawer addSubview:iv3];
    [menuDrawer sendSubviewToBack:iv3];
    
    
    UIImage *image4 = [UIImage imageNamed:@"sliderBackwithRec"];
    UIImageView *iv4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/1.14285714, menuDrawer.frame.size.width,self.view.frame.size.height/3.2)];
    [iv4 setImage:image4];
    [menuDrawer addSubview:iv4];
    [menuDrawer sendSubviewToBack:iv4];
}

-(void)addRecsToSlider:(int) angle HowMany:(int) numOf whatColor: (colorRec) color{
    numOfRec = 1;
    
    if (color == blue) {
        if (angle == 45) {
            
            _x12.hidden = NO;
            _blue45Rec.hidden = NO;
            numOfTimes[0] = numOf;
            [_x12 setText:[NSString stringWithFormat:@"x%i",numOf]];
        }
        else if (angle == -45)
        {
            
            _x18.hidden = NO;
            _blueneg45Rec.hidden = NO;
            numOfTimes[1] = numOf;
            [_x18 setText:[NSString stringWithFormat:@"x%i",numOf]];
        }
        else if (angle == 0)
        {
            
            _x6.hidden = NO;
            _blueRec.hidden = NO;
            numOfTimes[2] = numOf;
            [_x6 setText:[NSString stringWithFormat:@"x%i",numOf]];
        }
    }
    if (color == yellow) {
        
        if (angle == 45) {
            _x11.hidden = NO;
            _yellow45Rec.hidden = NO;
            numOfTimes[3] = numOf;
            [_x11 setText:[NSString stringWithFormat:@"x%i",numOf]];
        }
        else if (angle == -45)
        {
            
            _x17.hidden = NO;
            _yellowneg45Rec.hidden = NO;
            numOfTimes[4] = numOf;
            [_x17 setText:[NSString stringWithFormat:@"x%i",numOf]];
        }
        else if (angle == 0)
        {
            
            _x5.hidden = NO;
            _yellowRec.hidden = NO;
            numOfTimes[5] = numOf;
            [_x5 setText:[NSString stringWithFormat:@"x%i",numOf]];
        }
        
    }
    if (color == green) {
        if (angle == 45) {
            
            _x9.hidden = NO;
            _green45Rec.hidden = NO;
            numOfTimes[6] = numOf;
            [_x9 setText:[NSString stringWithFormat:@"x%i",numOf]];
        }
        else if (angle == -45)
        {
            
            _x15.hidden = NO;
            _greenneg45Rec.hidden = NO;
            numOfTimes[7] = numOf;
            [_x15 setText:[NSString stringWithFormat:@"x%i",numOf]];
        }
        else if (angle == 0)
        {
            
            _x3.hidden = NO;
            _greenRec.hidden = NO;
            numOfTimes[8] = numOf;
            [_x3 setText:[NSString stringWithFormat:@"x%i",numOf]];
        }
        
    }
    if (color == orange) {
        if (angle == 45) {
            
            _x10.hidden = NO;
            _orange45Rec.hidden = NO;
            numOfTimes[9] = numOf;
            [_x10 setText:[NSString stringWithFormat:@"x%i",numOf]];
        }
        else if (angle == -45)
        {
            
            _x16.hidden = NO;
            _orangeneg45Rec.hidden = NO;
            numOfTimes[10] = numOf;
            [_x16 setText:[NSString stringWithFormat:@"x%i",numOf]];
        }
        else if (angle == 0)
        {
            
            _x4.hidden = NO;
            _orangeRec.hidden = NO;
            numOfTimes[11] = numOf;
            [_x4 setText:[NSString stringWithFormat:@"x%i",numOf]];
        }
        
    }
    if (color == red) {
        if (angle == 45) {
            
            _x7.hidden = NO;
            _red45Rec.hidden = NO;
            numOfTimes[12] = numOf;
            [_x7 setText:[NSString stringWithFormat:@"x%i",numOf]];
        }
        else if (angle == -45)
        {
            
            _x13.hidden = NO;
            _redneg45Rec.hidden = NO;
            numOfTimes[13] = numOf;
            [_x13 setText:[NSString stringWithFormat:@"x%i",numOf]];
        }
        else if (angle == 0)
        {
            _x.hidden = NO;
            _redRec.hidden = NO;
            NSLog(@"adding new rec");
            numOfTimes[14] = numOf;
            [_x setText:[NSString stringWithFormat:@"x%i",numOf]];
        }
        
        
    }
    if (color == purple) {
        if (angle == 45) {
            
            _x8.hidden = NO;
            _purple45Rec.hidden = NO;
            numOfTimes[15] = numOf;
            [_x8 setText:[NSString stringWithFormat:@"x%i",numOf]];
        }
        else if (angle == -45)
        {
            
            _x14.hidden = NO;
            _purpleneg45Rec.hidden = NO;
            NSLog(@"16 = 1");
            numOfTimes[16] = numOf;
            [_x14 setText:[NSString stringWithFormat:@"x%i",numOf]];
        }
        else if (angle == 0)
        {
            _x2.hidden = NO;
            _purpleRec.hidden = NO;
            numOfTimes[17] = numOf;
            [_x2 setText:[NSString stringWithFormat:@"x%i",numOf]];
        }
        
    }
}

-(void)RedAvailable: (NLMButton *) sender
{
    
    SKScene * scene = _skView.scene;
    if (numOfTimes[14]>0) {
        [(MyScene *)scene createRec:smallRec withAngle:0 withColor:red withPosition:CGPointMake(scene.size.width/2  , scene.size.height/2) withNumber:[NSString stringWithFormat:@"%i", numOfRec]];
        numOfRec++;
        [self shutSlider];
        numOfTimes[14]--;
        [_x setText:[NSString stringWithFormat:@"x%li",(long)numOfTimes[14]]];
    }
    if (numOfTimes[14] == 0) {
        NSLog(@"rmeove");
        _redRec.hidden = YES;
        _x.hidden = YES;
    }
}
-(void)BlueAvailable: (NLMButton *) sender
{
    if (numOfTimes[2]>0) {
        SKScene * scene = _skView.scene;
        [(MyScene *)scene createRec:smallRec withAngle:0 withColor:blue withPosition:CGPointMake(scene.size.width/2  , scene.size.height/2) withNumber:[NSString stringWithFormat:@"%i", numOfRec]];
        [self shutSlider];
        numOfRec++;
        numOfTimes[2]--;
        [_x6 setText:[NSString stringWithFormat:@"x%li",(long)numOfTimes[2]]];
    }
    if (numOfTimes[2] == 0) {
        _blueRec.hidden = YES;
        _x6.hidden = YES;
    }
    
}
-(void)PurpleAvailable: (NLMButton *) sender
{
    if (numOfTimes[17]>0) {
        SKScene * scene = _skView.scene;
        [(MyScene *)scene createRec:smallRec withAngle:0 withColor:purple withPosition:CGPointMake(scene.size.width/2  , scene.size.height/2) withNumber:[NSString stringWithFormat:@"%i", numOfRec]];
        [self shutSlider];
        numOfRec++;
        numOfTimes[17]--;
        [_x2 setText:[NSString stringWithFormat:@"x%li",(long)numOfTimes[17]]];
    }
    if (numOfTimes[17] == 0) {
        _purpleRec.hidden = YES;
        _x2.hidden = YES;
    }
    
}
-(void)GreenAvailable: (NLMButton *) sender
{
    if (numOfTimes[8]>0) {
        SKScene * scene = _skView.scene;
        [(MyScene *)scene createRec:smallRec withAngle:0 withColor:green withPosition:CGPointMake(scene.size.width/2  , scene.size.height/2) withNumber:[NSString stringWithFormat:@"fG"]];
        
        [self shutSlider];
        numOfRec++;
        numOfTimes[8]--;
        [_x3 setText:[NSString stringWithFormat:@"x%li",(long)numOfTimes[8]]];
    }
    if (numOfTimes[8] == 0) {
        _greenRec.hidden = YES;
        _x3.hidden = YES;
    }
    
}
-(void)YellowAvailable: (NLMButton *) sender
{
    if (numOfTimes[5]>0) {
        SKScene * scene = _skView.scene;
        [(MyScene *)scene createRec:smallRec withAngle:0 withColor:yellow withPosition:CGPointMake(scene.size.width/2  , scene.size.height/2) withNumber:[NSString stringWithFormat:@"%i", numOfRec]];
        [self shutSlider];
        numOfRec++;
        numOfTimes[5]--;
        [_x5 setText:[NSString stringWithFormat:@"x%li",(long)numOfTimes[5]]];
        
    }
    if (numOfTimes[5] == 0) {
        _yellowRec.hidden = YES;
        _x5.hidden = YES;
    }
    
}
-(void)OrangeAvailable: (NLMButton *) sender
{
    if (numOfTimes[11]>0) {
        SKScene * scene = _skView.scene;
        [(MyScene *)scene createRec:smallRec withAngle:0 withColor:orange withPosition:CGPointMake(scene.size.width/2  , scene.size.height/2) withNumber:[NSString stringWithFormat:@"%i", numOfRec]];
        [self shutSlider];
        numOfRec++;
        numOfTimes[11]--;
        [_x4 setText:[NSString stringWithFormat:@"x%li",(long)numOfTimes[11]]];
    }
    if (numOfTimes[11] == 0) {
        _orangeRec.hidden = YES;
        _x4.hidden = YES;
    }
    
}
-(void)Red45Available: (NLMButton *) sender
{
    NSLog(@"red45created");
    if (numOfTimes[12]>0) {
        SKScene * scene = _skView.scene;
        [(MyScene *)scene createRec:smallRec withAngle:45 withColor:red withPosition:CGPointMake(scene.size.width/2  , scene.size.height/2) withNumber:[NSString stringWithFormat:@"%i", numOfRec]];
        [self shutSlider];
        
        numOfRec++;
        numOfTimes[12]--;
        [_x7 setText:[NSString stringWithFormat:@"x%li",(long)numOfTimes[12]]];
    }
    if (numOfTimes[12] == 0) {
        _red45Rec.hidden = YES;
        _x7.hidden = YES;
    }
    
}
-(void)Blue45Available: (NLMButton *) sender
{
    if (numOfTimes[0]>0) {
        SKScene * scene = _skView.scene;
        
        [(MyScene *)scene createRec:smallRec withAngle:45 withColor:blue withPosition:CGPointMake(scene.size.width/2  , scene.size.height/2) withNumber:[NSString stringWithFormat:@"%i", numOfRec]];
        [self shutSlider];
        numOfRec++;
        numOfTimes[0]--;
        [_x12 setText:[NSString stringWithFormat:@"x%li",(long)numOfTimes[0]]];
    }
    if (numOfTimes[0] == 0) {
        _blue45Rec.hidden = YES;
        _x12.hidden = YES;
    }
    
}
-(void)Purple45Available: (NLMButton *) sender
{
    if (numOfTimes[15]>0) {
        SKScene * scene = _skView.scene;
        [(MyScene *)scene createRec:smallRec withAngle:45 withColor:purple withPosition:CGPointMake(scene.size.width/2  , scene.size.height/2) withNumber:[NSString stringWithFormat:@"%i", numOfRec]];
        [self shutSlider];
        numOfRec++;
        numOfTimes[15]--;
        [_x8 setText:[NSString stringWithFormat:@"x%li",(long)numOfTimes[15]]];
    }
    if (numOfTimes[15] == 0) {
        _purple45Rec.hidden = YES;
        _x8.hidden = YES;
    }
    
}
-(void)Green45Available: (NLMButton *) sender
{
    if (numOfTimes[6]>0) {
        
        SKScene * scene = _skView.scene;
        [(MyScene *)scene createRec:smallRec withAngle:45 withColor:green withPosition:CGPointMake(scene.size.width/2  , scene.size.height/2) withNumber:[NSString stringWithFormat:@"fG"]];
        
        [self shutSlider];
        numOfRec++;
        numOfTimes[6]--;
        [_x9 setText:[NSString stringWithFormat:@"x%li",(long)numOfTimes[6]]];
    }
    if (numOfTimes[6] == 0) {
        _green45Rec.hidden = YES;
        _x9.hidden = YES;
    }
    
}
-(void)Yellow45Available: (NLMButton *) sender
{
    if (numOfTimes[3]>0) {
        SKScene * scene = _skView.scene;
        [(MyScene *)scene createRec:smallRec withAngle:45 withColor:yellow withPosition:CGPointMake(scene.size.width/2  , scene.size.height/2) withNumber:[NSString stringWithFormat:@"%i", numOfRec]];
        [self shutSlider];
        numOfRec++;
        numOfTimes[3]--;
        [_x11 setText:[NSString stringWithFormat:@"x%li",(long)numOfTimes[3]]];
    }
    if (numOfTimes[3] == 0) {
        _yellow45Rec.hidden = YES;
        _x11.hidden = YES;
    }
    
}
-(void)Orange45Available: (NLMButton *) sender
{
    if (numOfTimes[9]>0) {
        SKScene * scene = _skView.scene;
        [(MyScene *)scene createRec:smallRec withAngle:45 withColor:orange withPosition:CGPointMake(scene.size.width/2  , scene.size.height/2) withNumber:[NSString stringWithFormat:@"%i", numOfRec]];
        [self shutSlider];
        numOfRec++;
        numOfTimes[9]--;
        [_x10 setText:[NSString stringWithFormat:@"x%li",(long)numOfTimes[9]]];
    }
    if (numOfTimes[9] == 0) {
        _orange45Rec.hidden = YES;
        _x10.hidden = YES;
    }
    
}
-(void)Redneg45Available: (NLMButton *) sender
{
    if (numOfTimes[13]>0) {
        SKScene * scene = _skView.scene;
        [(MyScene *)scene createRec:smallRec withAngle:-45 withColor:red withPosition:CGPointMake(scene.size.width/2  , scene.size.height/2) withNumber:[NSString stringWithFormat:@"%i", numOfRec]];
        [self shutSlider];
        numOfRec++;
        numOfTimes[13]--;
        [_x13 setText:[NSString stringWithFormat:@"x%li",(long)numOfTimes[13]]];
    }
    if (numOfTimes[13] == 0) {
        _redneg45Rec.hidden = YES;
        _x13.hidden = YES;
    }
}
-(void)Blueneg45Available: (NLMButton *) sender
{
    if (numOfTimes[1]>0) {
        SKScene * scene = _skView.scene;
        [(MyScene *)scene createRec:smallRec withAngle:-45 withColor:blue withPosition:CGPointMake(scene.size.width/2  , scene.size.height/2) withNumber:[NSString stringWithFormat:@"%i", numOfRec]];
        [self shutSlider];
        numOfRec++;
        numOfTimes[1]--;
        [_x18 setText:[NSString stringWithFormat:@"x%li",(long)numOfTimes[1]]];
    }
    if (numOfTimes[1] == 0) {
        _blueneg45Rec.hidden = YES;
        _x18.hidden = YES;
    }
    
}
-(void)Purpleneg45Available: (NLMButton *) sender
{
    if (numOfTimes[16]>0) {
        
        SKScene * scene = _skView.scene;
        [(MyScene *)scene createRec:smallRec withAngle:-45 withColor:purple withPosition:CGPointMake(scene.size.width/2  , scene.size.height/2) withNumber:[NSString stringWithFormat:@"%i", numOfRec]];
        [self shutSlider];
        numOfRec++;
        numOfTimes[16]--;
        [_x14 setText:[NSString stringWithFormat:@"x%li",(long)numOfTimes[16]]];
    }
    if (numOfTimes[16] == 0) {
        _purpleneg45Rec.hidden = YES;
        _x14.hidden = YES;
    }
    
}
-(void)Greenneg45Available: (NLMButton *) sender
{
    if (numOfTimes[7]>0) {
        SKScene * scene = _skView.scene;
        [(MyScene *)scene createRec:smallRec withAngle:-45 withColor:green withPosition:CGPointMake(scene.size.width/2  , scene.size.height/2) withNumber:[NSString stringWithFormat:@"fG"]];
        
        [self shutSlider];
        numOfRec++;
        numOfTimes[7]--;
        [_x15 setText:[NSString stringWithFormat:@"x%li",(long)numOfTimes[7]]];
    }
    if (numOfTimes[7] == 0) {
        _greenneg45Rec.hidden = YES;
        _x15.hidden = YES;
    }
    
}
-(void)Yellowneg45Available: (NLMButton *) sender
{
    if (numOfTimes[4]>0) {
        SKScene * scene = _skView.scene;
        [(MyScene *)scene createRec:smallRec withAngle:-45 withColor:yellow withPosition:CGPointMake(scene.size.width/2  , scene.size.height/2) withNumber:[NSString stringWithFormat:@"%i", numOfRec]];
        [self shutSlider];
        numOfRec++;
        numOfTimes[4]--;
        [_x17 setText:[NSString stringWithFormat:@"x%li",(long)numOfTimes[4]]];
    }
    if (numOfTimes[4] == 0) {
        _yellowneg45Rec.hidden = YES;
        _x17.hidden = YES;
    }
    
}
-(void)Orangeneg45Available: (NLMButton *) sender
{
    if (numOfTimes[10]>0) {
        SKScene * scene = _skView.scene;
        [(MyScene *)scene createRec:smallRec withAngle:-45 withColor:orange withPosition:CGPointMake(scene.size.width/2  , scene.size.height/2) withNumber:[NSString stringWithFormat:@"%i", numOfRec]];
        [self shutSlider];
        numOfRec++;
        numOfTimes[10]--;
        [_x16 setText:[NSString stringWithFormat:@"x%li",(long)numOfTimes[10]]];
    }
    if (numOfTimes[10] == 0) {
        _orangeneg45Rec.hidden = YES;
        _x16.hidden = YES;
    }
    
}






-(void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    
    
    
    if (sender.direction == open.direction ) {
        sliderMove = NO;
        [self drawerAnimation:1];
        
    }
    if (sender.direction == close.direction) {
        sliderMove = YES;
        [self drawerAnimation:2];
        
    }
    
}
-(void)drawerAnimation: (int) type
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:-5];
    
    CGFloat newX = 0.0;
    if (type == 1 && sliderMove == YES) {
        newX = menuDrawer.frame.origin.x + menuDrawerWidth;
    }
    else if (type == 2 && sliderMove == YES)
    {
        newX = menuDrawer.frame.origin.x - menuDrawerWidth;
    }
    if (sliderShow) {
        
        
        menuDrawer.frame = CGRectMake(newX, menuDrawer.frame.origin.y, menuDrawer.frame.size.width, menuDrawer.frame.size.height);
        [UIView commitAnimations];
    }
    
}

-(bool)isSliderClosed
{
    if(sliderMove == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void)shutSlider{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:-5];
    sliderMove = YES;
    menuDrawer.frame = CGRectMake(menuDrawer.frame.origin.x - menuDrawerWidth, menuDrawer.frame.origin.y, menuDrawer.frame.size.width, menuDrawer.frame.size.height);
    [UIView commitAnimations];

}

-(void)openSlider{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:-5];
    sliderMove = NO;
    menuDrawer.frame = CGRectMake(menuDrawer.frame.origin.x + menuDrawerWidth, menuDrawer.frame.origin.y, menuDrawer.frame.size.width, menuDrawer.frame.size.height);
    [UIView commitAnimations];
    
    
}

-(void)LevelSceneDidShowOn{
    
    sliderShow = YES;
}

-(void)LevelSceneDidShowOff{
    sliderShow = NO;
}

-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard{
    GKGameCenterViewController *gcViewController = [[GKGameCenterViewController alloc] init];
    
    gcViewController.gameCenterDelegate = self;
    
    if (shouldShowLeaderboard) {
        gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gcViewController.leaderboardIdentifier = _leaderboardIdentifier;
    }
    else{
        gcViewController.viewState = GKGameCenterViewControllerStateAchievements;
    }
    
    [self presentViewController:gcViewController animated:YES completion:nil];
}

-(void)authenticateLocalPlayer{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    NSLog(@"called");
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil) {
            [self presentViewController:viewController animated:YES completion:nil];
            NSLog(@"Not authenticated");
        }
        else{
            if ([GKLocalPlayer localPlayer].authenticated) {
                _gameCenterEnabled = YES;
                
                NSLog(@"was authenticated");
                // Get the default leaderboard identifier.
                [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
                    
                    if (error != nil) {
                        NSLog(@"%@", [error localizedDescription]);
                    }
                    else{
                        _leaderboardIdentifier = leaderboardIdentifier;
                    }
                }];
            }
            
            else{
                _gameCenterEnabled = NO;
                
            }
        }
    };
}

-(void)MainMenuDidShow{
    [_reportScoreButton show:YES];
    [_shareButton show:YES];
    [_playButton show:YES];
    _helpButton.hidden = NO;
}

-(void)WorldMenuDidShow{
    [_reportScoreButton hide:YES];
    [_shareButton hide:YES];
    [_playButton hide:YES];
    _helpButton.hidden = YES;
}

- (IBAction)showGCOptions:(id)sender {
    // Allow the action sheet to be displayed if only the gameCenterEnabled flag is true, meaning if only
    // a player has been authenticated.
    if (_gameCenterEnabled) {
        if (_customActionSheet!= nil) {
            _customActionSheet = nil;
        }
        
        // Create a CustomActionSheet object and handle the tapped button in the completion handler block.
        _customActionSheet = [[CustomActionSheet alloc] initWithTitle:@""
                                                             delegate:nil
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles: @"View Achievements", nil];
        [_customActionSheet showInView:self.view
                 withCompletionHandler:^(NSString *buttonTitle, NSInteger buttonIndex) {
                     
                     if ([buttonTitle isEqualToString:@"View Achievements"]) {
                         
                         [self updateAchievements];
                         [self showLeaderboardAndAchievements:YES];
                     }
                     
                     
                 }];
    }
    
}

- (void)reportScoreButtonPressed:(NLMButton*)sender{
    [self updateAchievements];
    
    if (!(_gameCenterEnabled)) {
        
        UIAlertView *succes = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please log in your Game Center account." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [succes show];
        
    }
    
}

-(void)updateAchievements{
    _score = [[NSUserDefaults standardUserDefaults] integerForKey: @"levelUnlock"];
    unlocked = [[NSUserDefaults standardUserDefaults] integerForKey: @"unlocked"];
    
    NSString *achievementIdentifier;
    float progressPercentage = 0.0;
    BOOL progressInLevelAchievement = NO;
    
    GKAchievement *levelAchievement = nil;
    GKAchievement *scoreAchievement = nil;
    
    if (_score == 1) {
        
        
        
        if (unlocked == 0){
            progressPercentage = 100 ;
            achievementIdentifier = RECTANGLEDACHIEVEMENT_ID1;
            [GKNotificationBanner showBannerWithTitle:@"Level 1" message:@"You Beat Level 1!" completionHandler:nil];
        }
        
        unlocked = 1;
        [self saveAchievements];
        
    }
    
    if (_score == 5) {
        
        if(unlocked == 1){
            progressPercentage = 100 ;
            achievementIdentifier = RECTANGLEDACHIEVEMENT_ID2;
            [GKNotificationBanner showBannerWithTitle:@"Line" message:@"You've Completed World 1!" completionHandler:nil];
        }
        unlocked = 2;
        [self saveAchievements];
    }
    
    if (_score == 10) {
        
        if(unlocked == 2){
            progressPercentage = 100 ;
            achievementIdentifier = RECTANGLEDACHIEVEMENT_ID3;
            [GKNotificationBanner showBannerWithTitle:@"Angle" message:@"You've Completed World 2!" completionHandler:nil];
            
        }
        
        unlocked = 3;
        [self saveAchievements];
        
    }
    
    if (_score == 15) {
        if (unlocked == 3) {
            progressPercentage = 100 ;
            achievementIdentifier = RECTANGLEDACHIEVEMENT_ID4;
            [GKNotificationBanner showBannerWithTitle:@"Triangle" message:@"You've Completed World 3!" completionHandler:nil];
        }
        unlocked = 4;
        [self saveAchievements];
    }
    
    if (_score == 20) {
        if(unlocked == 4){
            progressPercentage = 100 ;
            achievementIdentifier = RECTANGLEDACHIEVEMENT_ID5;
            [GKNotificationBanner showBannerWithTitle:@"Square" message:@"You've Completed World 4!" completionHandler:nil];
        }
        
        unlocked = 5;
        [self saveAchievements];
    }
    
    if (_score == 25) {
        if(unlocked == 5){
            progressPercentage = 100 ;
            achievementIdentifier = RECTANGLEDACHIEVEMENT_ID6;
            [GKNotificationBanner showBannerWithTitle:@"Pentagon" message:@"You've Completed World 5!" completionHandler:nil];
        }
        
        unlocked = 6;
        [self saveAchievements];
    }
    
    if (_score == 30) {
        if(unlocked == 6){
            progressPercentage = 100 ;
            achievementIdentifier = RECTANGLEDACHIEVEMENT_ID7;
            [GKNotificationBanner showBannerWithTitle:@"Hexagon" message:@"You've Completed World 6!" completionHandler:nil];
        }
        [self saveAchievements];
    }
    
    
    if (_score == 30) {
        if(unlocked == 6){
            progressPercentage = 100 ;
            achievementIdentifier = RECTANGLEDACHIEVEMENT_ID8;
            [GKNotificationBanner showBannerWithTitle:@"Rectangled Beaten" message:@"You Beat Rectangled!" completionHandler:nil];
        }
        unlocked = 7;
        [self saveAchievements];
    }
    
    scoreAchievement = [[GKAchievement alloc] initWithIdentifier:achievementIdentifier];
    scoreAchievement.percentComplete = progressPercentage;
    
    
    
    NSArray *achievements = (progressInLevelAchievement) ? @[levelAchievement, scoreAchievement] : @[scoreAchievement];
    
    [GKAchievement reportAchievements:achievements withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            //NSLog(@&quot;%@&quot;, [error localizedDescription]);
        }
    }];
}
-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(BOOL) prefersStatusBarHidden
{
    return YES;
}

- (void)shareButtonPressed:(NLMButton*)sender {
    static BOOL isSharing = NO;
    NSLog(@"sharing");
    if(isSharing) {
        return;
    }
    
    sender.enabled = NO;
    
    isSharing = YES;
    
    [UIView animateWithDuration:.5 animations:^{
        
    } completion:^(BOOL finished) {
        UIView* screenshotView = self.view; //[self.view snapshotViewAfterScreenUpdates:YES];
        UIImage *screenShot = [self imageFromView:screenshotView];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSString* filepath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"screenShot.jpg"];
            
            NSData* imageData = UIImageJPEGRepresentation(screenShot, 1.f);
            
            
            [imageData writeToFile:filepath atomically:YES];
            NSLog(@"%@",filepath);
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                _shareController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filepath]];
                
                [_shareController presentOptionsMenuFromRect:sender.frame inView:sender.superview animated:YES];
                
                
                sender.enabled = YES;
                
                isSharing = NO;
                
            });
        });
    }];
    
    
}

- (UIImage *)imageFromView:(UIView*)view
{
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES,[UIScreen mainScreen].scale);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

- (void)playButtonPressed: (NLMButton *)sender{
    
    [self WorldMenuDidShow];
    WorldScreen *wScene = [WorldScreen sceneWithSize:self.view.bounds.size];
    wScene.MWDelegate = self;
    wScene.scaleMode = SKSceneScaleModeAspectFill;
    [_skView presentScene:wScene transition:[ SKTransition doorsCloseVerticalWithDuration:1]];
    NSLog(@"play button pressed");

}

-(void)saveAchievements {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:unlocked forKey:@"unlocked"];
    [defaults synchronize];
    
}

@end
