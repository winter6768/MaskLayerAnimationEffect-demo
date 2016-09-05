//
//  ViewController.m
//  MaskLayerAnimationEffect-demo
//
//  Created by 也瘦 on 16/8/23.
//  Copyright © 2016年 也瘦. All rights reserved.
//

#import "ViewController.h"
#import "UnlockAnimation.h"

@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)CALayer *maskLayer;
@property(nonatomic,strong)UIScrollView *sc;
@property(nonatomic,assign)CGFloat KWidth;
@property(nonatomic,assign)CGFloat KHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
    
    
    _KWidth = self.view.frame.size.width;
    _KHeight = self.view.frame.size.height;

    [self setupMaskLayerUI];

    [self setupUnlockAnimationUI];
}

#pragma mark - masklayer 动画效果
-(void)setupMaskLayerUI
{
    _sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64 + 44, _KWidth, 200)];
    _sc.contentSize = CGSizeMake(_sc.frame.size.width * 2, _sc.frame.size.height);
    _sc.pagingEnabled = YES;
    _sc.backgroundColor = [UIColor whiteColor];
    _sc.delegate = self;
    [self.view addSubview:_sc];
    
    NSArray *arr_title = @[@"哈哈",@"呵呵"];
    
    
    //    背景
    UIView *view_bg = [[UIView alloc]initWithFrame:CGRectMake(0, 64, _KWidth, 44)];
    view_bg.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view_bg];
    
    for (int i = 0; i < arr_title.count; i ++)
    {
        UIButton *button = [UIButton new];
        button.frame = CGRectMake(_KWidth / 2.0 * i, 0, _KWidth / 2.0, 44);
        [button setTitle:arr_title[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:1 alpha:.5] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [view_bg addSubview:button];
    }
    
    UIImageView *line_bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, view_bg.frame.size.height - .5, view_bg.frame.size.width, .5)];
    line_bg.backgroundColor = [UIColor grayColor];
    [view_bg addSubview:line_bg];
    
    //    显示
    UIView *view_top = [[UIView alloc]initWithFrame:view_bg.frame];
    view_top.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view_top];
    
    for (int i = 0; i < arr_title.count; i ++)
    {
        UIButton *button = [UIButton new];
        button.frame = CGRectMake(_KWidth / 2.0 * i, 0, _KWidth / 2.0, 44);
        [button setTitle:arr_title[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [view_top addSubview:button];
    }
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, view_top.frame.size.height - 2, view_top.frame.size.width, 2)];
    line.backgroundColor = [UIColor blueColor];
    [view_top addSubview:line];
    
    //    遮罩层
    _maskLayer = [CALayer layer];
    
//    _maskLayer.frame = view_top.bounds;
    _maskLayer.frame = CGRectMake(0, 0, _KWidth / 2.0, 44);
    
    //    只显示非透明区域  所以必须设颜色
    _maskLayer.backgroundColor = [UIColor whiteColor].CGColor;
    view_top.layer.mask = _maskLayer;
//    view_top.layer.masksToBounds = YES;
}

-(void)buttonTap:(UIButton *)button
{
 
//    动画延迟效果 未解决
    [_sc setContentOffset:CGPointMake(_sc.frame.size.width * button.tag, 0) animated:YES];

//    _maskLayer.frame = CGRectMake(_KWidth / 2.0 * button.tag, 0, _KWidth / 2.0, 44);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _maskLayer.frame = CGRectMake(scrollView.contentOffset.x / 2.0, 0, _KWidth / 2.0, 44);
}

#pragma mark - 手机解锁动画
-(void)setupUnlockAnimationUI
{
    UILabel *label = [UILabel new];
    label.text = @"> 滑动来解锁> 滑动来解锁> 滑动来解锁> 滑动来解锁";
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    label.frame = CGRectMake(0, _sc.frame.size.height + _sc.frame.origin.y + 50, _KWidth, 25);
    
    UnlockAnimation *animation = [UnlockAnimation new];
    animation.animationView = label;
//    animation.duration = 30;
//    animation.repeatCount = 2000;
//    animation.foregroundWidth = 100;
//    animation.foregroundColor = [UIColor whiteColor];
//    animation.backgroundColor = [UIColor clearColor];
    [animation startAnimation];
    
}








@end
