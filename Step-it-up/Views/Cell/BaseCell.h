//
//  BaseCell.h
//  Step-it-up
//
//  Created by syfll on 15/7/31.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell

@property (strong, nonatomic) NSNumber *unreadCount;
-(void)setImageAndTitle:(NSString *)imageName  title:(NSString *)titleName;

+ (CGFloat)cellHeight;

@end
