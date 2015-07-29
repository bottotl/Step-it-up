//
//  UIBarButtonItem+Common.h
//  Step-it-up
//
//  Created by syfll on 15/7/29.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Common)
+ (UIBarButtonItem *)itemWithBtnTitle:(NSString *)title target:(id)obj action:(SEL)selector;
@end
