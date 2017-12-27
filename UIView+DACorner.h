//
//  UIView+DACorner.h
//  HGCorner
//
//  Created by hongliang li on 2017/12/27.
//  Copyright © 2017年 zhh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DACornerPosition) {
    DACornerPositionTop,
    DACornerPositionTopLeft,
    DACornerPositionTopRight,
    DACornerPositionLeft,
    DACornerPositionBottom,
    DACornerPositionBottomLeft,
    DACornerPositionBottomRight,
    DACornerPositionRight,
    DACornerPositionAll
};

@interface UIView (DACorner)

@property (nonatomic, assign) DACornerPosition da_cornerPosition;
@property (nonatomic, assign) CGFloat da_cornerRadius;

- (void)da_setCornerOnTopWithRadius:(CGFloat)radius;
- (void)da_setCornerOnTopLeftWithRadius:(CGFloat)radius;
- (void)da_setCornerOnTopRightWithRadius:(CGFloat)radius;
- (void)da_setCornerOnLeftWithRadius:(CGFloat)radius;
- (void)da_setCornerOnBottomWithRadius:(CGFloat)radius;
- (void)da_setCornerOnBottomLeftWithRadius:(CGFloat)radius;
- (void)da_setCornerOnBottomRightWithRadius:(CGFloat)radius;
- (void)da_setCornerOnRightWithRadius:(CGFloat)radius;
- (void)da_setAllCornerWithCornerRadius:(CGFloat)radius;
- (void)da_setNoneCorner;

@end
