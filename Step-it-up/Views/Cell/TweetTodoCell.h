//
//  TweetTodoCell.h
//  Step-it-up
//
//  Created by syfll on 15/8/7.
//  Copyright © 2015年 JFT0M. All rights reserved.
//
#define JF_Tweet_Todo_Cell @"TweetTodoCell"
#import "BaseCell.h"

@interface TweetTodoCell : BaseCell
/// 用来显示用户头像
@property (strong, nonatomic) UIImageView *ownerImgView;
/// 用来显示用户名
@property (strong, nonatomic) UILabel *userNameLabel;
/// 用来显示“发布了一个日程” 、“参与了一个日程”等信息
@property (strong, nonatomic) UILabel *actionLabel;
/// 用来显示内容的背景
@property (strong, nonatomic) UIView *todoBackView;
/// 用来显示内容
@property (strong, nonatomic) UILabel *contentLabel;
/// 用来显示时钟图片
@property (strong, nonatomic) UIImageView *clockImageView;
/// 用来显示日程执行的时间
@property (strong, nonatomic) UILabel *todoTimeLabel;
/// 用来显示地理信息图片
@property (strong, nonatomic) UIImageView *locationImageView;
/// 用来显示地理信息
@property (strong, nonatomic) UILabel *todoLocationLabel;
/// 用来显示发表的时间
@property (strong, nonatomic) UILabel *publishTimeLabel;
/// “参与人数”&“评论”上方的（水平）分割线
@property (strong, nonatomic) UIView *HorizontalSeparateLine;
/// “参与人数”&“评论”之间的的（垂直）分割线
@property (strong, nonatomic) UIView *VerticalSeparateLine;
/// 用来显示参与人数
@property (strong, nonatomic) UIButton *joinNumButton;
/// 用来显示评论数量
@property (strong, nonatomic) UIButton *commentNumButton;

/// 更新字体大小
- (void)updateFonts;
@end
