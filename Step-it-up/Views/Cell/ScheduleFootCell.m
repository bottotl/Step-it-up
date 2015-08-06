//
//  ScheduleFootCell.m
//  Step-it-up
//
//  Created by syfll on 15/8/6.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "ScheduleFootCell.h"

@interface ScheduleFootCell()

@property (nonatomic, strong) UIImageView *JFimageView;
@property (nonatomic, strong) UIView *HorizontallineView;
@end

@implementation ScheduleFootCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //初始控件
        self.HorizontallineView = [[UIView alloc]initWithFrame:CGRectZero];
        self.HorizontallineView.backgroundColor = [[UIColor alloc]initWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1];
        [self addSubview:self.HorizontallineView];
        
        self.JFimageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:self.JFimageView];
    }
    
    self.JFimageView.image = [UIImage imageNamed:@"multiply_timeline_foot"];
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self configConstraints];
}

-(void)configConstraints{
    
    [self.HorizontallineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.JFimageView.mas_centerX);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.JFimageView.mas_centerY);
        make.width.equalTo(@3);
    }];
    [self.JFimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(80);
        make.top.lessThanOrEqualTo(self.mas_top).offset(20);
        make.height.mas_equalTo(@40);
        make.width.mas_equalTo(@40);
    }];
}

@end
