//
//  LKAlarmEvent.m
//  LKAlarmManagerDemo
//
//  Created by ljh on 14/11/25.
//  Copyright (c) 2014年 Jianghuai Li. All rights reserved.
//

#import "LKAlarmEvent.h"

@implementation LKAlarmEvent
+(instancetype)fakeLKAlarmEvent{
    LKAlarmEvent *event = [[LKAlarmEvent alloc]init];
    event.title = @"JFT0M 日程测试";
    event.content = @"只有加入到日历当中才有用，是日历中的备注";
    ///工作日提醒
    event.repeatType = LKAlarmRepeatTypeWork;
    ///??秒后提醒我
    event.startDate = [NSDate dateWithTimeIntervalSinceNow:3];
    return event;
}

-(NSInteger)rowid
{
    return _eventId;
}
-(void)setRowid:(NSInteger)rowid
{
    _eventId = rowid;
}

-(void)setEventId:(NSInteger)eventId
{
    _eventId = eventId;
}
-(void)setAlermDidCallbacked:(BOOL)alermDidCallbacked
{
    _alermDidCallbacked = alermDidCallbacked;
}

+(NSString *)getPrimaryKey
{
    return @"eventId";
}
+(BOOL)isContainParent
{
    return YES;
}
+(LKDBHelper *)getUsingLKDBHelper
{
    static LKDBHelper* helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[LKDBHelper alloc]initWithDBName:@"LKAlarm.db"];
    });
    return helper;
}

-(void)setIsJoinedCalendar:(BOOL)isJoinedCalendar
{
    _isJoinedCalendar = isJoinedCalendar;
}
-(void)setIsJoinedLocalNotify:(BOOL)isJoinedLocalNotify
{
    _isJoinedLocalNotify = isJoinedLocalNotify;
}
-(void)setURL:(NSString *)URL
{
    _URL = URL;
}
-(void)setEventIdentifier:(NSString *)eventIdentifier
{
    _eventIdentifier = eventIdentifier;
}
@end
