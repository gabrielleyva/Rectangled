//
//  WorldScreen.m
//  Ball Drop Test
//
//  Created by Evan Noble on 5/21/14.
//  Copyright (c) 2014 Lykos Technologies LLC. All rights reserved.
//

#import "WorldScreen.h"
#import "MyScene.h"
#import "MainMenu.h"
#import "ViewController.h"

@implementation WorldScreen
{
    SKNode *_world1;
    SKNode *world2;
    SKNode *world3;
    SKNode *world4;
    SKNode *world5;
    SKSpriteNode *_back;
    long levelUnlock;
    CGSize levelSize;
}


-(id) initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
       SKNode *world1 = [SKNode node];
        _world1 = world1;
       
        levelUnlock = [[NSUserDefaults standardUserDefaults] integerForKey: @"levelUnlock"];
        self.backgroundColor = [UIColor blackColor];
        [self createWorldOne];
        [self createBack];
        [self createWorldTwo];
        [self createWorldThree];
        [self createWorldFour];
        [self createWorldFive];
        [self createWorldSix];
        
        levelSize = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
        NSLog(@"Level Unlock: %li", levelUnlock);
        self.MWDelegate = self;
        
        NSLog(@"loading");
        
    }
    return self;
}

-(void)MainMenuDidShow{
    
}

-(void)WorldMenuDidShow{
    
}

-(void)LevelSceneDidShowOn{
    
}

-(void)LevelSceneDidShowOff{
    
}

-(void)addRecsToSlider:(int)angle HowMany:(int)numOf whatColor:(colorRec)color{
    
}

-(void)openSlider{
    
}

-(void)hideAllButtons{
    
}

-(void)shutSlider{
    
}

-(bool)isSliderClosed{
    return YES;
}

-(void)updateAchievements{
    
}

-(void)createBack {
  SKSpriteNode  *back = [SKSpriteNode spriteNodeWithImageNamed:@"back.png"];
    [back setScale:self.size.height/1866.667];
    [back setPosition:CGPointMake(self.size.height/11.2,self.size.height/18.667)];
    back.name = @"back";
    [self addChild:back];
    _back = back;

}

-(void) createWorldOne {
    levelSize = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
 
    
    SKLabelNode *worldName1 = [SKLabelNode labelNodeWithFontNamed:@"Copperplate"];
    worldName1.text = @"line";
    worldName1.fontColor = [SKColor whiteColor];
    worldName1.fontSize = self.size.height/40;
    worldName1.position = CGPointMake(self.size.height/28, self.size.height/1.037);
    [self addChild:worldName1];
    
        
    SKSpriteNode *level1 = [SKSpriteNode spriteNodeWithImageNamed:@"level1Blue.PNG"];
    level1.size = levelSize;
    level1.position = CGPointMake(self.size.width / 9.41, self.size.height/1.1089);
    level1.name = @"level1";
    [self addChild:level1];
    NSLog(@"Level Unlock: %li", levelUnlock);
    
    SKSpriteNode *level2;
    if (levelUnlock > 0) {
            level2 = [SKSpriteNode spriteNodeWithImageNamed:@"level2Blue.PNG"];
            level2.name = @"level2";
    NSLog(@"Level Unlocked: %li", levelUnlock);
    }
    else
    {
        level2 = [SKSpriteNode spriteNodeWithImageNamed:@"level2Lock.PNG"];
       NSLog(@"Level not Unlocked: %li", levelUnlock);
    }
    level2.position = CGPointMake(self.size.width/ 3.27, self.size.height/1.1089);
    level2.size = levelSize;
        [self addChild:level2];

    
    
    SKSpriteNode *level3;
    if (levelUnlock > 1) {
        level3 = [SKSpriteNode spriteNodeWithImageNamed:@"level3Blue.PNG"];
        level3.name = @"level3";
    }
    else
    {
        level3 = [SKSpriteNode spriteNodeWithImageNamed:@"level3Lock.PNG"];
        
    }

    level3.position = CGPointMake(self.size.width/ 1.98, self.size.height/1.1089);
    level3.size = levelSize;
    [self addChild:level3];
    
    SKSpriteNode *level4;
    if (levelUnlock > 2) {
        level4 = [SKSpriteNode spriteNodeWithImageNamed:@"level4Blue.PNG"];
        level4.name = @"level4";
    }
    else
    {
        level4 = [SKSpriteNode spriteNodeWithImageNamed:@"level4Lock.PNG"];
        
    }

    level4.position = CGPointMake(self.size.width/ 1.42, self.size.height/1.1089);
    level4.size = levelSize;
    [self addChild:level4];
    
    SKSpriteNode *level5;
    if (levelUnlock > 3) {
        level5 = [SKSpriteNode spriteNodeWithImageNamed:@"level5Blue.PNG"];
        level5.name = @"level5";
    }
    else
    {
        level5 = [SKSpriteNode spriteNodeWithImageNamed:@"level5Lock.PNG"];
        
    }

    level5.position = CGPointMake(self.size.width/ 1.1, self.size.height/1.1089);
    level5.size = levelSize;
    [self addChild:level5];

    
   
}

