//
//  BusiIntf+UserInfo.m
//  Kuaifu
//
//  Created by ND on 12-12-31.
//  Copyright (c) 2012年 ND. All rights reserved.
//

#import "BusiIntf.h"

@implementation BusiIntf(UserInfo)


#define plist_file @"mycfg.plist"
#define key_username @"username"
#define key_pwd  @"pwd"
#define key_rempwd @"rempwd"
#define key_mobile @"mobile"
#define key_startdate @"startdate"

static NSMutableDictionary* plistDict;
static UserInfo *userInfo;

+ (NSString *) applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

+ (NSString *) getFullPath: (NSString*)filename
{
    return [[BusiIntf applicationDocumentsDirectory] stringByAppendingPathComponent:filename];
}

+ (void)readPlist
{
    NSString *pathname = [BusiIntf getFullPath: plist_file];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:pathname];
    if (fileExists)
    {
        plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:pathname];
        UserInfo* info = [BusiIntf getUserInfo];
        info.UserName = [BusiIntf readKeyValue:key_username];
        info.Pwd = [BusiIntf readKeyValue:key_pwd];
        info.Mobile = [BusiIntf readKeyValue:key_mobile];
        info.StartDate = [BusiIntf readKeyValue:key_startdate];
        if ([[BusiIntf readKeyValue:key_rempwd] isEqualToString:@"1"])
            info.RemPwd = YES;
        else
            info.RemPwd = NO;
    }
    else
    {
        plistDict = [[NSMutableDictionary alloc] init];
    }
}

+ (void)writePlist
{
    if (plistDict)
    {
        UserInfo* info = [BusiIntf getUserInfo];
        [BusiIntf writeKeyValue: key_username value:info.UserName];
        [BusiIntf writeKeyValue: key_pwd value:info.Pwd];
        [BusiIntf writeKeyValue: key_mobile value:info.Mobile];
        [BusiIntf writeKeyValue: key_startdate value:info.StartDate];
        if (info.RemPwd)
            [BusiIntf writeKeyValue: key_rempwd value:@"1"];
        else
            [BusiIntf writeKeyValue: key_rempwd value:@"0"];
        
        NSString *pathname = [BusiIntf getFullPath: plist_file];
        [plistDict writeToFile:pathname atomically:YES];
    }
}

+ (NSString*)readKeyValue: (NSString*)key
{
    if (plistDict == nil)
        [BusiIntf readPlist];
    if (plistDict != nil)
    {
        return [plistDict objectForKey: key];
    }
    return nil;
}

+ (void)writeKeyValue: (NSString*)key value: (NSString*)value
{
    if (plistDict == nil)
        [BusiIntf readPlist];
    if (plistDict != nil)
    {
        if (value != nil)
            [plistDict setObject:value forKey: key];
        else
            [plistDict removeObjectForKey:key];
    }
}

+ (NSMutableDictionary*)getPlist
{
    return plistDict;
}

+ (UserInfo*)getUserInfo
{
    if (plistDict == nil)
        [BusiIntf readPlist];
    if (userInfo == nil)
        userInfo = [[UserInfo alloc]init];
    return  userInfo;
}

@end
