//
//  UIView+DACorner.m
//  HGCorner
//
//  Created by hongliang li on 2017/12/27.
//  Copyright © 2017年 zhh. All rights reserved.
//

#import "UIView+DACorner.h"
#import <objc/runtime.h>

static NSString * const DACornerPositionKey = @"DACornerPositionKey";
static NSString * const DACornerRadiusKey = @"DACornerRadiusKey";
@implementation UIView (DACorner)
@dynamic da_cornerPosition;
- (DACornerPosition)da_cornerPosition
{
    return [objc_getAssociatedObject(self, &DACornerPositionKey) integerValue];
}

- (void)setDa_cornerPosition:(DACornerPosition)da_cornerPosition{
    objc_setAssociatedObject(self, &DACornerPositionKey, @(da_cornerPosition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@dynamic da_cornerRadius;
- (CGFloat)da_cornerRadius
{
    return [objc_getAssociatedObject(self, &DACornerRadiusKey) floatValue];
}

- (void)setDa_cornerRadius:(CGFloat)da_cornerRadius{
    objc_setAssociatedObject(self, &DACornerRadiusKey, @(da_cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load
{
    SEL ori = @selector(layoutSublayersOfLayer:);
    SEL new = NSSelectorFromString([@"hh_" stringByAppendingString:NSStringFromSelector(ori)]);
    hh_swizzle(self, ori, new);
}

void hh_swizzle(Class c, SEL orig, SEL new)
{
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    
    method_exchangeImplementations(origMethod, newMethod);
}

- (void)hh_layoutSublayersOfLayer:(CALayer *)layer
{
    [self hh_layoutSublayersOfLayer:layer];
    
    if (self.da_cornerRadius > 0) {
        
        UIBezierPath *maskPath;
        switch (self.da_cornerPosition) {
            case DACornerPositionTop:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                       cornerRadii:CGSizeMake(self.da_cornerRadius, self.da_cornerRadius)];
                break;
            case DACornerPositionTopLeft:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopLeft)
                                                       cornerRadii:CGSizeMake(self.da_cornerRadius, self.da_cornerRadius)];
                break;
            case DACornerPositionTopRight:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopRight)
                                                       cornerRadii:CGSizeMake(self.da_cornerRadius, self.da_cornerRadius)];
                break;
            case DACornerPositionLeft:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft)
                                                       cornerRadii:CGSizeMake(self.da_cornerRadius, self.da_cornerRadius)];
                break;
            case DACornerPositionBottom:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                                       cornerRadii:CGSizeMake(self.da_cornerRadius, self.da_cornerRadius)];
                break;
            case DACornerPositionBottomLeft:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerBottomLeft)
                                                       cornerRadii:CGSizeMake(self.da_cornerRadius, self.da_cornerRadius)];
                break;
            case DACornerPositionBottomRight:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerBottomRight)
                                                       cornerRadii:CGSizeMake(self.da_cornerRadius, self.da_cornerRadius)];
                break;
            case DACornerPositionRight:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight)
                                                       cornerRadii:CGSizeMake(self.da_cornerRadius, self.da_cornerRadius)];
                break;
            case DACornerPositionAll:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:UIRectCornerAllCorners
                                                       cornerRadii:CGSizeMake(self.da_cornerRadius, self.da_cornerRadius)];
                break;
                
        }
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    }
}

- (void)da_setCornerOnTopWithRadius:(CGFloat)radius
{
    self.da_cornerPosition = DACornerPositionTop;
    self.da_cornerRadius = radius;
}

- (void)da_setCornerOnTopLeftWithRadius:(CGFloat)radius{
    self.da_cornerPosition = DACornerPositionTop;
    self.da_cornerRadius = radius;
}
- (void)da_setCornerOnTopRightWithRadius:(CGFloat)radius{
    self.da_cornerPosition = DACornerPositionTop;
    self.da_cornerRadius = radius;
}

- (void)da_setCornerOnLeftWithRadius:(CGFloat)radius
{
    self.da_cornerPosition = DACornerPositionLeft;
    self.da_cornerRadius = radius;
}

- (void)da_setCornerOnBottomWithRadius:(CGFloat)radius
{
    self.da_cornerPosition = DACornerPositionBottom;
    self.da_cornerRadius = radius;
}

- (void)da_setCornerOnBottomLeftWithRadius:(CGFloat)radius{
    self.da_cornerPosition = DACornerPositionBottom;
    self.da_cornerRadius = radius;
}
- (void)da_setCornerOnBottomRightWithRadius:(CGFloat)radius{
    self.da_cornerPosition = DACornerPositionBottom;
    self.da_cornerRadius = radius;
}

- (void)da_setCornerOnRightWithRadius:(CGFloat)radius
{
    self.da_cornerPosition = DACornerPositionRight;
    self.da_cornerRadius = radius;
}

- (void)da_setAllCornerWithCornerRadius:(CGFloat)radius
{
    self.da_cornerPosition = DACornerPositionAll;
    self.da_cornerRadius = radius;
}

- (void)da_setNoneCorner
{
    self.layer.mask = nil;
}
@end
