//
//  UIView+Common.m
//  Step-it-up
//
//  Created by syfll on 7/28/15.
//  Copyright © 2015 JFT0M. All rights reserved.
//

#import "UIView+Common.h"
#define kTagBadgeView  1000

@implementation UIView (Common)

#pragma mark - Layer
- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )startPoint endPoint:(CGPoint)endPoint{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.bounds;
    if (cgColorArray && [cgColorArray count] > 0) {
        layer.colors = cgColorArray;
    }else{
        return;
    }
    if (floatNumArray && [floatNumArray count] == [cgColorArray count]) {
        layer.locations = floatNumArray;
    }
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    [self.layer addSublayer:layer];
}
#pragma BadgeTip
- (void)addBadgeTip:(NSString *)badgeValue withCenterPosition:(CGPoint)center{
    if (!badgeValue || !badgeValue.length) {
        [self removeBadgeTips];
    }else{
        UIView *badgeV = [self viewWithTag:kTagBadgeView];
        if (badgeV && [badgeV isKindOfClass:[UIBadgeView class]]) {
            [(UIBadgeView *)badgeV setBadgeValue:badgeValue];
            badgeV.hidden = NO;
        }else{
            badgeV = [UIBadgeView viewWithBadgeTip:badgeValue];
            badgeV.tag = kTagBadgeView;
            [self addSubview:badgeV];
        }
        [badgeV setCenter:center];
    }
}
- (void)addBadgeTip:(NSString *)badgeValue{
    if (!badgeValue || !badgeValue.length) {
        [self removeBadgeTips];
    }else{
        UIView *badgeV = [self viewWithTag:kTagBadgeView];
        if (badgeV && [badgeV isKindOfClass:[UIBadgeView class]]) {
            [(UIBadgeView *)badgeV setBadgeValue:badgeValue];
        }else{
            badgeV = [UIBadgeView viewWithBadgeTip:badgeValue];
            badgeV.tag = kTagBadgeView;
            [self addSubview:badgeV];
        }
        CGSize badgeSize = badgeV.frame.size;
        CGSize selfSize = self.frame.size;
        CGFloat offset = 2.0;
        [badgeV setCenter:CGPointMake(selfSize.width- (offset+badgeSize.width/2),
                                      (offset +badgeSize.height/2))];
    }
}
- (void)removeBadgeTips{
    NSArray *subViews =[self subviews];
    if (subViews && [subViews count] > 0) {
        for (UIView *aView in subViews) {
            if (aView.tag == kTagBadgeView && [aView isKindOfClass:[UIBadgeView class]]) {
                aView.hidden = YES;
            }
        }
    }
}

#pragma mark - size & origin
- (CGSize)doubleSizeOfFrame{
    CGSize size = self.frame.size;
    return CGSizeMake(size.width*2, size.height*2);
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size.width = size.width;
    frame.size.height = size.height;
    self.frame = frame;
}


@end
