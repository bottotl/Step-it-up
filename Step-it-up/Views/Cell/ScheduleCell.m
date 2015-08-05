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

#define kSchedue_Content_Font [UIFont systemFontOfSize:12]

#import "ScheduleCell.h"

@interface ScheduleCell()
//左边的圆圈
@property (nonatomic, strong) UIImageView *circleImageView;
//内容中得地点前的图标
@property (nonatomic, strong) UIImageView *locationImageView;
//内容
@property (nonatomic, strong) UILabel *content;
@end
@implementation ScheduleCell

@synthesize event = _event;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        //初始控件
        self.circleImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        //self.circleImageView.
        [self addSubview:self.circleImageView];
        
        self.locationImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:self.locationImageView];
        
        self.content = [[UILabel alloc]initWithFrame:CGRectZero];
        [self addSubview:self.content];
        self.content.font = kSchedue_Content_Font;
        self.content.textAlignment = NSTextAlignmentRight;
        self.content.textColor = [UIColor colorWithHexString:@"0x999999"];

    }
    
    self.circleImageView.image = [UIImage imageNamed:@"multiply_timeline_cell"];
    self.locationImageView.image = [UIImage imageNamed:@"multiply_timeline_location"];
    
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self configConstraints];
}


-(void)setEvent:(LKAlarmEvent *)event{
    _event = event;
    CGFloat cellHeight = [ScheduleCell cellHeight:event];
    self.content.text = event.content;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(cellHeight));
        
    }];
}
-(void)configConstraints{
    [self.circleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.top.equalTo(self.mas_left).offset(20);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@30);
    }];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@20).priorityHigh();
        make.right.equalTo(self.mas_right).offset(10);
        make.left.equalTo(self.circleImageView.mas_right).offset(10);
        make.top.equalTo(self.mas_leading).offset(20);
    }];
    [self.locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.circleImageView.mas_left).offset(5);
        make.top.equalTo(self.content.mas_bottom).offset(8);
        make.height.mas_equalTo(@18);
        make.width.mas_equalTo(@10);
    }];
}
+(CGFloat)cellHeight:(LKAlarmEvent *)event{
    return 100;
}


@end
