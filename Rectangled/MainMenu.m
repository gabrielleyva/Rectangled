//
//  MainMenu.m
//  Ball Drop Test
//
//  Created by Evan Noble on 5/18/14.
//  Copyright (c) 2014 Lykos Technologies LLC. All rights reserved.
//

#import "MainMenu.h"
#import "MyScene.h"
#import "WorldScreen.h"
#import "ViewController.h"

@implementation MainMenu{
    SKSpriteNode *_title;
  
    SKNode *backGround;
}


-(id) initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {

        
        SKSpriteNode *title = [SKSpriteNode spriteNodeWithImageNamed:@"title1.PNG"];
        [title setScale:self.size.height/1244.44];
                title.position = CGPointMake(self.size.width/2, self.size.height/1.47);
        title.name = @"title";
        [self addChild:title];
        _title = title;
        
        
        SKTexture *title1 = [SKTexture textureWithImageNamed:@"title1.PNG"];
        SKTexture *title2 = [SKTexture textureWithImageNamed:@"title2.PNG"];
        SKTexture *title3 = [SKTexture textureWithImageNamed:@"title3.PNG"];
        SKTexture *title4 = [SKTexture textureWithImageNamed:@"title4.PNG"];
        SKTexture *title5 = [SKTexture textureWithImageNamed:@"title5.PNG"];
        

        SKAction *titleAction = [SKAction animateWithTextures:@[title1,title2,title3,title4,title5] timePerFrame:.15];
        [title runAction:[SKAction repeatActionForever:titleAction]];
        
        self.backgroundColor = [SKColor blackColor];
        [self addChild:[self buildBackGround]];
        [self spawnBackgroundEffect];
    
        CGFloat myf = self.size.height;
        NSLog(@"%f", myf);
    }
    return self;
}
-(void)MainMenuDidShow{
    
}

-(void)WorldMenuDidShow{
    
}

-(SKNode *) buildBackGround {
    backGround = [SKNode node];
    
    return backGround;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{


    
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

//implementation to create particle effects
@implementation SKEmitterNode (fromFile)
+ (instancetype)bomb_emitterNamed:(NSString*)name{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:name ofType:@"sks"]];
}
@end;
