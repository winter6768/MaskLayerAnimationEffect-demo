//
//  UnlockAnimation.m
//  MaskLayerAnimationEffect-demo
//
//  Created by winter on 16/8/31.
//  Copyright © 2016年 也瘦. All rights reserved.
//

#import "UnlockAnimation.h"

@interface UnlockAnimation ()
{
    CABasicAnimation *locationsAnimation;
}

@end

@implementation UnlockAnimation

-(void)startAnimation
{
    if (!self.animationView)
    {
        return;
    }
    
    self.foregroundWidth = self.foregroundWidth ?: self.animationView.frame.size.width / 4.0;
    self.foregroundColor = self.foregroundColor ?: [UIColor whiteColor];
    self.backgroundColor = self.backgroundColor ?: [UIColor colorWithWhite:0 alpha:.3];
    self.repeatCount     = self.repeatCount ?: HUGE_VALF;
    self.duration        = self.duration ?: 3;
    
    CAGradientLayer *mask = [CAGradientLayer layer];
    
    mask.frame = self.animationView.bounds;
    
    CGFloat widthScale = self.foregroundWidth / self.animationView.frame.size.width;
    
    NSArray *startLocations = @[@0,
                                [NSNumber numberWithFloat:widthScale / 2.0],
                                [NSNumber numberWithFloat:widthScale]
                                ];
    
    NSArray *endLocations = @[[NSNumber numberWithFloat:(1 - widthScale)],
                              [NSNumber numberWithFloat:(1 - widthScale / 2.0)],
                              @1
                              ];
    
    mask.colors = @[(id)self.backgroundColor.CGColor,
                    (id)self.foregroundColor.CGColor,
                    (id)self.backgroundColor.CGColor
                    ];
    
    mask.locations = startLocations;
    mask.startPoint = CGPointMake( -widthScale * 2, 0.5);
    mask.endPoint = CGPointMake(1 + widthScale * 2, .5);
    
    
    self.animationView.layer.mask = mask;
    
    locationsAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
    locationsAnimation.fromValue = startLocations;
    locationsAnimation.toValue = endLocations;
    locationsAnimation.repeatCount = self.repeatCount;
    locationsAnimation.duration  = self.duration;
    locationsAnimation.delegate = self;
    
    [mask addAnimation:locationsAnimation forKey:@"unlockAnimation"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == locationsAnimation)
    {
        [self stopAnimation];
    }
}

-(void)stopAnimation
{
    if (self.animationView && self.animationView.layer.mask)
    {
        [self.animationView.layer.mask removeAnimationForKey:@"unlockAnimation"];
        self.animationView.layer.mask = nil;
        locationsAnimation = nil;
    }
}



@end
