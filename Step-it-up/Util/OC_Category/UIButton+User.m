//
//  UIButton+User.m
//  Step-it-up
//
//  Created by syfll on 15/7/31.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "UIButton+User.h"

@implementation UIButton (User)
+(instancetype)initUserButton{
    UIButton *userBtn = [[UIButton alloc]init];
    [userBtn setUserStyle];
    return userBtn;
}
-(void)setUserStyle{
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 2.0;
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    [self setTitleColor:[UIColor colorWithHexString:@"0x3bbd79"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
}
- (void)setUserTitle:(NSString *)aUserName font:(UIFont *)font maxWidth:(CGFloat)maxWidth{
    [self setTitle:aUserName forState:UIControlStateNormal];
    CGRect frame = self.frame;
    CGFloat titleWidth = [self.titleLabel.text getWidthWithFont:font constrainedToSize:CGSizeMake(kScreen_Width, frame.size.height)];
    if (titleWidth > maxWidth) {
        titleWidth = maxWidth;
        //        self.titleLabel.minimumScaleFactor = 0.5;
        //        self.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    [self setWidth:titleWidth];
    [self.titleLabel setWidth:titleWidth];
}
@end
