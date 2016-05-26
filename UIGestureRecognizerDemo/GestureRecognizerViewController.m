//
//  GestureRecognizerViewController.m
//  UIGestureRecognizerDemo
//
//  Created by Zilu.Ma on 16/5/26.
//  Copyright © 2016年 zilu.ma. All rights reserved.
//

#import "GestureRecognizerViewController.h"

@interface GestureRecognizerViewController ()<UIGestureRecognizerDelegate>

{
    UIView *_view;
    UIButton *_btn;
    UITapGestureRecognizer *_tapGestureRecoginzer;
}

@end

@implementation GestureRecognizerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _view = [[UIView alloc] initWithFrame:CGRectMake(50, 64+50, 250, 250)];
    _view.backgroundColor = [UIColor redColor];
    [self.view addSubview:_view];
    
    switch (_type) {
        case 1:
        {
            //离散的(一旦识别将无法取消,并且只会调用一次)
            _tapGestureRecoginzer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecoginzer:)];
            //同时点击的手指数
//            _tapGestureRecoginzer.numberOfTouchesRequired = 2;
            //点击的次数
            _tapGestureRecoginzer.numberOfTapsRequired = 1;
//            _tapGestureRecoginzer.delegate = self;
            [_view addGestureRecognizer:_tapGestureRecoginzer];
            
            _btn = [UIButton buttonWithType:UIButtonTypeCustom];
            _btn.frame = CGRectMake(0, 0, 150, 100);
            _btn.backgroundColor = [UIColor orangeColor];
            [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
            [_view addSubview:_btn];
        }
            break;
        case 2:
        {
            //连续的
            //捏合
            UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureRecognizer:)];
            [_view addGestureRecognizer:pinchGestureRecognizer];
        }
            break;
        case 3:
        {
            //连续的
            UIRotationGestureRecognizer *rotationGestureRscognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGestureRscognizer:)];
            [_view addGestureRecognizer:rotationGestureRscognizer];
        }
            break;
        case 4:
        {
            //离散的
            UISwipeGestureRecognizer *swipeGestureRecognizer= [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognizer:)];
            //设置轻扫的方向,默认右
            swipeGestureRecognizer.direction = 1;
            swipeGestureRecognizer.numberOfTouchesRequired = 2;
            [_view addGestureRecognizer:swipeGestureRecognizer];
        }
            break;
        case 5:
        {
            //连续
            //平推
            UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
            panGestureRecognizer.minimumNumberOfTouches = 2;
            panGestureRecognizer.maximumNumberOfTouches = 3;
            [_view addGestureRecognizer:panGestureRecognizer];
        }
            break;
        case 6:
        {
            //连续
            UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognizer:)];
            longPressGestureRecognizer.numberOfTouchesRequired = 2;
            //当点击按下去前的点击数
            longPressGestureRecognizer.numberOfTapsRequired = 2;
            longPressGestureRecognizer.minimumPressDuration = 1.0;
            [_view addGestureRecognizer:longPressGestureRecognizer];
        }
            break;
        case 7:{
            [self singleTabAndDounleTapAndPan];
        }
            break;
            
        default:
            break;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    
//    if ([otherGestureRecognizer.view isKindOfClass:[UIButton class]]) {
//        return NO;
//    }else{
//        return YES;
//    }
//}

- (void)singleTabAndDounleTapAndPan{
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap)];
    singleTap.numberOfTapsRequired = 1;
    [_view addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap)];
    doubleTap.numberOfTapsRequired = 2;
    [_view addGestureRecognizer:doubleTap];
    
    //直到doubleTap失效singleTap才成功
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan)];
    [_view addGestureRecognizer:pan];
}

- (void)singleTap{
    
    NSLog(@"单击");
}

- (void)doubleTap{
    
    NSLog(@"双击");
}

- (void)pan{
    
    NSLog(@"平推");
}

- (void)btnClick{
    
//    BOOL tap = [_btn gestureRecognizerShouldBegin:_tapGestureRecoginzer];
//    if (tap) {
//        NSLog(@"响应了按钮");
//    }
    
    NSLog(@"响应了按钮");
}

- (void)tapGestureRecoginzer:(UITapGestureRecognizer *)tapGestureRecoginzer{
    
//    int count1 = (int)tapGestureRecoginzer.numberOfTouches;
//    int count2 = (int)tapGestureRecoginzer.numberOfTapsRequired;
//    int count3 = (int)tapGestureRecoginzer.numberOfTouchesRequired;
//    NSLog(@"%d==%d==%d",count1,count2,count3);
    
    BOOL tap = [_btn gestureRecognizerShouldBegin:tapGestureRecoginzer];
    NSLog(@"%d",tap);
    NSLog(@"响应了单击手势");
}

- (void)pinchGestureRecognizer:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    
    NSLog(@"%f",pinchGestureRecognizer.scale);
    NSLog(@"%f",pinchGestureRecognizer.velocity);//速度
    NSLog(@"%@",pinchGestureRecognizer);
}

- (void)rotationGestureRscognizer:(UIRotationGestureRecognizer *)rotationGestureRscognizer{
    
    NSLog(@"%f",rotationGestureRscognizer.rotation);
    NSLog(@"%f",rotationGestureRscognizer.velocity);
}

- (void)swipeGestureRecognizer:(UISwipeGestureRecognizer *)swipeGestureRecognizer{
    
    NSLog(@"%@",swipeGestureRecognizer);
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer{
    
//    NSLog(@"%@",panGestureRecognizer);
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint delta = [panGestureRecognizer translationInView:_view];//从触摸的初始位置估计
        NSLog(@"%@",NSStringFromCGPoint(delta));
    }
    
    [panGestureRecognizer setTranslation:CGPointZero inView:_view];//重置delta
}

- (void)longPressGestureRecognizer:(UILongPressGestureRecognizer *)longPressGestureRecognizer{
    
    NSLog(@"%@",longPressGestureRecognizer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
