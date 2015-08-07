//
//  ScheduleCell.m
//  Step-it-up
//
//  Created by syfll on 15/8/4.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#define KScheduleCell_Circle_Size 30
#define KScheduleCell_Location_Width 20
#define KScheduleCell_Location_Height 30

#define kSchedue_Content_Font [UIFont systemFontOfSize:16]
#define kSchedue_LocationContent_Font [UIFont systemFontOfSize:12]
#define kSchedue_Time_Font [UIFont systemFontOfSize:12]

#import "ScheduleCell.h"

@interface ScheduleCell()
//标记是否已经设置了限制
@property (nonatomic, assign) BOOL didSetupConstraints;
//左边的圆圈
@property (nonatomic, strong) UIImageView *circleImageView;
//内容中得地点前的图标
@property (nonatomic, strong) UIImageView *locationImageView;
//显示内容用的label
@property (nonatomic, strong) UILabel *contentLabel;
//显示地理信息用的button
@property (nonatomic, strong) UIButton *locationContentBtn;
//显示时间用的label
@property (nonatomic, strong) UILabel *timeLabel;
// 垂直线
@property (nonatomic, strong) UIView *HorizontallineView;
// 水平线
@property (nonatomic, strong) UIView *VerticallineView;
@end
@implementation ScheduleCell

@synthesize event = _event;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadViews];
    }
    return self;
}
-(void)loadViews{
    // Initialization code
    //初始控件
    self.HorizontallineView = [[UIView alloc]initWithFrame:CGRectZero];
    self.HorizontallineView.backgroundColor = [[UIColor alloc]initWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1];
    
    self.VerticallineView = [[UIView alloc]initWithFrame:CGRectZero];
    self.VerticallineView.backgroundColor = [[UIColor alloc]initWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1];
    
    self.circleImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    
    self.locationImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.contentLabel.font = kSchedue_Content_Font;
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentLabel setNumberOfLines:0];
    self.contentLabel.textColor = [UIColor colorWithHexString:@"0x999999"];
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.timeLabel.font = kSchedue_Time_Font;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.textColor = [[UIColor alloc]initWithRed:40.0/255.0 green:147.0/255.0 blue:86.0/255.0 alpha:1];
    
    
    self.locationContentBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    self.locationContentBtn.titleLabel.font = kSchedue_LocationContent_Font;
    self.locationContentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.locationContentBtn setTitleColor:[[UIColor alloc]initWithRed:126.0/255.0 green:123.0/255.0 blue:132.0/255.0 alpha:1] forState:UIControlStateNormal];
    
    
    [self.contentView addSubview:self.HorizontallineView];
    [self.contentView addSubview:self.VerticallineView];
    [self.contentView addSubview:self.circleImageView];
    [self.contentView addSubview:self.locationImageView];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.locationContentBtn ];
    
    self.circleImageView.image = [UIImage imageNamed:@"multiply_timeline_cell"];
    self.locationImageView.image = [UIImage imageNamed:@"multiply_timeline_location"];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    //self.contentLabel.preferredMaxLayoutWidth = CGRectGetHeight(self.contentLabel.frame);
    self.contentLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.contentLabel.frame);
}


-(void)setEvent:(LKAlarmEvent *)event{
    _event = event;
    self.contentLabel.text = event.content;
    self.timeLabel.text = [[self dateFormatter] stringFromDate:event.startDate];
    [self.locationContentBtn setTitle:@"WHU" forState:UIControlStateNormal];
}

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}
-(void)updateConstraints{
    
    if(!self.didSetupConstraints){
    [self.HorizontallineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.circleImageView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.width.equalTo(@3);
    }];
    
    [self.VerticallineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.HorizontallineView.mas_right);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        //make.bottom.equalTo(self.contentView.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.height.equalTo(@2);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.centerY.equalTo(self.circleImageView.mas_centerY);
        make.right.equalTo(self.circleImageView.mas_left);
        
    }];
    [self.circleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_left).offset(80);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.height.mas_equalTo(@15);
        make.width.mas_equalTo(@15);
    }];
    [self.locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.circleImageView.mas_right).offset(5);
        make.centerY.equalTo(self.circleImageView.mas_centerY);
        make.height.mas_equalTo(@18);
        make.width.mas_equalTo(@10);
    }];
    [self.locationContentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.locationImageView.mas_right).offset(5);
        make.centerY.equalTo(self.circleImageView.mas_centerY);
        make.height.mas_equalTo(@18);
        make.width.mas_equalTo(@80);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.locationContentBtn.mas_left);
        make.top.equalTo(self.circleImageView.mas_bottom).offset(8);
        //make.height.mas_equalTo(@20).priorityHigh();
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.bottom.equalTo(self.VerticallineView.mas_top);
    }];
    self.didSetupConstraints = YES;
    }
    [super updateConstraints];
    
}


@end
