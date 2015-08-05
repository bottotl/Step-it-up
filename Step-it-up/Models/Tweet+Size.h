//
//  Tweet+Size.h
//  Step-it-up
//
//  Created by syfll on 15/8/2.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "Tweet.h"

@interface Tweet (Size)

//Size&Origin
- (CGFloat)contentLabelHeight;
- (CGFloat)contentMediaHeight;
- (CGFloat)likeUsersHeightWithTweet;
- (CGFloat)commentListViewHeight;
- (CGFloat)locationHeight;
@end
