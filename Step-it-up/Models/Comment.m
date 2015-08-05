//
//  Comment.m
//  Coding_iOS
//
//  Created by 王 原闯 on 14-7-30.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import "Comment.h"

@implementation Comment

+(instancetype)fakeComment{
    Comment * comment = [[Comment alloc]init];
    comment.content = @"@xdemo 233333 @刘峰 好无力";
    comment.owner = [User fakeUser];
    comment.id = [[NSNumber alloc]initWithInt:141831];
    comment.owner_id = [[NSNumber alloc]initWithInt:5764];
    comment.tweet_id = [[NSNumber alloc]initWithInt:63597];
    comment.created_at = [[NSDate alloc]initWithTimeIntervalSinceNow:10];
    comment.htmlMedia = [HtmlMedia fakeHtmlMedia];
    return comment;
}



- (void)setContent:(NSString *)content{
    if (_content != content) {
        _htmlMedia = [HtmlMedia htmlMediaWithString:content showType:MediaShowTypeAll];
        _content = _htmlMedia.contentDisplay;
    }
}

@end
