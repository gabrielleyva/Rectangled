//
//  ViewController.h
//  Ball Drop Test
//

//  Copyright (c) 2014 Lykos Technologies LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>
#import "MainMenu.h"

@interface ViewController : UIViewController<GKGameCenterControllerDelegate,MainMenuDelegate>{
    UIView *menuDrawer;
}

@property(readonly,nonatomic) UISwipeGestureRecognizer *open, *close, *remove;
@property(readonly,nonatomic) int menuDrawerX, menuDrawerWidth;


-(void) handleSwipes: (UISwipeGestureRecognizer *) sender;

-(void) drawerAnimation;


@end
