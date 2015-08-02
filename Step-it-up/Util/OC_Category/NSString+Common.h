//
//  NSString+Common.h
//  Step-it-up
//
//  Created by syfll on 7/28/15.
//  Copyright © 2015 JFT0M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (NSString*) sha1Str;
- (NSString *)trimWhitespace;


- (NSRange)rangeByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;
- (NSRange)rangeByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;

- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;


- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

- (NSURL *)urlImageWithCodePathResizeToView:(UIView *)view;
- (NSURL *)urlImageWithCodePathResize:(CGFloat)width crop:(BOOL)needCrop;
- (NSURL *)urlImageWithCodePathResize:(CGFloat)width;

//转换拼音
- (NSString *)transformToPinyin ;
@end
