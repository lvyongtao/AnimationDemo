//
//  ViewController.m
//  本地令牌demo
//
//  Created by user on 16/5/20.
//  Copyright © 2016年 lvyongtao. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "LocalTokenView.h"
#import "ACMacros.h"

@interface ViewController ()<LocalTokenDelegate,UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) LocalTokenView *tokenView;
@property (weak, nonatomic) IBOutlet UIButton *action;

@end

@implementation ViewController
- (IBAction)action:(id)sender {
     [self setUp];
    
}
- (IBAction)pushVC:(UIButton *)sender {
     self.view.frame = CGRectMake(0, 0, WIDTH/2, HEIGHT/2);
    [UIView animateWithDuration:10.f animations:^{
        [self.view setNeedsLayout];
    }];
    SecondViewController *second = [[SecondViewController alloc] init];
    [self presentViewController:second animated:NO completion:^{
        NSLog(@"jump true");
    }];
}
- (IBAction)resume:(UIButton *)sender {
    [_tokenView resumeLayer:_tokenView.shaperLayer];
}
- (IBAction)stop:(UIButton *)sender {
    [_tokenView pauseLayer:_tokenView.shaperLayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)setUp{
    self.tokenView.backgroundColor = [UIColor whiteColor];
    
}
- (LocalTokenView *)tokenView{
    if (!_tokenView) {
        _tokenView = [[LocalTokenView alloc] initWithFrame:CGRectMake(0, 0,WIDTH,HEIGHT/2)];
        _tokenView.delegate = self;
//        [[UIApplication sharedApplication].keyWindow addSubview:_tokenView];
        [self.view addSubview:_tokenView];
     
    }
    return _tokenView;
}


- (void)animationRevealFromLeft:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [view.layer addAnimation:animation forKey:nil];
}
- (void)actionWithToken:(NSString *)token{
    //数据上传操作
    NSLog(@"本地的验证指令是：%@",token);
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