-(void)createWorldTwo {
    levelSize = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
    
    SKLabelNode *worldName2 = [SKLabelNode labelNodeWithFontNamed:@"Copperplate"];
    worldName2.text = @"angle";
    worldName2.fontColor = [SKColor whiteColor];
    worldName2.fontSize = self.size.height/40;
    worldName2.position = CGPointMake(self.size.height/22.4, self.size.height/1.217);
    [self addChild:worldName2];
    
    SKSpriteNode *level21;
    if (levelUnlock > 4) {
        level21 = [SKSpriteNode spriteNodeWithImageNamed:@"level211.PNG"];
        level21.name = @"level21";
        
    }
    else
    {
        level21 = [SKSpriteNode spriteNodeWithImageNamed:@"level21Lock.PNG"];
        
    }
level21.size = levelSize;
    level21.position = CGPointMake(self.size.width / 9.41, self.size.height/1.3176);
    [self addChild:level21];
    
    SKSpriteNode *level22;
    if (levelUnlock > 5) {
        level22 = [SKSpriteNode spriteNodeWithImageNamed:@"level22.PNG"];
        level22.name = @"level22";
        
    }
    else
    {
        level22 = [SKSpriteNode spriteNodeWithImageNamed:@"level22Lock.PNG"];
        
    }

    level22.position = CGPointMake(self.size.width/ 3.27, self.size.height/1.3176);
    level22.size = levelSize;
    
    [self addChild:level22];
    
    SKSpriteNode *level23;
    if (levelUnlock > 6) {
        level23 = [SKSpriteNode spriteNodeWithImageNamed:@"level23.PNG"];
        level23.name = @"level23";
        
    }
    else
    {
        level23 = [SKSpriteNode spriteNodeWithImageNamed:@"level233Lock.PNG"];
        
    }

    level23.position = CGPointMake(self.size.width/ 1.98, self.size.height/1.3176);
    level23.size = levelSize;
    [self addChild:level23];
    
    SKSpriteNode *level24;
    if (levelUnlock > 7) {
        level24 = [SKSpriteNode spriteNodeWithImageNamed:@"level24.PNG"];
        level24.name = @"level24";
        
    }
    else
    {
        level24 = [SKSpriteNode spriteNodeWithImageNamed:@"level244Lock.PNG"];
        
    }

    level24.position = CGPointMake(self.size.width/ 1.42, self.size.height/1.3176);
    level24.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
    [self addChild:level24];
    
    SKSpriteNode *level25;
    if (levelUnlock > 8) {
        level25 = [SKSpriteNode spriteNodeWithImageNamed:@"level25.PNG"];
        level25.name = @"level25";
        
    }
    else
    {
        level25 = [SKSpriteNode spriteNodeWithImageNamed:@"level255Lock.PNG"];
        
    }

    level25.position = CGPointMake(self.size.width/ 1.1, self.size.height/1.3176);
    level25.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
    [self addChild:level25];
}

