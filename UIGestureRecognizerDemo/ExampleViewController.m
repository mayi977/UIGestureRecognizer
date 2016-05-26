//
//  ExampleViewController.m
//  UIGestureRecognizerDemo
//
//  Created by Zilu.Ma on 16/5/26.
//  Copyright © 2016年 zilu.ma. All rights reserved.
//

#import "ExampleViewController.h"

@interface ExampleViewController ()<UIActionSheetDelegate,UIGestureRecognizerDelegate>

{
    UIImageView *_imageView;
    NSMutableArray *_imageArr;
    int _currentIndex;
    NSArray *_arr;
}

@end

@implementation ExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _arr = @[@"111.jpg",@"222.jpg",@"333.png",@"444.jpg",@"666.jpg"];
    _imageArr = [NSMutableArray arrayWithArray:_arr];
    _currentIndex = 0;
    self.navigationItem.title = _imageArr[_currentIndex];
    [self initInterface];
    [self addGestureRecognizer];
}

- (void)initInterface{
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 84, 320, 567-84)];
    _imageView.image = [UIImage imageNamed:_imageArr[_currentIndex]];
    _imageView.contentMode = UIViewContentModeScaleToFill;//缩放填充
    _imageView.userInteractionEnabled = YES;//决定了是否用户触发的事件被该视图对象忽略和把该视图对象从事件响应队列中移除。
    [self.view addSubview:_imageView];
    
}

- (void)addGestureRecognizer{
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.delegate = self;
    [self.view addGestureRecognizer:singleTap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPress.minimumPressDuration = 0.5;
    [_imageView addGestureRecognizer:longPress];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [_imageView addGestureRecognizer:pinch];
    
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    [_imageView addGestureRecognizer:rotation];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [_imageView addGestureRecognizer:pan];
    
    UISwipeGestureRecognizer *swipeToLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToLeft:)];
    swipeToLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [_imageView addGestureRecognizer:swipeToLeft];
    
    UISwipeGestureRecognizer *swipeToRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToRight:)];
    swipeToRight.direction = UISwipeGestureRecognizerDirectionRight;
    [_imageView addGestureRecognizer:swipeToRight];
    
    [pan requireGestureRecognizerToFail:swipeToRight];
    [pan requireGestureRecognizerToFail:swipeToLeft];
    [longPress requireGestureRecognizerToFail:pan];
}

- (void)singleTap:(UITapGestureRecognizer *)singleTap{
    
    BOOL hide = !self.navigationController.navigationBarHidden;
    [self.navigationController setNavigationBarHidden:hide animated:YES];
    if (hide) {
        self.navigationItem.title = _imageArr[_currentIndex];
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"温馨提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil, nil];
        [actionSheet showInView:self.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
//    NSLog(@"%d",buttonIndex);
    if (buttonIndex == 0) {
        [_imageArr removeObjectAtIndex:_currentIndex];
        if (_imageArr.count == 0) {
            [_imageArr addObjectsFromArray:_arr];
            _currentIndex = 1;
        }
        int index = (_currentIndex + _imageArr.count - 1)%_imageArr.count;
        [self changeImageIndex:index];
    }
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch{
    
    if (pinch.state == UIGestureRecognizerStateChanged) {
        _imageView.transform = CGAffineTransformMakeScale(pinch.scale, pinch.scale);
    }else if (pinch.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.5 animations:^{
            _imageView.transform = CGAffineTransformIdentity;//取消一切形变
        }];
    }
}

- (void)rotation:(UIRotationGestureRecognizer *)rotation{
    
    if (rotation.state == UIGestureRecognizerStateChanged) {
        //属性rotation:旋转的弧度
        _imageView.transform = CGAffineTransformMakeRotation(rotation.rotation);
    }else if (rotation.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.5 animations:^{
            _imageView.transform = CGAffineTransformIdentity;//取消一切形变
        }];
    }
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [pan translationInView:self.view];
        _imageView.transform = CGAffineTransformMakeTranslation(translation.x, translation.y);
    }else if (pan.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.5 animations:^{
            _imageView.transform = CGAffineTransformIdentity;//取消一切形变
        }];
    }
}

- (void)swipeToLeft:(UISwipeGestureRecognizer *)swipeToLeft{
    
    if (swipeToLeft.state == UIGestureRecognizerStateEnded) {
        int index = (_currentIndex + _imageArr.count + 1)%_imageArr.count;
        [self changeImageIndex:index];
    }
}

- (void)swipeToRight:(UISwipeGestureRecognizer *)swipeToRight{
    
    if (swipeToRight.state == UIGestureRecognizerStateEnded) {
        int index = (_currentIndex + _imageArr.count - 1)%_imageArr.count;
        [self changeImageIndex:index];
    }
}

//控制手势是否继续下传
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    NSLog(@"%s",__func__);
    if ([otherGestureRecognizer.view isKindOfClass:[UIImageView class]]) {
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    NSLog(@"%s",__func__);
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    NSLog(@"%s",__func__);
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press{
    
    NSLog(@"%s",__func__);
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    NSLog(@"%s",__func__);
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    NSLog(@"%s",__func__);
    return YES;
}

- (void)changeImageIndex:(int)index{
    
    _imageView.image = [UIImage imageNamed:_imageArr[index]];
    _currentIndex = index;
    self.navigationItem.title = _imageArr[_currentIndex];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%s",__func__);
    NSLog(@"%@",touches);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%s",__func__);
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
