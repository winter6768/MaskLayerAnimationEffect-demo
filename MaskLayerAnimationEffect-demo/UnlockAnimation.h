//
//  UnlockAnimation.h
//  MaskLayerAnimationEffect-demo
//
//  Created by winter on 16/8/31.
//  Copyright © 2016年 也瘦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UnlockAnimation : NSObject

/** 执行动画的view */
@property(weak,nonatomic)UIView *animationView;

/** 动画重复次数  默认 无限次 */
@property(assign,nonatomic)CGFloat repeatCount;

/** 亮色区域宽度  默认 animationView宽度的  1/4 */
@property(assign,nonatomic)CGFloat foregroundWidth;

/** 动画时间  默认 3s */
@property(assign,nonatomic)NSTimeInterval duration;

/** 动画背景颜色 默认 [UIColor colorWithWhite:0 alpha:.3]  当为透明色时 背景区域不显示 */
@property(strong,nonatomic)UIColor *backgroundColor;

/** 前景颜色  默认 白色 */
@property(strong,nonatomic)UIColor *foregroundColor;


-(void)startAnimation;
-(void)stopAnimation;

@end