-(void) createWorldThree {
    SKLabelNode *worldName3 = [SKLabelNode labelNodeWithFontNamed:@"Copperplate"];
    worldName3.text = @"triangle";
    worldName3.fontColor = [SKColor whiteColor];
    worldName3.fontSize = self.size.height/40;
    worldName3.position = CGPointMake(self.size.height/16, self.size.height/1.474);
    [self addChild:worldName3];
    
    SKSpriteNode *level31;
    if (levelUnlock > 9) {
        level31 = [SKSpriteNode spriteNodeWithImageNamed:@"level31.PNG"];
        level31.name = @"level31";
        
    }
    else
    {
        level31 = [SKSpriteNode spriteNodeWithImageNamed:@"level31Lock.PNG"];
        
    }

    level31.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
    level31.position = CGPointMake(self.size.width / 9.41, self.size.height/1.623);
    [self addChild:level31];
    
    SKSpriteNode *level32;
    if (levelUnlock > 10) {
        level32 = [SKSpriteNode spriteNodeWithImageNamed:@"level32.PNG"];
        level32.name = @"level32";
        
    }
    else
    {
        level32 = [SKSpriteNode spriteNodeWithImageNamed:@"level32Lock.PNG"];
        
    }

    level32.position = CGPointMake(self.size.width/ 3.27, self.size.height/1.623);
    level32.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
        [self addChild:level32];
    
    SKSpriteNode *level33;
    if (levelUnlock > 11) {
        level33 = [SKSpriteNode spriteNodeWithImageNamed:@"level33.PNG"];
        level33.name = @"level33";
        
    }
    else
    {
        level33 = [SKSpriteNode spriteNodeWithImageNamed:@"level33Lock.PNG"];
        
    }

    level33.position = CGPointMake(self.size.width/ 1.98, self.size.height/1.623);
    level33.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
    [self addChild:level33];
    
    SKSpriteNode *level34;
    if (levelUnlock > 12) {
        level34 = [SKSpriteNode spriteNodeWithImageNamed:@"level34.PNG"];
        level34.name = @"level34";
        
    }
    else
    {
        level34 = [SKSpriteNode spriteNodeWithImageNamed:@"level34Lock.PNG"];
        
    }

    level34.position = CGPointMake(self.size.width/ 1.42, self.size.height/1.623);
    level34.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
    [self addChild:level34];
    
    SKSpriteNode *level35;
    if (levelUnlock > 13) {
        level35 = [SKSpriteNode spriteNodeWithImageNamed:@"level35.PNG"];
        level35.name = @"level35";
        
    }
    else
    {
        level35 = [SKSpriteNode spriteNodeWithImageNamed:@"level35Lock.PNG"];
        
    }

    level35.position = CGPointMake(self.size.width/ 1.1, self.size.height/1.623);
    level35.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
    [self addChild:level35];
}

-(void)createWorldFour {
    SKLabelNode *worldName4 = [SKLabelNode labelNodeWithFontNamed:@"Copperplate"];
    worldName4.text = @"square";
    worldName4.fontColor = [SKColor whiteColor];
    worldName4.fontSize = self.size.height/40;
    worldName4.position = CGPointMake(self.size.height/18.667, self.size.height/1.8667);
    [self addChild:worldName4];
    
    SKSpriteNode *level41;
    if (levelUnlock > 14) {
        level41 = [SKSpriteNode spriteNodeWithImageNamed:@"level41.PNG"];
        level41.name = @"level41";
        
    }
    else
    {
        level41 = [SKSpriteNode spriteNodeWithImageNamed:@"level411Lock.PNG"];
        
    }

    level41.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
    level41.position = CGPointMake(self.size.width / 9.41, self.size.height/2.113);
    
    [self addChild:level41];
    
    SKSpriteNode *level42;
    if (levelUnlock > 15) {
        level42 = [SKSpriteNode spriteNodeWithImageNamed:@"level42.PNG"];
        level42.name = @"level42";
        
    }
    else
    {
        level42 = [SKSpriteNode spriteNodeWithImageNamed:@"level42Lock.PNG"];
        
    }
    level42.position = CGPointMake(self.size.width/ 3.27, self.size.height/2.113);
    level42.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
   
    [self addChild:level42];
    
    SKSpriteNode *level43;
    if (levelUnlock > 16) {
        level43 = [SKSpriteNode spriteNodeWithImageNamed:@"level43.PNG"];
        level43.name = @"level43";
        
    }
    else
    {
        level43 = [SKSpriteNode spriteNodeWithImageNamed:@"level43Lock.PNG"];
        
    }
    level43.position = CGPointMake(self.size.width/ 1.98, self.size.height/2.113);
    level43.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
   
    [self addChild:level43];
    
    SKSpriteNode *level44;
    if (levelUnlock > 17) {
        level44 = [SKSpriteNode spriteNodeWithImageNamed:@"level44.PNG"];
        level44.name = @"level44";
        
    }
    else
    {
        level44 = [SKSpriteNode spriteNodeWithImageNamed:@"level44Lock.PNG"];
        
    }
    level44.position = CGPointMake(self.size.width/ 1.42, self.size.height/2.113);
    level44.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
   
    [self addChild:level44];
    
    SKSpriteNode *level45;
    if (levelUnlock > 18) {
        level45 = [SKSpriteNode spriteNodeWithImageNamed:@"level45.PNG"];
        level45.name = @"level45";
        
    }
    else
    {
        level45 = [SKSpriteNode spriteNodeWithImageNamed:@"level45Lock.PNG"];
        
    }
    level45.position = CGPointMake(self.size.width/ 1.1, self.size.height/2.113);
    level45.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
    
    [self addChild:level45];
}

