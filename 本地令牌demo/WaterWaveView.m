//
//  WaterWaveView.m
//  本地令牌demo
//
//  Created by lvyongtao on 16/6/30.
//  Copyright © 2016年 lvyongtao. All rights reserved.
//

#import "WaterWaveView.h"


@interface WaterWaveView ()


@property (strong, nonatomic) UIColor *tintWaterColor;

@property (strong, nonatomic) CADisplayLink *link;

@property (assign, nonatomic) BOOL isAdd;

@property (assign, nonatomic) float waterWaveLineY;

@property (assign, nonatomic) float maxAdd;

@property (assign, nonatomic) float minAdd;


@end

@implementation WaterWaveView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        self.layer.cornerRadius = (self.frame.size.width)/2;
        self.layer.masksToBounds = YES;
        
        _maxAdd = 1.0;
        _minAdd = 0;
        _isAdd = NO;
    }
    return self;
}

- (void)startAnimation{
    _tintWaterColor = [UIColor colorWithRed:86/255.0f green:202/255.0f blue:139/255.0f alpha:1];
    if (self.percent >1.0) {
        self.percent = 1.0;
    }
    _waterWaveLineY = self.frame.size.height *(1 - self.percent);
    
    _link =  [CADisplayLink displayLinkWithTarget:self selector:@selector(animateWave)];
    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}
-(void)animateWave{
    _isAdd? (_maxAdd += 0.01):(_maxAdd -= 0.01);
    if (_maxAdd<=0.5) {
        _isAdd = YES;
    }
    if (_maxAdd>=1.0) {
        _isAdd = NO;
    }
    _minAdd += 0.1;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:self.frame.size.width startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    [[UIColor colorWithRed:7/255.0 green:25/255.0 blue:10/255.0 alpha:1] setStroke];
    //7,25,10
    [[UIColor colorWithRed:7/255.0 green:25/255.0 blue:10/255.0 alpha:1] setFill];
    bezierPath.lineWidth = 1.0;
    [bezierPath stroke];
    [bezierPath fill];
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, [_tintWaterColor CGColor]);
    
    float y=_waterWaveLineY;
    CGPathMoveToPoint(path, NULL, 0, y);
    //控制幅度
    float tempNum = 80;
     for(float x=0;x<=self.frame.size.width;x++){
        y= _maxAdd*sin(x*(M_PI/tempNum) + 4*_minAdd/M_PI) * 10 + _waterWaveLineY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, self.frame.size.width, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, _waterWaveLineY);
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
    
    
}



@end
