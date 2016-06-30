
//
//  SecondViewController.m
//  本地令牌demo
//
//  Created by user on 16/5/24.
//  Copyright © 2016年 lvyongtao. All rights reserved.
//

#import "SecondViewController.h"
#import "WaterWaveView.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addAnimation];
    // Do any additional setup after loading the view.
}

- (void)addAnimation{
    self.view.backgroundColor = [UIColor whiteColor];
    
     WaterWaveView*waterView = [[WaterWaveView alloc]initWithFrame:CGRectMake(50 , self.view.center.y - 50, self.view.frame.size.width - 50*2, self.view.frame.size.width - 50*2)];
    waterView.percent = 0.85;
    [waterView startAnimation];
    [self.view addSubview:waterView];
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