-(void) createWorldFive {
    SKLabelNode *worldName5 = [SKLabelNode labelNodeWithFontNamed:@"Copperplate"];
    worldName5.text = @"pentagon";
    worldName5.fontColor = [SKColor whiteColor];
    worldName5.fontSize = self.size.height/40;
    worldName5.position = CGPointMake(self.size.height/14, self.size.height/2.545);
    [self addChild:worldName5];
    
    SKSpriteNode *level51;
    if (levelUnlock > 19) {
        level51 = [SKSpriteNode spriteNodeWithImageNamed:@"level51.PNG"];
        level51.name = @"level51";
        
    }
    else
    {
        level51 = [SKSpriteNode spriteNodeWithImageNamed:@"level511Lock.PNG"];
        
    }
    level51.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
    level51.position = CGPointMake(self.size.width / 9.41, self.size.height/3.027);
    
    [self addChild:level51];
    
    SKSpriteNode *level52;
    if (levelUnlock > 20) {
        level52 = [SKSpriteNode spriteNodeWithImageNamed:@"level52.PNG"];
        level52.name = @"level52";
        
    }
    else
    {
        level52 = [SKSpriteNode spriteNodeWithImageNamed:@"level52Lock.PNG"];
        
    }
    level52.position = CGPointMake(self.size.width/ 3.27, self.size.height/3.027);
    level52.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);

    [self addChild:level52];
    
    SKSpriteNode *level53;
    if (levelUnlock > 21) {
        level53 = [SKSpriteNode spriteNodeWithImageNamed:@"level53.PNG"];
        level53.name = @"level53";
        
    }
    else
    {
        level53 = [SKSpriteNode spriteNodeWithImageNamed:@"level53Lock.PNG"];
        
    }
    level53.position = CGPointMake(self.size.width/ 1.98, self.size.height/3.027);
    level53.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);

    [self addChild:level53];
    
    SKSpriteNode *level54;
    if (levelUnlock > 22) {
        level54 = [SKSpriteNode spriteNodeWithImageNamed:@"level54.PNG"];
        level54.name = @"level54";
        
    }
    else
    {
        level54 = [SKSpriteNode spriteNodeWithImageNamed:@"level54Lock.PNG"];
        
    }
    level54.position = CGPointMake (self.size.width/ 1.42, self.size.height/3.027);
    level54.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);

    [self addChild:level54];
    
    SKSpriteNode *level55;
    if (levelUnlock > 23) {
        level55 = [SKSpriteNode spriteNodeWithImageNamed:@"level55.PNG"];
        level55.name = @"level55";
        
    }
    else
    {
        level55 = [SKSpriteNode spriteNodeWithImageNamed:@"level55Lock.PNG"];
        
    }
    level55.position = CGPointMake(self.size.width/ 1.1, self.size.height/3.027);
    level55.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);

    [self addChild:level55];

}

