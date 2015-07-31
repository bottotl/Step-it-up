//
//  BaseCell.m
//  Step-it-up
//
//  Created by syfll on 15/7/31.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (void)awakeFromNib {
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont systemFontOfSize:17];
        self.textLabel.textColor = [UIColor colorWithHexString:@"0x222222"];
    }
    return self;
}
-(void)setImageAndTitle:(NSString *)imageName title:(NSString *)titleName{

    self.imageView.image = [UIImage imageNamed:imageName];
    self.textLabel.text = titleName;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
+ (CGFloat)cellHeight{
    return 44.0;
}

@end
