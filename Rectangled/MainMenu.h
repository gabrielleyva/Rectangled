//
//  MainMenu.h
//  Ball Drop Test
//
//  Created by Evan Noble on 5/18/14.
//  Copyright (c) 2014 Lykos Technologies LLC. All rights reserved.
//
typedef enum: int{
    regRec,
    smallRec,
}typeRect;

typedef enum: int
{
    blue,
    red,
    purple,
    orange,
    yellow,
    green,
}colorRec;
@protocol MainMenuDelegate <NSObject>

-(void)MainMenuDidShow;
-(void)WorldMenuDidShow;
-(void)addRecsToSlider:(int) angle HowMany:(int) numOf whatColor: (colorRec) color;
-(void)LevelSceneDidShowOn;
-(void)LevelSceneDidShowOff;
-(bool)isSliderClosed;
-(void)shutSlider;
-(void)openSlider;
-(void)hideAllButtons;
-(void)updateAchievements;
@end

#import <SpriteKit/SpriteKit.h>
#import "WorldScreen.h"
#import "ViewController.h"


@interface MainMenu : SKScene{
    
}

@property (nonatomic,strong) id <MainMenuDelegate> MMDelegate;

@end

@interface SKEmitterNode (fromFile)
+ (instancetype)bomb_emitterNamed:(NSString*)name;
@end
