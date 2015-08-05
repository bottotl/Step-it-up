//
//  Tweet.h
//  Step-it-up
//
//  Created by syfll on 15/7/31.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Comment.h"

@interface Tweet : NSObject

///用户数据
@property (readwrite, strong ,nonatomic) User *user;

///发表时间
@property (readwrite, strong ,nonatomic) NSDate *time;

///发表的内容
@property (readwrite, strong ,nonatomic) NSString *content;

///发表的地理信息
@property (readwrite, strong ,nonatomic) NSString *location;

///发表的设备名称device
@property (readwrite, strong ,nonatomic) NSString *device;

///评论存放的数组
@property (readwrite, nonatomic, strong) NSMutableArray *comment_list;

///点赞用户存放的数组
@property (readwrite, nonatomic, strong) NSMutableArray *like_users;

///用来存储媒体数据（图片）
@property (readwrite, nonatomic, strong) HtmlMedia *htmlMedia;

///是否点过赞
@property (nonatomic, assign) BOOL isLiked;

///是否需要在评论栏(tableView)底部显示"查看全部X条评论"
@property (readonly,nonatomic, assign) BOOL hasMoreComments;

///是否需要在点赞用户（collectionView）最后显示总点赞人数
@property (readonly,nonatomic, assign) BOOL hasMoreLikers;


//获取点赞的人数
- (NSInteger)numOfLikers;
//获取评论的人数
- (NSInteger)numOfComments;



+(instancetype)fakeInit;
@end
