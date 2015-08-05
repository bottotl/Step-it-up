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


+(instancetype)fakeInit{
    Tweet * tweet = [[Tweet alloc]init];
    tweet.user = [User fakeUser];
    tweet.time = [[NSDate alloc]initWithTimeIntervalSinceNow:100];
    tweet.content = @"这是假装加载的假的数据，由于服务器没有搭建，所以暂时使用假的数据测试显示效果，测试完成后需要删除";
    tweet.like_users = [[NSMutableArray alloc]initWithArray:@[[User fakeUser]]];
    
    tweet.comment_list = [[NSMutableArray alloc]initWithArray:@[[Comment fakeComment]]];
    tweet.htmlMedia = [[HtmlMedia alloc]initWithString:@"<p><a href=\"https://dn-coding-net-production-pp.qbox.me/eea1e241-3f52-4396-9873-6ae2561c7467.png\" target=\"_blank\" class=\"bubble-markdown-image-link\" rel=\"nofollow\"><img src=\"https://dn-coding-net-production-pp.qbox.me/eea1e241-3f52-4396-9873-6ae2561c7467.png\" alt=\"图片\" class=\" bubble-markdown-image\"></a></p>" showType:MediaShowTypeNone];
    return tweet;
}

-(BOOL)isLiked{

    return _isLiked;
    
}
-(void)setIsLiked:(BOOL)isLiked{
    _isLiked = isLiked;
}
- (NSInteger)numOfLikers{
    return MIN((_isLiked?_like_users.count :_like_users.count),
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
