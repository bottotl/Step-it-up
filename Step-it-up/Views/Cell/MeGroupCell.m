//
//  MeGroupCell.m
//  Step-it-up
//
//  Created by syfll on 15/7/31.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "MeGroupCell.h"

@implementation MeGroupCell

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(kPaddingLeftWidth, ([MeGroupCell cellHeight]-35)/2, 35, 35);
    self.textLabel.frame = CGRectMake(75, ([MeGroupCell cellHeight]-30)/2, (kScreen_Width - 120), 30);
    NSString *badgeTip = @"";
    if (self.unreadCount && self.unreadCount.integerValue > 0) {
        if (self.unreadCount.integerValue > 99) {
            badgeTip = @"99+";
        }else{
            badgeTip = self.unreadCount.stringValue;
        }
        self.accessoryType = UITableViewCellAccessoryNone;
    }else{
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [self.contentView addBadgeTip:badgeTip withCenterPosition:CGPointMake(kScreen_Width-25, [MeGroupCell cellHeight]/2)];
}

+ (CGFloat)cellHeight{
    return 44.0;
}


@end
