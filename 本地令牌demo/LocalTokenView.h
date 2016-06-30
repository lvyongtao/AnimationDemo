//
//  LocalTokenView.h
//  本地令牌demo
//
//  Created by user on 16/5/20.
//  Copyright © 2016年 lvyongtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LocalTokenDelegate <NSObject>

@optional
- (void)actionWithToken:(NSString *)token;

@end

@interface LocalTokenView : UIView



/**
 *  运动一周的曲线
 */
@property (strong, nonatomic) CAShapeLayer *shaperLayer;

/**
 *  随即6位数显示
 */
@property (strong, nonatomic) UILabel *arc4Lable;

@property (weak, nonatomic) id<LocalTokenDelegate> delegate;

-(void)pauseLayer:(CALayer*)layer;
-(void)resumeLayer:(CALayer*)layer;

@end
