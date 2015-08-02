//
//  Tweet.m
//  Step-it-up
//
//  Created by syfll on 15/7/31.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

@synthesize isLiked = _isLiked;

-(BOOL)isLiked{
#warning 这里设置的是假的值，需要判断之后才能知道是否点过赞，需要补充判断代码
    return true;
    
}
-(void)setIsLiked:(BOOL)isLiked{
    _isLiked = isLiked;
}
- (NSInteger)numOfLikers{
    return MIN((_isLiked?_like_users.count +1 :_like_users.count +1),
                   [self maxLikerNum]);
}
- (NSInteger)numOfComments{
    return _comment_list.count;
}

- (BOOL)hasMoreComments{
    return _comment_list.count > kTweetCell_MaxNumberWithComment;
}

- (NSInteger)maxLikerNum{
    NSInteger maxNum = 8;
    if (kDevice_Is_iPhone6) {
        maxNum = 10;
    }else if (kDevice_Is_iPhone6Plus){
        maxNum = 11;
    }
    return maxNum;
}


@end
