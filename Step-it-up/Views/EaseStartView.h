//
//  EaseStartView.h
//  Step-it-up
//
//  Created by syfll on 7/28/15.
//  Copyright © 2015 JFT0M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EaseStartView : UIView

+ (instancetype)startView;

- (void)startAnimationWithCompletionBlock:(void(^)(EaseStartView *easeStartView))completionHandler;

@end
