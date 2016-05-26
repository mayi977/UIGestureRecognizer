//
//  ViewController.m
//  UIGestureRecognizerDemo
//
//  Created by Zilu.Ma on 16/5/26.
//  Copyright © 2016年 zilu.ma. All rights reserved.
//

#import "ViewController.h"
#import "GestureRecognizerViewController.h"
#import "ExampleViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UIView *_view;
    UITableView *_tableView;
    NSArray *_array;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    UITouch *touch = [[UITouch alloc] init];
//    //列出当前正在处理此触摸的手势识别器
//    NSArray *arr = touch.gestureRecognizers;
//    
//    UIEvent *event = [[UIEvent alloc] init];
//    //列出目前正在由特定手势识别器处理的触模
//    NSSet *set =  event.allTouches;
    
//    _view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 250, 250)];
//    _view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:_view];
//    
//    UIGestureRecognizer *gestureRecognizer = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizer:)];
////    gestureRecognizer.
//    [_view addGestureRecognizer:gestureRecognizer];
    
    _array = @[@"tapGestureRecoginzer",@"pinchGestureRecognizer",@"rotationGestureRscognizer",@"swipeGestureRecognizer",@"panGestureRecognizer",@"longPressGestureRecognizer",@"单击,双击,平推",@"综合应用"];
    [self myTableView];
}

- (void)myTableView{
    
    CGRect rect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = _array[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 7) {
        ExampleViewController *exampleVC = [[ExampleViewController alloc] init];
        [self.navigationController pushViewController:exampleVC animated:YES];
    }else{
        GestureRecognizerViewController *VC = [[GestureRecognizerViewController alloc] init];
        VC.type = indexPath.row+1;
        VC.title = _array[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

- (void)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer{
    
    NSLog(@"%@",gestureRecognizer);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
