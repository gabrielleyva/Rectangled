//
//  NLMButton.m
//  TookyBird
//
//  Created by Gabriel I Leyva Merino on 6/6/14.
//  Copyright (c) 2014 Noble & Leyva Merino. All rights reserved.
//

#import "NLMButton.h"

#define ANIMATION_DURATION .5

@implementation NLMButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
         }
    return self;
}

- (void)hide:(BOOL)animated {
   
    
    NSLog(@"hidden");
    [UIView animateWithDuration:animated ? ANIMATION_DURATION : 0 animations:^{
        self.alpha = 0.f;
       
       CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI / 6);
       transform = CGAffineTransformScale(transform, .1f, .1f);
      self.transform = transform;
        
    }];
}

- (void)show:(BOOL)animated {
    
    NSLog(@"shown");
    [UIView animateWithDuration:animated ? ANIMATION_DURATION : 0  animations:^{
        self.alpha = 1.f;
        
        self.transform = CGAffineTransformIdentity;
        
        
    }];
}



@end
