//
//  AWHttpTool.m
//  MyWeibo
//
//  Created by All on 14-10-3.
//  Copyright (c) 2014年 All. All rights reserved.
//

#import "IBHttpTool.h"
#import "NSData+AES256.h"
#import "AFNetworking.h"
#import "NSString+AES256.h"
#import "SBJSON.h"
#import "Base64.h"
#import "GTMBase64.h"
#define AESKEY @"duew&^%5d54nc'KH"

@implementation IBHttpTool

+ (void)postWithURL:(NSString *)url params:(NSString *)params success:(IBHttpSuccess)success failure:(IBHttpFailure)failure
{
    [self requestWithMethod:@"POST" url:url params:params success:success failure:failure];
}

+ (void)requestWithMethod:(NSString *)method url:(NSString *)url params:(NSString *)params success:(IBHttpSuccess)success failure:(IBHttpFailure)failure
{
    
    NSDictionary *dic = [params JSONValue];
    //NSLog(@"传过来的参数:%@",dic);
    NSDictionary *dicc = dic[@"data"];
    NSString *action = dic[@"action"];
   
    NSString *Params = [dicc JSONFragment];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSSet *set = [NSSet setWithObjects:@"text/html", @"application/json",@"text/plain", nil];
    manager.responseSerializer.acceptableContentTypes = set;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //create the body
    //加密
    
    //base64编码
    NSData *base64Data = [Params dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    base64Data = [GTMBase64 encodeData:base64Data];
    NSString *base64String = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    if ([action isEqualToString:@"fileUploadState"]) { //如果是上传照片则不需base64编码
        base64String = Params;
    }
    //NSLog(@"base64:%@",base64String);
    NSString *aesstr = [base64String aes256_encrypt:AESKEY];
    NSString *otherstr = [aesstr aes256_decrypt:AESKEY];
    NSString *Aesstr = [NSString stringWithFormat:@"action=%@&data=%@",action,aesstr];
    //NSLog(@"加密后的数据:%@",aesstr);
    //NSLog(@"%@",Aesstr);
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[Aesstr dataUsingEncoding:NSUTF8StringEncoding]];
    //NSLog(@"data:%@",[Aesstr dataUsingEncoding:NSUTF8StringEncoding]);
    //post
    [request setHTTPBody:postBody];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *aesstr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //解密
        NSString *result = [aesstr aes256_decrypt:AESKEY];
        success(result);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
         NSLog(@"error:%@",error);
        failure(error);
    }];
    [operation start];
    
}

@end
