//
//  WorldScreen.h
//  Ball Drop Test
//
//  Created by Evan Noble on 5/21/14.
//  Copyright (c) 2014 Lykos Technologies LLC. All rights reserved.
//


#import <SpriteKit/SpriteKit.h>
#import "MainMenu.h"
#import "ViewController.h"


@interface WorldScreen : SKScene <MainMenuDelegate>  {
    

}


@property (nonatomic,strong) id <MainMenuDelegate> MWDelegate;
@end