-(void) createWorldSix
{
    SKLabelNode *worldName6 = [SKLabelNode labelNodeWithFontNamed:@"Copperplate"];
    worldName6.text = @"hexagon";
    worldName6.fontColor = [SKColor whiteColor];
    worldName6.fontSize = self.size.height/40;
    worldName6.position = CGPointMake(self.size.height/15.135, self.size.height/4);
    [self addChild:worldName6];
    
    SKSpriteNode *level61;
    if (levelUnlock > 24) {
        level61 = [SKSpriteNode spriteNodeWithImageNamed:@"level611.PNG"];
        level61.name = @"level61";
        
    }
    else
    {
        level61 = [SKSpriteNode spriteNodeWithImageNamed:@"level611.Lock.PNG"];
        
    }
    level61.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
    level61.position = CGPointMake(self.size.width / 9.41, self.size.height/5.333);
      [self addChild:level61];
    
    SKSpriteNode *level62;
    if (levelUnlock > 25) {
        level62 = [SKSpriteNode spriteNodeWithImageNamed:@"level62.PNG"];
        level62.name = @"level62";
        
    }
    else
    {
        level62 = [SKSpriteNode spriteNodeWithImageNamed:@"level62Lock.PNG"];
        
    }
    level62.position = CGPointMake(self.size.width/ 3.27, self.size.height/5.333);
    level62.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
  
    [self addChild:level62];
    
    SKSpriteNode *level63;
    if (levelUnlock > 26) {
        level63 = [SKSpriteNode spriteNodeWithImageNamed:@"level63.PNG"];
        level63.name = @"level63";
        
    }
    else
    {
        level63 = [SKSpriteNode spriteNodeWithImageNamed:@"level63Lock.PNG"];
        
    }
    level63.position = CGPointMake(self.size.width/ 1.98, self.size.height/5.333);
    level63.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
   
    [self addChild:level63];
    
    SKSpriteNode *level64;
    if (levelUnlock > 27) {
        level64 = [SKSpriteNode spriteNodeWithImageNamed:@"level64.PNG"];
        level64.name = @"level64";
        
    }
    else
    {
        level64 = [SKSpriteNode spriteNodeWithImageNamed:@"level64Lock.PNG"];
        
    }
    level64.position = CGPointMake(self.size.width/ 1.42, self.size.height/5.333);
    level64.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
   
    [self addChild:level64];
    
    SKSpriteNode *level65;
    if (levelUnlock > 28) {
        level65 = [SKSpriteNode spriteNodeWithImageNamed:@"level65.PNG"];
        level65.name = @"level65";
        
    }
    else
    {
        level65 = [SKSpriteNode spriteNodeWithImageNamed:@"level65Lock.PNG"];
        
    }
    level65.position = CGPointMake(self.size.width/ 1.1, self.size.height/5.333);
    level65.size = CGSizeMake(self.size.height/11.2, self.size.height/11.2);
 
    [self addChild:level65];

}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKSpriteNode *temp =(SKSpriteNode *) [self nodeAtPoint:location];
    SKTransition *reveal = [SKTransition doorwayWithDuration:1];
    MyScene * scene = [MyScene sceneWithSize:self.view.bounds.size];
    
    scene.MLDelegate = self.MWDelegate;
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    if([temp.name isEqualToString:@"level1"])
    {
       
     [(MyScene *)scene callLevel:11];
        
        [self.view presentScene:scene transition:reveal];
     }
    if([temp.name isEqualToString:@"level2"])
    {
        
        [(MyScene *)scene callLevel:12];
        
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level3"])
    {
      
        [(MyScene *)scene callLevel:13];
        
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level4"])
    {
    
        [(MyScene *)scene callLevel:14];
      
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level5"])
    {
   
        [(MyScene *)scene callLevel:15];
               [self.view presentScene:scene transition:reveal];
    }
    
    if([temp.name isEqualToString:@"level21"])
    {
        
        [(MyScene *)scene callLevel:21];
        
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level22"])
    {
        
        [(MyScene *)scene callLevel:22];
     
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level23"])
    {
        
        [(MyScene *)scene callLevel:23];
      
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level24"])
    {
        
        [(MyScene *)scene callLevel:24];
     
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level25"])
    {
        
        [(MyScene *)scene callLevel:25];
      
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level31"])
    {
        
        [(MyScene *)scene callLevel:31];
      
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level32"])
    {
        
        [(MyScene *)scene callLevel:32];
   
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level33"])
    {
        
        [(MyScene *)scene callLevel:33];
    
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level34"])
    {
        
        [(MyScene *)scene callLevel:34];
   
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level35"])
    {
        
        [(MyScene *)scene callLevel:35];
    
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level41"])
    {
        
        [(MyScene *)scene callLevel:41];
     
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level42"])
    {
        
        [(MyScene *)scene callLevel:42];
 
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level43"])
    {
        
        [(MyScene *)scene callLevel:43];
    
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level44"])
    {
        
        [(MyScene *)scene callLevel:44];
      
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level45"])
    {
        
        [(MyScene *)scene callLevel:45];
   
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level51"])
    {
        
        [(MyScene *)scene callLevel:51];
    
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level52"])
    {
        
        [(MyScene *)scene callLevel:52];
     
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level53"])
    {
        
        [(MyScene *)scene callLevel:53];
     
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level54"])
    {
        
        [(MyScene *)scene callLevel:54];

        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level55"])
    {
        
        [(MyScene *)scene callLevel:55];
  
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level61"])
    {
        
        [(MyScene *)scene callLevel:61];
   
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level62"])
    {
        
        [(MyScene *)scene callLevel:62];
  
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level63"])
    {
        
        [(MyScene *)scene callLevel:63];
 
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level64"])
    {
        
        [(MyScene *)scene callLevel:64];
   
        [self.view presentScene:scene transition:reveal];
    }
    if([temp.name isEqualToString:@"level65"])
    {
        
        [(MyScene *)scene callLevel:65];
 
        [self.view presentScene:scene transition:reveal];
    }
    
    if ([temp.name isEqualToString:@"back"]) {
       
        MainMenu *newScene = [MainMenu sceneWithSize:self.view.bounds.size];
        newScene.MMDelegate = self.MWDelegate;
        SKTransition *reveal = [SKTransition pushWithDirection:SKTransitionDirectionRight duration:0.5];
        [self.MWDelegate MainMenuDidShow];
        [self.view presentScene: newScene transition: reveal];
       
   
         
    }
}


@end

