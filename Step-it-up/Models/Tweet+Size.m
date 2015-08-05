//
//  Tweet+Size.m
//  Step-it-up
//
//  Created by syfll on 15/8/2.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "Tweet+Size.h"

@implementation Tweet (Size)
- (CGFloat)contentLabelHeight{
    return MIN(kTweet_ContentMaxHeight, [self.content getHeightWithFont:kTweet_ContentFont constrainedToSize:CGSizeMake(kTweetCell_ContentWidth, CGFLOAT_MAX)]);
}
- (CGFloat)contentMediaHeight{
    CGFloat contentMediaHeight = 0;
    NSInteger mediaCount = self.htmlMedia.imageItems.count;
    if (mediaCount > 0) {
        HtmlMediaItem *curMediaItem = self.htmlMedia.imageItems.firstObject;
        contentMediaHeight = (mediaCount == 1)?
        [self sizeWithSingleMediaItem:curMediaItem].height:
        ceilf((float)mediaCount/3)*([self sizeWithMediaItem].height+kTweetCell_LikeUserCCell_Pading) - kTweetCell_LikeUserCCell_Pading;
    }
    return contentMediaHeight;
}
-(CGSize)sizeWithSingleMediaItem:(HtmlMediaItem*)curMediaItem{
    CGSize itemSize;
    if (curMediaItem.type == HtmlMediaItemType_EmotionMonkey) {
        itemSize = CGSizeMake(kTweetMediaItemCCellSingle_WidthMonkey, kTweetMediaItemCCellSingle_WidthMonkey);
    }else{
        itemSize = [[ImageSizeManager shareManager] sizeWithSrc:curMediaItem.src originalWidth:kTweetMediaItemCCellSingle_Width maxHeight:kTweetMediaItemCCellSingle_MaxHeight];
    }
    return itemSize;
}

-(CGSize)sizeWithMediaItem{
    return CGSizeMake(kTweetMediaItemCCell_Width, kTweetMediaItemCCell_Width);
}

-(CGFloat)commentListViewHeightWithTweet{
    if (!self) {
        return 0;
    }
    CGFloat commentListViewHeight = 0;
    
    NSInteger numOfComments = self.numOfComments;
    BOOL hasMoreComments = self.hasMoreComments;
    
    for (int i = 0; i < numOfComments; i++) {
        if (i == numOfComments-1 && hasMoreComments) {
            commentListViewHeight += [self commentMoreViewHeigh];
        }else{
            Comment *curComment = [self.comment_list objectAtIndex:i];
            commentListViewHeight += [self cellHeightWithCommont:curComment];
        }
    }
    return commentListViewHeight;
}
-(CGFloat)commentMoreViewHeigh{
    return 12+10*2;
}
-(CGFloat)likeUsersHeightWithTweet{
    CGFloat likeUsersHeight = 0;
    if (self.numOfLikers > 0) {
        likeUsersHeight = kTweetCell_LikeUsersCCell_Height;
    }
    return likeUsersHeight;
}
-(CGFloat)cellHeightWithCommont:(Comment *)curComment{
    CGFloat cellHeight = MIN(kTweetCommentCell_ContentMaxHeight, [curComment.content getHeightWithFont:kTweet_CommentFont constrainedToSize:CGSizeMake(kTweetCommentCell_ContentWidth, CGFLOAT_MAX)]) +15 + kScaleFrom_iPhone5_Desgin(15);
    return cellHeight;
}

- (CGFloat)commentListViewHeight{
    if (!self) {
        return 0;
    }
    CGFloat commentListViewHeight = 0;
    
    NSInteger numOfComments = self.numOfComments;
    BOOL hasMoreComments = self.hasMoreComments;
    
    for (int i = 0; i < numOfComments; i++) {
        if (i == numOfComments-1 && hasMoreComments) {
            commentListViewHeight += [self commentMoreViewHeigh];
        }else{
            Comment *curComment = [self.comment_list objectAtIndex:i];
            commentListViewHeight += [self cellHeightWithCommont:curComment];
        }
    }
    return commentListViewHeight;
}

- (CGFloat)locationHeight{
    CGFloat ocationHeight = 0;
    if ( self.location.length > 0) {
        ocationHeight = 15 + kTweetCell_LocationCCell_Pading;
    }else{
        ocationHeight = 0;
    }
    return ocationHeight;
}


@end
