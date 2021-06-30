//
//  UIView+Extension.h
//  fmeimei
//
//  Created by 李强 on 2017/5/25.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

//size
@property (assign, nonatomic) CGFloat top;
@property (assign, nonatomic) CGFloat bottom;
@property (assign, nonatomic) CGFloat left;
@property (assign, nonatomic) CGFloat right;

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGPoint origin;

@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;

@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;

//borderRadius

- (void)ef_cornerRadiusWithTopRight:(CGFloat )radius;
- (void)ef_cornerRadiusWithTopLeft:(CGFloat )radius;

- (void)ef_cornerRadiusWithBottomLeft:(CGFloat )radius;
- (void)ef_cornerRadiusWithBottomRight:(CGFloat )radius;

- (void)ef_cornerRadiusWithRight:(CGFloat )radius;
- (void)ef_cornerRadiusWithLeft:(CGFloat )radius;
- (void)ef_cornerRadiusWithTop:(CGFloat )radius;
- (void)ef_cornerRadiusWithBottom:(CGFloat )radius;


- (void)ef_cornerRadius:(CGFloat )radius;
- (void)ef_layerRadius:(CGFloat )radius; 
- (void)ef_borderRadius:(CGFloat)radius color:(UIColor *)color;

@end
