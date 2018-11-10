//
//  MyScene.h
//  Ball Drop Test
//

//  Copyright (c) 2014 Lykos Technologies LLC. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MainMenu.h"

@interface MyScene : SKScene 
-(void)callLevel:(int)numLevel;
-(void) createRec: (typeRect ) type withAngle:(int) degrees withColor:(colorRec)  color withPosition:(CGPoint) position withNumber:(NSString*)Number;
@property (nonatomic,strong) id <MainMenuDelegate> MLDelegate;
@property NSString *nodeTouch;
@property SKSpriteNode *lastNode;
@property SKNode *yellowRec;
@end
