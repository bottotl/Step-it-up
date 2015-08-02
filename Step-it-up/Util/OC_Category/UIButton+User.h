//
//  UIButton+User.h
//  Step-it-up
//
//  Created by syfll on 15/7/31.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (User)
+(instancetype)initUserButton;
-(void)setUserStyle;
- (void)setUserTitle:(NSString *)aUserName font:(UIFont *)font maxWidth:(CGFloat)maxWidth;
@end
