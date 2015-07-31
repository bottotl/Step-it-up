//
//  UIView+Common.h
//  Step-it-up
//
//  Created by syfll on 7/28/15.
//  Copyright © 2015 JFT0M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)


- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )startPoint endPoint:(CGPoint)endPoint;
- (CGSize)doubleSizeOfFrame;

// BadgeTip
- (void)addBadgeTip:(NSString *)badgeValue withCenterPosition:(CGPoint)center;
- (void)addBadgeTip:(NSString *)badgeValue;
- (void)removeBadgeTips;
// Size & Origin
- (void)removeBadgeTips;
- (void)setY:(CGFloat)y;
- (void)setX:(CGFloat)x;
- (void)setOrigin:(CGPoint)origin;
- (void)setHeight:(CGFloat)height;
- (void)setWidth:(CGFloat)width;
- (void)setSize:(CGSize)size;
@end
