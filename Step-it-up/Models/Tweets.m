//
//  Tweets.m
//  Step-it-up
//
//  Created by syfll on 15/8/4.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "Tweets.h"

@implementation Tweets
-(instancetype)init{
    if (!self) {
        self = [super init];
        self.tweets = [[NSMutableArray alloc]initWithCapacity:4];
    }
    return self;
}

-(NSMutableArray *)updateTweets{
    [self.tweets insertObject:[Tweet fakeInit] atIndex:0];
    return self.tweets;
}
-(NSMutableArray *)updateMoreTweets{
    [self.tweets addObject:[Tweet fakeInit]];
    return self.tweets;
}


@end
