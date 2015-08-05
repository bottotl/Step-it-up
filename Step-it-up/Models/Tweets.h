//
//  Tweets.h
//  Step-it-up
//
//  Created by syfll on 15/8/4.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tweet.h"

@interface Tweets : NSObject
@property (strong ,atomic)NSMutableArray * tweets;
-(NSMutableArray *)updateTweets;
-(NSMutableArray *)updateMoreTweets;

@end
