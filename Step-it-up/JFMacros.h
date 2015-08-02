//
//  JFMacros.h
//  Step-it-up
//
//  Created by syfll on 15/8/2.
//  Copyright © 2015年 JFT0M. All rights reserved.
//
//  用来放页面布局的宏定义

#ifndef JFMacros_h
#define JFMacros_h


//Tweet Cell
#define kTweetCell_PadingLeft 50.0
#define kTweetCell_PadingTop 45.0
#define kTweetCell_PadingBottom 10.0
#define kTweetCell_ContentWidth (kScreen_Width -kTweetCell_PadingLeft - kPaddingLeftWidth)
#define kTweetCell_LikeComment_Height 25.0
#define kTweetCell_LikeComment_Width 50.0
#define kTweetCell_LikeUsersCCell_Height 45.0
#define kTweetCell_LikeUserCCell_Height 25.0
#define kTweetCell_LikeUserCCell_Pading 10.0
#define kTweetCell_LocationCCell_Pading 9.0

#define kTweetCell_MaxNumberWithComment 5

#define kTweet_ContentFont [UIFont systemFontOfSize:16]
#define kTweet_ContentMaxHeight 125.0
#define kTweet_CommentFont [UIFont systemFontOfSize:14]
#define kTweet_TimtFont [UIFont systemFontOfSize:12]
#define kTweet_LikeUsersLineCount 7.0

#define kTweetCommentCell_LeftOrRightPading 10.0
#define kTweetCommentCell_ContentWidth (kScreen_Width -50 - kPaddingLeftWidth - 2*kTweetCommentCell_LeftOrRightPading)
#define kTweetCommentCell_ContentMaxHeight 105.0

//Tweet Collection Cell

#define kTweetMediaItemCCellSingle_Width (0.4 *kScreen_Width)
#define kTweetMediaItemCCellSingle_WidthMonkey ((kScreen_Width - 80.0)/3.0)
#define kTweetMediaItemCCellSingle_MaxHeight (0.4 *kScreen_Height)

#define kTweetMediaItemCCell_Width ((kScreen_Width - 80.0)/3.0)

#endif /* JFMacros_h */
