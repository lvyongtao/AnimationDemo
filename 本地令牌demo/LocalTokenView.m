//
//  LocalTokenView.m
//  本地令牌demo
//
//  Created by user on 16/5/20.
//  Copyright © 2016年 lvyongtao. All rights reserved.
//



#define CIRCLE_RADIUS 100.f
#define START_ANGEL -M_PI/2
#define END_ANGEL M_PI*3/2
#define LINE_WIDTH 30.0f
#define Animation_KEY @"DrawCircle"
#define Animation_Duration 6.f




#import "LocalTokenView.h"


@interface LocalTokenView ()

@property (assign, nonatomic) int count;


//@property (assign, nonatomic) int times;


@end

@implementation LocalTokenView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
        
//        [UIView animateWithDuration:0.3f animations:^{
////            self.transform = CGAffineTransformMakeScale(0.1, 0.1);
//            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
//            animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0.1, 1, 1)];
//            animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 1, 1)];
//            animation.duration = 0.3f;
//            animation.repeatCount = 1;
//            [self.layer addAnimation:animation forKey:nil];
//        } completion:^(BOOL finished) {
////            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
//            [self setUp];
//        }];
        
        [self setUp];
    }
    return self;
}
- (void)setUp{
   

    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:self.center radius:CIRCLE_RADIUS startAngle:START_ANGEL endAngle:END_ANGEL clockwise:YES];
    
    _shaperLayer = [CAShapeLayer layer];
    _shaperLayer.path = bezierPath.CGPath;
    _shaperLayer.lineWidth = LINE_WIDTH;
    [_shaperLayer setStrokeColor:[UIColor colorWithRed:0.500 green:0.824 blue:1.000 alpha:1.000].CGColor];
    [_shaperLayer setFillColor:[UIColor whiteColor].CGColor];
    [self.layer addSublayer:_shaperLayer];
    _shaperLayer.strokeStart = 0.f;
    _shaperLayer.strokeEnd = 1.f;
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"strokeEnd";
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = [NSNumber numberWithFloat:1.f];
    animation.duration = Animation_Duration;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    [_shaperLayer addAnimation:animation forKey:Animation_KEY];

    _arc4Lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CIRCLE_RADIUS*2, CIRCLE_RADIUS*2)];
    _arc4Lable.layer.cornerRadius = CIRCLE_RADIUS;
    _arc4Lable.layer.masksToBounds = YES;
    _arc4Lable.backgroundColor = [UIColor colorWithRed:1.000 green:0.863 blue:0.354 alpha:1.000];
    _arc4Lable.textAlignment = NSTextAlignmentCenter;
    _arc4Lable.font = [UIFont boldSystemFontOfSize:32];
    [self reloadNumber];
    _arc4Lable.center = self.center;
    [self addSubview:_arc4Lable];
    _count = 0;
    
//    _times = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restartAnimation) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopAnimation) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
}
- (void)reloadNumber{
    
    
//    NSArray *nameArr = [NSArray arrayWithObjects:@"LYYONGTAO",@"MENGAIJU",@"520",@"I LOVE YOU",nil];
//    if (_count > 3) {
//        _count = 0;
//    }
//    _arc4Lable.text = nameArr[_count];
//    if (_count == 0) {
//       _arc4Lable.text = nameArr[0];
//    }
    
    double singleArc4 = arc4random()%999999 + 100000;
    NSNumber *sinleNumber= [NSNumber numberWithDouble:singleArc4];
    _arc4Lable.text = [NSString stringWithFormat:@"%@",sinleNumber];
}

- (void)addAnimation{
    [_shaperLayer removeAnimationForKey:Animation_KEY];
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"strokeEnd";
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = [NSNumber numberWithFloat:1.f];
    animation.duration = Animation_Duration;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    [_shaperLayer addAnimation:animation forKey:Animation_KEY];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    _count ++;
    if (flag == YES) {
        [self reloadNumber];
        [self addAnimation];
        if ([self.delegate respondsToSelector:@selector(actionWithToken:)]) {
            [self.delegate actionWithToken:_arc4Lable.text];
        }
            NSLog(@"结束动画");
    }else{
//Bug--background
        
        
        [self addAnimation];
        
            NSLog(@"暂停动画");
    }
    

}


#pragma mark -- 通知
- (void)stopAnimation{
    
//    [self pauseLayer:_shaperLayer];
}

- (void)restartAnimation{
//    [self resumeLayer:_shaperLayer];
}
#pragma mark -- 暂停和恢复动画
-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
 
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
    
}

-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 0.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:layer] - pausedTime;
    layer.beginTime = timeSincePause;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:self.center radius:CIRCLE_RADIUS startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    [[UIColor grayColor] setStroke];
    [[UIColor whiteColor] setFill];
    bezierPath.lineWidth = LINE_WIDTH;
    [bezierPath stroke];
    [bezierPath fill];
    
    
    
   
}


@end
