//
//  TweetCell.h
//  Step-it-up
//
//  Created by syfll on 15/7/31.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Tweet.h"
#import "Tweet+Size.h"
#import "UITTTAttributedLabel.h"
#import "UICustomCollectionView.h"
#import "TweetMediaItemCCell.h"
#import "TweetMediaItemSingleCCell.h"
#import "TweetLikeUserCCell.h"
#import "TweetCommentCell.h"
#import "TweetCommentMoreCell.h"

#import "Login.h"

#define kCellIdentifier_Tweet @"TweetCell"

typedef void (^CommentClickedBlock) (Tweet *curTweet, NSInteger index, id sender);
typedef void (^DeleteClickedBlock) (Tweet *curTweet, NSInteger outTweetsIndex);
typedef void (^LikeBtnClickedBlock) (Tweet *curTweet);
typedef void (^UserBtnClickedBlock) (User *curUser);
typedef void (^MoreLikersBtnClickedBlock) (Tweet *curTweet);
typedef void (^LocationClickedBlock) (Tweet *curTweet);

@interface TweetCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate, TTTAttributedLabelDelegate>
///Model


///存储了这条动态（tweet）的内容
@property (strong,nonatomic)Tweet *tweet;

/*
**    View
*/

///用来显示用户头像
@property (strong, nonatomic) UITapImageView *ownerImgView;
///用来显示用户昵称
@property (strong, nonatomic) UIButton *ownerNameBtn;
///用来显示这条动态（tweet）的文字内容
@property (strong, nonatomic) UITTTAttributedLabel *contentLabel;
///用来显示这条动态（tweet）发表的时间
@property (strong, nonatomic) UILabel *timeLabel;
///这条动态（tweet）发表的时间前面的闹钟图案
@property (strong, nonatomic) UIImageView *timeClockIconView;
///评论（点赞）列表前面的的小三角形
@property (strong, nonatomic) UIImageView *commentOrLikeBeginImgView;
///评论和点赞的分割线
@property (strong, nonatomic) UIImageView *commentOrLikeSplitlineView;

///用来显示这条动态（tweet）发表的设备
@property (strong, nonatomic) UILabel *deviceLabel;
///用来显示这条动态（tweet）发表的地点
@property (strong, nonatomic) UIButton *locaitonBtn;
///点赞按钮
@property (strong, nonatomic) UIButton *likeBtn;
///评论按钮
@property (strong, nonatomic) UIButton *commentBtn;
///删除按钮（只有自己发表的）
@property (strong, nonatomic) UIButton *deleteBtn;
///用来显示点赞的人
@property (strong, nonatomic) UICollectionView *likeUsersView;
///用来显示用户评论
@property (strong, nonatomic) UITableView *commentListView;
///用来显示这条动态（tweet）的图片内容
@property (strong, nonatomic) UICustomCollectionView *mediaView;
///用来存储这条动态（tweet）的图片内容
@property (strong, nonatomic) NSMutableDictionary *imageViewsDict;

//???????
@property (nonatomic, assign) NSInteger outTweetsIndex;


@property (nonatomic, copy) CommentClickedBlock commentClickedBlock;
@property (nonatomic, copy) LikeBtnClickedBlock likeBtnClickedBlock;
@property (nonatomic, copy) UserBtnClickedBlock userBtnClickedBlock;
@property (nonatomic, copy) MoreLikersBtnClickedBlock moreLikersBtnClickedBlock;
@property (nonatomic, copy) DeleteClickedBlock deleteClickedBlock;
@property (nonatomic, copy) LocationClickedBlock locationClickedBlock;
@property (nonatomic, copy) void(^goToDetailTweetBlock) (Tweet *curTweet);
@property (copy, nonatomic) void (^refreshSingleCCellBlock)();
@property (copy, nonatomic) void (^mediaItemClickedBlock)(HtmlMediaItem *curItem);

+(CGFloat)cellHeightWithObj:(id)obj;

@end
