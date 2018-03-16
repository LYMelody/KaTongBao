//
//  NetIntf.m
//  Kuaifu
//
//  Created by ND on 12-12-27.
//  Copyright (c) 2012年 ND. All rights reserved.
//

#import "NetIntf.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "NSObject+SBJSON.h"
#import "NSString+SBJSON.h"
#import "DataDef.h"
#import "PubFunc.h"
//#import "UIBase.h"
#import "BusiIntf.h"
#import "DesUtil.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSString+MD5Addition.h"
#import "NSData+Base64.h"

@interface NetIntf(priv)
{
  
#if ((QDFLAG == 12) || (QDFLAG == 302) || (QDFLAG == 303) || (QDFLAG == 701) || (CHANNEL == 5))
    #define url_base1 @"http://pay3.youngsuns.com:3250"
    #define url_base2 @"http://pay4.youngsuns.com:3250"
#elif (CHANNEL == 3)
    #define url_base1 @"http://pay1.youngsuns.com:3250"
    #define url_base2 @"http://pay2.youngsuns.com:3250"
#elif (QDFLAG == 2) 
    #define url_base1 @"http://pay1.fhtoto.com:3250"
    #define url_base2 @"http://pay2.fhtoto.com:3250"
#elif (QDFLAG == 20)
    #define url_base1 @"http://api.wujieapp.net:3251"
    #define url_base2 @"http://api.wujieapp.net:3251"
#else
    #define url_base1 @"http://pay1.kfupay.com:3250"
    #define url_base2 @"http://pay2.kfupay.com:3250"
#endif
#define url_login @"/login"
#define url_regfirst @"/registFirst"
#define url_regphoto @"/registPhoto"
#define url_regshop @"/registShopInfo"
#define url_regist  @"/regist"
#define url_logout @"/logout"
#define url_systeminfo  @"/systeminfo"
#define url_feedback @"/feedback"
#define url_changepwd   @"/changepwd"
#define url_regcheck @"/regcheck"
#define url_shopinput  @"/shopinput"
#define url_shopcheck  @"/shopcheck"
#define url_usercheck  @"/usercheck"
#define url_userreg @"/userreg"
#define url_orderpaycheck  @"/orderpaycheck"
#define url_ordersearch @"/ordersearch"
#define url_ydddzf  @"/ydddzf"
#define url_ydddzfjlcx  @"/ydddzfjlcx"
#define url_getordercode @"/getordercode"
#define url_checkcardinfo  @"/checkcardinfo"
#define url_checkuserinfo  @"/checkuserinfo"
#define url_payorder  @"/payorder"
#define url_payordersecond  @"/payordersecond"
#define url_querypay    @"/querypay"
#define url_querypaybyid     @"/querypaybyid"
#define url_xykhz     @"/xykhz"
#define url_qxordersearch     @"/qxordersearch"
#define url_xyktx     @"/xyktx"
#define url_delxyktx     @"/delxyktx"
#define url_getxyktxstate     @"/getxyktxstate"
#define url_setxyktxstate     @"/setxyktxstate"
#define url_jjkzz           @"/getorderid"
#define url_jjktj           @"/payorderKL"
#define url_shgl            @"/getbelonglist"
#define url_shmx           @"/getbelongdetail"
#define url_shopurl         @"/getShopUrl"
}

@end

@implementation NetIntf

static NSString* url_base = url_base1;
static NSString* shopid_login = @"";
static NSString* encry_key1 = @"ydzfkey1";// 79647A666B65731
static NSString* encry_key2 = @"ydzfkey2";// 79647A666B65732

+ (NSString *)hexadecimalString:(NSData*)data {
    /* Returns hexadecimal string of NSData. Empty string if data is empty.   */
    
    const unsigned char *dataBuffer = (const unsigned char *)[data bytes];
    
    if (!dataBuffer)
        return [NSString string];
    
    NSUInteger          dataLength  = [data length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i)
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    
    return [NSString stringWithString:hexString];
}




 #define RSA_KEY_BASE64 @"MIICfjCCAeegAwIBAgIBATANBgkqhkiG9w0BAQUFADBxMQswCQYDVQQGEwJDTjER\
 MA8GA1UECBMIU09GVFdBUkUxDzANBgNVBAcTBkZVWkhPVTELMAkGA1UEChMCTkQx\
 CzAJBgNVBAsTAllSMQwwCgYDVQQDEwNNaXIxFjAUBgkqhkiG9w0BCQEWBzFAMi5j\
 b20wHhcNMTIwMjAyMDIwNTM5WhcNMTMwMjAxMDIwNTM5WjBgMQswCQYDVQQGEwJD\
 TjERMA8GA1UECBMIU09GVFdBUkUxCzAJBgNVBAoTAk5EMQswCQYDVQQLEwJZUjEM\
 MAoGA1UEAxMDTWlyMRYwFAYJKoZIhvcNAQkBFgcxQDIuY29tMFwwDQYJKoZIhvcN\
 AQEBBQADSwAwSAJBALLcKmozjJETHLuTEHPhR7aSSG5e0q7rMN4rS2xHA6fGn2D5\
 KsZKFRk12BRYrLZH5icQzX4S+615taZIGvoHX+kCAwEAAaN7MHkwCQYDVR0TBAIw\
 ADAsBglghkgBhvhCAQ0EHxYdT3BlblNTTCBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUw\
 HQYDVR0OBBYEFD/2+FxfOpwcSnEOaL6rRY9fQuYvMB8GA1UdIwQYMBaAFIXbaARO\
 zgtT+Mur0SeHrtebESD3MA0GCSqGSIb3DQEBBQUAA4GBAMyHuNTiQZa1AzWooZyR\
 l8D/AE0TTZyfi1mxSs+/6HTtCLtxPnUcDrgMZE7Y6Pz6wkBQ2FMnFfyjHY1DHf6F\
 4dqGldnglVCBLs8oUlbA7zcHWtrXn09S2m+rwMOB5Pl0x/5WAY6EwZAKvqEg+UDS\
 YARxM2r9PSgPno5tcym9pGlR"
 

SecKeyRef _public_key=nil;
+ (SecKeyRef) getPublicKey: (NSString*) rsaKeyBase64{ // 从公钥证书文件中获取到公钥的SecKeyRef指针
	if(_public_key == nil){
		//NSData *certificateData = [Base64 decodeBase64:RSA_KEY_BASE64];
		//NSString *stringValue = RSA_KEY_BASE64;/*the UTF8 string parsed from xml data*/
		//NSData *data = [stringValue dataUsingEncoding:NSUTF8StringEncoding];
		//NSString *encodingStr = [data base64Encoding];
		NSData *certificateData = [NSData dataWithBase64EncodedString:rsaKeyBase64];
		
		SecCertificateRef myCertificate =  SecCertificateCreateWithData(kCFAllocatorDefault, (CFDataRef)certificateData);
		SecPolicyRef myPolicy = SecPolicyCreateBasicX509();
		SecTrustRef myTrust;
		OSStatus status = SecTrustCreateWithCertificates(myCertificate,myPolicy,&myTrust);
		SecTrustResultType trustResult;
		if (status == noErr) {
			status = SecTrustEvaluate(myTrust, &trustResult);
		}
		_public_key = SecTrustCopyPublicKey(myTrust);
		CFRelease(myCertificate);
		CFRelease(myPolicy);
		CFRelease(myTrust);
	}
	return _public_key;
}

+ (NSString*) rsaEncryptString: (NSString*) rsaKeyBase64 :(NSString*) string
{
	SecKeyRef key = [NetIntf getPublicKey: rsaKeyBase64];
	size_t cipherBufferSize = SecKeyGetBlockSize(key);
	uint8_t *cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
	NSData *stringBytes = [string dataUsingEncoding:NSUTF8StringEncoding];
	size_t blockSize = cipherBufferSize - 11;
	size_t blockCount = (size_t)ceil([stringBytes length] / (double)blockSize);
	NSMutableData *encryptedData = [[[NSMutableData alloc] init] autorelease];
	for (int i=0; i<blockCount; i++) {
		int bufferSize = MIN(blockSize,[stringBytes length] - i * blockSize);
		NSData *buffer = [stringBytes subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
		OSStatus status = SecKeyEncrypt(key, kSecPaddingPKCS1, (const uint8_t *)[buffer bytes],
										[buffer length], cipherBuffer, &cipherBufferSize);
		if (status == noErr){
			NSData *encryptedBytes = [[NSData alloc] initWithBytes:(const void *)cipherBuffer length:cipherBufferSize];
			[encryptedData appendData:encryptedBytes];
			[encryptedBytes release];
		}else{
			if (cipherBuffer) free(cipherBuffer);
			return nil;
		}
	}
	if (cipherBuffer) free(cipherBuffer);
	//  NSLog(@"Encrypted text (%d bytes): %@", [encryptedData length], [encryptedData description]);
	//  NSLog(@"Encrypted text base64: %@", [Base64 encode:encryptedData]);
	
    NSString *newStr = [encryptedData base64Encoding];
	return newStr;
}

uint8_t int8OfHexChar(NSString* str){
    switch([str characterAtIndex:0]){
        case '0':{
            return 0;
        }
        case '1':{
            return 1;
        }
        case '2':{
            return 2;
        }
        case '3':{
            return 3;
        }
        case '4':{
            return 4;
        }
        case '5':{
            return 5;
        }
        case '6':{
            return 6;
        }
        case '7':{
            return 7;
        }
        case '8':{
            
            return 8;
        }
        case '9':{
            return 9;
        }
        case 'A':{
            return 10;
        }
        case 'a':{
            return 10;
        }
        case 'B':{
            return 11;
        }
        case 'b':{
            return 11;
        }
        case 'C':{
            return 12;
        }
        case 'c':{
            return 12;
        }
        case 'D':{
            return 13;
        }
        case 'd':{
            return 13;
        }
        case 'E':{
            
            return 14;
        }
        case 'e':{
            return 14;
        }
        case 'F':{
            return 15;
        }
        case 'f':{
            return 15;
        }
        default:{
            return 0;
        }
    }
}

/*
 DES 加密
 */
+(NSString *) encryptDESForString:(NSString *)strSrc
                    withKeyString:(NSString *)strKey{

    NSData *dataSrc = [strSrc dataUsingEncoding:NSUTF8StringEncoding];
    Byte* pch = (Byte*)[dataSrc bytes];
    
    NSUInteger dataLength = [dataSrc length];
    NSData *iv = [strKey dataUsingEncoding:NSUTF8StringEncoding];
    
    int buflen = 1024*50;
    unsigned char buffer[buflen];
    memset(buffer, 0, sizeof(char)*buflen);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES, 
                                          kCCOptionPKCS7Padding,//kCCOptionPKCS7Padding,// kCCOptionECBMode,//|kCCModeCBC,// _CCOptions,
                                          [strKey UTF8String],
                                          kCCKeySizeDES,
                                          [iv bytes],
                                          pch,//[strSrc UTF8String],
                                          
                                          dataLength,
                                          buffer,
                                          buflen,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *dataTemp = [NSData dataWithBytes:buffer 
                                          length:(NSUInteger)numBytesEncrypted];
        NSString* newStr = [NetIntf hexadecimalString:dataTemp];
        //[NSString stringWithUTF8String:[dataTemp bytes]];
        //NSString* newStr = [[[NSString alloc] initWithData:dataTemp
        //                                          encoding:NSUTF8StringEncoding] autorelease];
        NSLog(@"DES result:[%@]", newStr);
        return newStr;
        
    }else{
        NSLog(@"DES加密失败");
        return @""
        ;
    }
}


/*
 DES 解密
 */
+(NSString *) decryptDESForString:(NSString *)strSrc
                    withKeyString:(NSString *)strKey{
    
    if([strSrc length]%2 != 0){
        return @"";
    }
    
    Byte* dataByteSrc = (Byte*)malloc(sizeof(Byte)*[strSrc length]/2);
    
    for(NSUInteger i=0; i<[strSrc length];){
        NSString* s1 = [strSrc substringWithRange:NSMakeRange(i,1)];
        NSString* s2 = [strSrc substringWithRange:NSMakeRange(i+1,1)];
        Byte b1 = int8OfHexChar(s1)<<4;
        Byte b2 = int8OfHexChar(s2);
        Byte b = b1 + b2;
        dataByteSrc[i/2] = b;
        i=i+2;
    }
    
    Byte* pch = dataByteSrc;//(Byte*)[dataByteSrc bytes];
    
    NSUInteger dataLength = [strSrc length]/2;//[dataByteSrc length];
    
    NSData *iv = [strKey dataUsingEncoding:NSUTF8StringEncoding];
    
    int buflen = 1024*50;
    unsigned char buffer[buflen];
    memset(buffer, 0, sizeof(char)*buflen);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,//kCCOptionPKCS7Padding,// kCCOptionECBMode,//|kCCModeCBC,// _CCOptions,
                                          [strKey UTF8String],
                                          kCCKeySizeDES,
                                          [iv bytes],
                                          pch,//[strSrc UTF8String],
                                          dataLength,
                                          buffer,
                                          buflen,
                                          &numBytesEncrypted);
    
    free(dataByteSrc);
    
    if (cryptStatus == kCCSuccess) {
        NSData *dataTemp = [NSData dataWithBytes:buffer
                                          length:(NSUInteger)numBytesEncrypted];
        
        NSString* str = [[NSString alloc]initWithData:dataTemp encoding:NSUTF8StringEncoding];
        return [str autorelease];
        
    }else{
        NSLog(@"DES解密失败");
        
        return @"";
    }
}

+(NSString *) parseHexForNSData: (NSData*)data{
    const Byte* ob = (Byte*)[data bytes];
    NSUInteger nb = [data length];
    NSMutableString* str = [[[NSMutableString alloc]init] autorelease];
    for(NSUInteger i=0;i<nb;i++){
        Byte b = ob[i];
        [str appendFormat:@"%02X",(uint16_t)((uint8_t)b)];
    }
    return [NSString stringWithFormat:@"%@", str];
}

+ (NSString*)encryJson:(NSString*)json
{
//    NSLog(@"%@", [NetIntf encryptDESForString:@"12345678" withKeyString:@"reg91com"]);
//    NSLog(@"%@", [NetIntf encryptDESForString:@"aaa" withKeyString:@"reg91com"]);
//    NSLog(@"%@", [NetIntf encryptDESForString:@"bbb" withKeyString:@"reg91com"]);
//    NSLog(@"%@", [NetIntf encryptDESForString:@"ccc" withKeyString:@"reg91com"]);
//    NSLog(@"%@", [NetIntf encryptDESForString:@"$&*" withKeyString:@"reg91com"]);
//    NSLog(@"%@", [NetIntf encryptDESForString:@"测试" withKeyString:@"reg91com"]);
//    NSLog(@"%@", [NetIntf encryptDESForString:@"测试$aa&bb*cc" withKeyString:@"reg91com"]);
    NSString* encrystr = [NetIntf encryptDESForString:json withKeyString:encry_key1];
    //NSString* decrystr = [NetIntf decryptDESForString:encrystr withKeyString:encry_key1];
    NSLog(@"decrystr=[%@]", encrystr);
    return encrystr;
    //return [DesUtil TripleDES:json encryptOrDecrypt:kCCEncrypt deskey:encry_key1];
}

+ (NSString*)getMd5:(NSString*)filename
{
    NSString *newPath=[NSString stringWithFormat:@"%@%@%@",[[NSBundle mainBundle]resourcePath],@"/",filename];
    
    NSLog(@"url=%@",newPath);
        
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:newPath];
    if( handle== nil ) {
        return nil;
    }
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength: 256 ];
        CC_MD5_Update(&md5, [fileData bytes], [fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    NSLog(@"MD5:%@", s);
    
    return s;
}

+ (NSString*)getM1:(NSString*)icon logo:(NSString*)logo contact:(NSString*)contact
{    
    NSString* plainStr = @"";
    plainStr = [plainStr stringByAppendingString:[NetIntf getMd5:icon]];
    plainStr = [plainStr stringByAppendingString:[NetIntf getMd5:logo]];
    plainStr = [plainStr stringByAppendingString:[contact stringFromMD5]];
    NSLog(@"M1=[%@]", plainStr);
    return plainStr;
}

+ (NSString*)getIconEncry:(NSString*)icon devid:(NSString*)devid key:(NSString*)key
{
#define bg_logo    QUDAO@"_logo.png"
    NSString* plainStr = @"";
    NSString* M1 = [NetIntf getM1:icon logo:bg_logo contact:[BusiIntf readConfigString:@"verright"]];
        
    NSDate *today = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMdd"];
    NSString* dateString = [df stringFromDate:today];
    [df release];
    
    plainStr = [plainStr stringByAppendingString:@"08"];
    plainStr = [plainStr stringByAppendingString:dateString];
    plainStr = [plainStr stringByAppendingString:devid];
    plainStr = [plainStr stringByAppendingString:M1];
    
    NSString* encrystr = [NetIntf encryptDESForString:plainStr withKeyString:key];
    return encrystr;//[DesUtil TripleDES:plainStr encryptOrDecrypt:kCCEncrypt deskey:key];

}

+ (NSString*)makeVerifyStr:(NSInteger)len
{
    NSString* guid = gen_uuid();
    guid = [guid stringByReplacingOccurrencesOfString: @"-" withString:@""];
    int n = len / guid.length + 1;
    for (int i=1; i<n; i++) {
        guid = [guid stringByAppendingString:
                [gen_uuid() stringByReplacingOccurrencesOfString: @"-" withString:@""]
                ];
    }
    return [guid substringToIndex:len-1];
}

+ (NSInteger) readPostData: (NSString*) urlstr json: (NSString*) jsonRequest result: (NSString**)result
{
    NSString* fullurlstr = @"";
    if (![BusiIntf getUserInfo].IsError)
        fullurlstr = [urlstr stringByAppendingString:url_param];
    else
        fullurlstr = [urlstr stringByAppendingString:url_param_error];
    
    //安全加密1
    NSString* v2 = [NetIntf getIconEncry:@"Icon.png" devid:deviceID() key:encry_key2];
    NSString* v1 = [NetIntf makeVerifyStr:[v2 length]];
    NSString* v3 = [NetIntf makeVerifyStr:[v2 length]];
    fullurlstr = [fullurlstr stringByAppendingFormat:@"&devid=%@&v1=%@&v2=%@&v3=%@",
                  deviceID(),
                  v1,
                  v2,
                  v3
                  ];    
    //
	NSURL *url = [NSURL URLWithString:fullurlstr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	
	NSMutableData *requestData = [NSMutableData data];
    
    NSMutableString* fulljson = [NSMutableString stringWithString:jsonRequest];
    if (![shopid_login isEqualToString:@""])
    {
        if ([fulljson indexOf:@"\"shopid\":"]<0)
        {
            NSString *inserted = [NSString stringWithFormat:@"\"shopid\":\"%@\",", shopid_login];
            [fulljson insertString:inserted atIndex:1];
        }
    }
    //安全加密2
    NSString* encry_fulljson = fulljson;
    if ([urlstr indexOf:url_regphoto]<0)
        encry_fulljson = [NetIntf encryJson:fulljson];
    //[NetIntf rsaEncryptString: @"6ss" : fulljson];
  
    [requestData appendData:[[NSString stringWithString:encry_fulljson]
							 dataUsingEncoding:NSUTF8StringEncoding]];
	
	[request setAllowCompressedResponse:NO];
	ASIHTTPRequest.shouldUpdateNetworkActivityIndicator = YES;
	
	[request appendPostData:requestData];
	[request buildPostBody];
	[request setTimeOutSeconds:90];
	
	NSLog(@"url: %@ post: %@ encry_data[%@]", fullurlstr, fulljson, encry_fulljson);
//    if (active_view)
//        [active_view addWait:@""];
//	[request startSynchronous];
//    if (active_view)
//        [active_view stopWait];
	
	NSError *error = [request error];
	
	NSInteger responseStatusCode = request.responseStatusCode;
    *result = @"";
    int code = responseStatusCode;
    
	if (!error) {
        *result = [request responseString];
        *result = [NetIntf decryptDESForString:*result withKeyString:encry_key1];
		if (code == 200)
		{
            NSDictionary *nodes = [*result JSONValue];
            if (nodes)
            {
                id tempvalue = [nodes objectForKey:@"result"];
                if (tempvalue)
                    code = [tempvalue intValue];
                else
                    code = 299;
            }
            else{
                code = 299;
            }
			NSLog(@"[%d]%@\n%@", code, [request responseString], *result);
        }
        else
        {
            NSLog(@"status code: %d, msg: %@", responseStatusCode, *result);
        }
    }
    else
    {
        NSLog(@"sendRequest get error:(%d)%@", error.code, error);
        code = error.code;
    }
    
	return code;
}


+ (void)getErrmsg: (NSInteger)code resp:(NSString*)resp errmsg:(NSString**)errmsg
{
    *errmsg = @"";
    
    NSDictionary *nodes = [resp JSONValue];
    if (nodes != nil)
    {
        *errmsg = [nodes objectForKey:@"resultmsg"];
    }
    
    if (code == 200)
        return;
}

+ (NSInteger) login:(NSString*)urlroot username:(NSString*)username pwd:(NSString*)pwd shopid:(NSString**)shopid  mobile:(NSString**)mobile state:(NSString**)state shopcode:(NSString**)shopcode shopname:(NSString**)shopname errmsg:(NSString**)errmsg
{
#ifdef try_net
    *shopid = @"11";
    *mobile = @"12";
    *state = @"10A";
    *shopcode = @"11";
    *shopname = @"12";
    shopid_login = [*shopid copy];
    return 200;
#endif
    url_base = urlroot;
    NSString *ver = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSString* url = [NSString stringWithFormat:@"%@%@", urlroot, url_login];
    NSString* devid = deviceID();
    NSString* json = [NSString stringWithFormat:@"{\"username\":\"%@\", \"userpwd\":\"%@\", \"ostype\":\"%@\", \"softtype\":\"%@\", \"ver\":\"%@\", \"devid\":\"%@\"}",
                      username, pwd, @"iphone", @"易付", ver, devid];
    NSString* result;
    int code = [self readPostData: url json :json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        *shopid = nil;
        *mobile = nil;
        *state = nil;
        if (nodes != nil)
        {
            *shopid = [nodes objectForKey:@"shopid"];
            *mobile = [nodes objectForKey:@"regphone"];
            *state = [nodes objectForKey:@"state"];
            *shopcode = [nodes objectForKey:@"shopcode"];
            *shopname = [nodes objectForKey:@"shortname"];
            
            shopid_login = [*shopid copy];
        }
        else
        {
            code = 299;
            *errmsg = @"解析结果失败";
            return code;
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}

+ (NSInteger) login:(NSString*)urlroot username:(NSString*)username pwd:(NSString*)pwd shopid:(NSString**)shopid  mobile:(NSString**)mobile state:(NSString**)state shopcode:(NSString**)shopcode shopname:(NSString**)shopname type: (NSString **) type errmsg:(NSString**)errmsg
{
#ifdef try_net
    *shopid = @"11";
    *mobile = @"12";
    *state = @"10A";
    *shopcode = @"11";
    *shopname = @"12";
    shopid_login = [*shopid copy];
    return 200;
#endif
    url_base = urlroot;
    NSString *ver = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSString* url = [NSString stringWithFormat:@"%@%@", urlroot, url_login];
    NSString* devid = deviceID();
    NSString* json = [NSString stringWithFormat:@"{\"username\":\"%@\", \"userpwd\":\"%@\", \"ostype\":\"%@\", \"softtype\":\"%@\", \"ver\":\"%@\", \"devid\":\"%@\"}",
                      username, pwd, @"iphone", @"易付", ver, devid];
    NSString* result;
    int code = [self readPostData: url json :json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        *shopid = nil;
        *mobile = nil;
        *state = nil;
        if (nodes != nil)
        {
            *shopid = [nodes objectForKey:@"shopid"];
            *mobile = [nodes objectForKey:@"regphone"];
            *state = [nodes objectForKey:@"state"];
            *shopcode = [nodes objectForKey:@"shopcode"];
            *shopname = [nodes objectForKey:@"shortname"];
            *type = [nodes objectForKey:@"type"];
            
            shopid_login = [*shopid copy];
        }
        else
        {
            code = 299;
            *errmsg = @"解析结果失败";
            return code;
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}
//updateflag
+ (NSInteger) login:(NSString*)urlroot username:(NSString*)username pwd:(NSString*)pwd shopid:(NSString**)shopid  mobile:(NSString**)mobile state:(NSString**)state shopcode:(NSString**)shopcode shopname:(NSString**)shopname type: (NSString **) type updateflag:(NSString **)updateflag errmsg:(NSString**)errmsg
{
#ifdef try_net
    *shopid = @"11";
    *mobile = @"12";
    *state = @"10A";
    *shopcode = @"11";
    *shopname = @"12";
    shopid_login = [*shopid copy];
    return 200;
#endif
    url_base = urlroot;
    NSString *ver = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSString* url = [NSString stringWithFormat:@"%@%@", urlroot, url_login];
    NSString* devid = deviceID();
    NSString* json = [NSString stringWithFormat:@"{\"username\":\"%@\", \"userpwd\":\"%@\", \"ostype\":\"%@\", \"softtype\":\"%@\", \"ver\":\"%@\", \"devid\":\"%@\"}",
                      username, pwd, @"iphone", @"易付", ver, devid];
    NSString* result;

    //test
    /*
    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"error" message:@"1" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alert show];
    */
    
    int code = [self readPostData: url json :json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        *shopid = nil;
        *mobile = nil;
        *state = nil;
        if (nodes != nil)
        {
            *shopid = [nodes objectForKey:@"shopid"];
            *mobile = [nodes objectForKey:@"regphone"];
            *state = [nodes objectForKey:@"state"];
            *shopcode = [nodes objectForKey:@"shopcode"];
            *shopname = [nodes objectForKey:@"shortname"];
            *type = [nodes objectForKey:@"type"];
            
            *updateflag = [nodes objectForKey:@"updateFlag"];
            
            shopid_login = [*shopid copy];
        }
        else
        {
            code = 299;
            *errmsg = @"解析结果失败";
            return code;
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}

+ (NSInteger) login:(NSString*)username pwd:(NSString*)pwd shopid:(NSString**)shopid mobile:(NSString**)mobile state:(NSString**)state shopcode:(NSString**)shopcode shopname:(NSString**)shopname errmsg:(NSString**)errmsg
{
    int code;
    code = [NetIntf login:url_base1 username: username pwd:pwd shopid:shopid mobile:mobile state:state shopcode:shopcode shopname:shopname errmsg:errmsg];
    if ((code == 1) || (code == 2) || (code == 502)) //The operation couldn’t be completed. Network is unreachable or timeout
    {
        code = [NetIntf login:url_base2 username: username pwd:pwd shopid:shopid mobile:mobile state:state shopcode:shopcode shopname:shopname errmsg:errmsg];
    }
    return code;
}

+ (NSInteger) login:(NSString*)username pwd:(NSString*)pwd shopid:(NSString**)shopid mobile:(NSString**)mobile state:(NSString**)state shopcode:(NSString**)shopcode shopname:(NSString**)shopname type: (NSString **) type errmsg:(NSString**)errmsg
{
    int code;
    code = [NetIntf login:url_base1 username: username pwd:pwd shopid:shopid mobile:mobile state:state shopcode:shopcode shopname:shopname type:type errmsg:errmsg];
    if ((code == 1) || (code == 2) || (code == 502)) //The operation couldn’t be completed. Network is unreachable or timeout
    {
        code = [NetIntf login:url_base2 username: username pwd:pwd shopid:shopid mobile:mobile state:state shopcode:shopcode shopname:shopname type:type errmsg:errmsg];
    }
    return code;
}
//updateflag
+ (NSInteger) login:(NSString*)username pwd:(NSString*)pwd shopid:(NSString**)shopid mobile:(NSString**)mobile state:(NSString**)state shopcode:(NSString**)shopcode shopname:(NSString**)shopname type: (NSString **) type updateflag:(NSString **) updateflag errmsg:(NSString**)errmsg
{
    int code;
    code = [NetIntf login:url_base1 username: username pwd:pwd shopid:shopid mobile:mobile state:state shopcode:shopcode shopname:shopname type:type updateflag:updateflag errmsg:errmsg];
    if ((code == 1) || (code == 2) || (code == 502)) //The operation couldn’t be completed. Network is unreachable or timeout
    {
        code = [NetIntf login:url_base2 username: username pwd:pwd shopid:shopid mobile:mobile state:state shopcode:shopcode shopname:shopname type:type updateflag:updateflag errmsg:errmsg];
    }
    return code;
}


+ (NSInteger) systeminfo:(NSString*)shopid msgContent:(NSString**)msgContent errmsg:(NSString**)errmsg
{
#ifdef try_net
    *msgContent = @"ssss";
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_systeminfo];
    NSString* json = [NSString stringWithFormat:@"{\"shopid\":\"%@\"}", shopid];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        *msgContent = nil;
        if (nodes != nil)
        {
            *msgContent = [nodes objectForKey:@"msgContent"];
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
    
}

+ (NSInteger) systeminfo:(NSString*)shopid type: (NSString *)type msgContent:(NSString**)msgContent errmsg:(NSString**)errmsg
{
#ifdef try_net
    *msgContent = @"ssss";
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_systeminfo];
    //NSString* json = [NSString stringWithFormat:@"{\"shopid\":\"%@\, \"type\":\"%@\"}", shopid, type];
    NSString* json = [NSString stringWithFormat:@"{\"shopid\":\"%@\", \"type\":\"%@\"}", shopid, type];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        *msgContent = nil;
        if (nodes != nil)
        {
            *msgContent = [nodes objectForKey:@"msgContent"];
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
    
}


+ (NSInteger) feedback:(NSString*)shopid feedbackinfo:(NSString*)feedbackinfo errmsg:(NSString**)errmsg
{
    
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_feedback];
    NSString* json = [NSString stringWithFormat:@"{\"shopid\":\"%@\", \"feedbackinfo\":\"%@\"}", shopid, feedbackinfo];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;

}
+ (NSInteger) changepwd:(NSString*)shopid oldpwd:(NSString*)oldpwd userpwd:(NSString*)userpwd errmsg:(NSString**)errmsg
{
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_changepwd];
    NSString* json = [NSString stringWithFormat:@"{\"shopid\":\"%@\",\"oldpwd\":\"%@\",\"userpwd\":\"%@\"}", shopid, oldpwd, userpwd];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];

    return code;
    
}

+ (NSInteger) regfirst: (NSString*)regphone username:(NSString*)username userpwd:(NSString*)userpwd shopnbr:(NSString*)shopnbr shopid:(NSString**)shopid errmsg:(NSString**)errmsg
{
    
#ifdef try_net
    *shopid = @"1";
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_regfirst];
    NSString* json = [NSString stringWithFormat:@"{\"regphone\":\"%@\", \"username\":\"%@\", \"userpwd\":\"%@\", \"shopnbr\":\"%@\"}", regphone, username, userpwd, shopnbr];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        *shopid = nil;
        if (nodes != nil)
        {
            *shopid = [nodes objectForKey:@"shopid"];
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
    
}

+ (NSInteger) regcheck: (NSString*)mobile checkcode:(NSString**)checkcode errmsg:(NSString**)errmsg
{
#ifdef try_net
    *checkcode = @"1";
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_regcheck];
    NSString* json = [NSString stringWithFormat:@"{\"phone\":\"%@\"}", mobile];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        *checkcode = nil;
        if (nodes != nil)
        {
            *checkcode = [nodes objectForKey:@"checkcode"];
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}

+ (NSInteger) shopinput: (NSString*)mobile username:(NSString*)username pwd:(NSString*)pwd errmsg:(NSString**)errmsg
{
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_shopinput];
    NSString* json = [NSString stringWithFormat:@"{\"phone\":\"%@\",\"username\":\"%@\",\"pwd\":\"%@\"}",
                      mobile, username, pwd];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
       
    return code;

    
}

+ (NSInteger) shopcheck: (NSString*)phone photo1:(NSString*)photo1 photo2:(NSString*)photo2 photo3:(NSString*)photo3
               shopname:(NSString*)shopname shopbank:(NSString*)shopbank accountnbr:(NSString*)accountnbr errmsg:(NSString**)errmsg
{    
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_shopcheck];
    NSString* json = [NSString stringWithFormat:
                      @"{\"phone\":\"%@\",\"photo1\":\"%@\",\"photo2\":\"%@\",\"photo3\":\"%@\",\
                      \"shopname\":\"%@\",\"shopbank\":\"%@\",\"accountnbr\":\"%@\"}",
                      phone, photo1, photo2, photo3, shopname, shopbank, accountnbr];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
  
}

+ (NSInteger) regphoto: (NSString*)shopid photo1:(NSString*)photo1 photo2:(NSString*)photo2 photo3:(NSString*)photo3 photo4:(NSString*)photo4 errmsg:(NSString**)errmsg
{
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_regphoto];
    NSString* json = [NSString stringWithFormat:
                      @"{\"shopid\":\"%@\",\"photo1\":\"%@\",\"photo2\":\"%@\",\"photo3\":\"%@\",\
                      \"photo4\":\"%@\"}",
                      shopid, photo1, photo2, photo3, photo4];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;    
}

+ (NSInteger) regphoto: (NSString*)shopid photo1:(NSString*)photo1 photo2:(NSString*)photo2 photo3:(NSString*)photo3 photo4:(NSString*)photo4 photo5:(NSString*)photo5 photo6:(NSString*)photo6 errmsg:(NSString**)errmsg
{
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_regphoto];
    NSString* json = [NSString stringWithFormat:
                      @"{\"shopid\":\"%@\",\"photo1\":\"%@\",\"photo2\":\"%@\",\"photo3\":\"%@\",\
                      \"photo4\":\"%@\",\"photo5\":\"%@\",\"photo6\":\"%@\"}",
                      shopid, photo1, photo2, photo3, photo4, photo5, photo6];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}


+ (NSInteger) regshop: (NSString*)shopid shopname:(NSString*)shopname shopbank:(NSString*)shopbank accountnbr:(NSString*)accountnbr accountname:(NSString*)accountname shopkey:(NSString*)shopkey errmsg:(NSString**)errmsg
{
    
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_regshop];
    NSString* json = [NSString stringWithFormat:
                      @"{\"shopid\":\"%@\",\"showname\":\"%@\",\"shopbank\":\"%@\",\"accountnbr\":\"%@\",\
                      \"accountname\":\"%@\",\
                      \"shopkey\":\"%@\"}",
                      shopid, shopname, shopbank, accountnbr, accountname, shopkey];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}

+ (NSInteger) regist: (NSString*)shopid errmsg:(NSString**)errmsg
{
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_regist];
    NSString* json = [NSString stringWithFormat:
                      @"{\"shopid\":\"%@\"}",
                      shopid];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}

+ (NSInteger) logout: (NSString*)shopid errmsg:(NSString**)errmsg
{    
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_logout];
    NSString* json = [NSString stringWithFormat:
                      @"{\"shopid\":\"%@\"}",
                      shopid];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}

+ (NSInteger) usercheck: (NSString*)charnbr errmsg:(NSString**)errmsg
{
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_usercheck];
    NSString* json = [NSString stringWithFormat:
                      @"{\"charnbr\":\"%@\"}",
                      charnbr];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
    
}

+ (NSInteger) userreg: (NSString*)cardnbr cardtype:(NSString*)cardtype cardbank:(NSString*)cardbank
             username:(NSString*)username usernbr:(NSString*)usernbr userphone:(NSString*)userphone errmsg:(NSString**)errmsg
{    
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_userreg];
    NSString* json = [NSString stringWithFormat:
                      @"{\"cardnbr\":\"%@\",\"cardtype\":\"%@\",\"cardbank\":\"%@\",\"username\":\"%@\",\
                      \"usernbr\":\"%@\",\"userphone\":\"%@\"}",
                      cardnbr, cardtype, cardbank, username, usernbr, userphone];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}

+ (NSInteger) ordersearch: (NSString*)shopid state:(NSString*)state dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg
{
    [dataArray removeAllObjects];
#ifdef try_net
    
    [dataArray removeAllObjects];
    if ([state isEqualToString:@""])
    {
        for (int i=0; i<10; i++) {
            OrderInfo* order = [[[OrderInfo alloc]init] autorelease];
            order.OrderName = [NSString stringWithFormat:@"All %d", i];
            order.OrderTime = @"2012-12-05 10:30:02";
            order.OrderStatus = 1;
            [dataArray addObject:order];
        }
    }
    if ([state isEqualToString:@"10A"])
    {
        for (int i=0; i<3; i++) {
            OrderInfo* order = [[[OrderInfo alloc]init] autorelease];
            order.OrderName = [NSString stringWithFormat:@"Had %d", i];
            order.OrderStatus = 1;
            [dataArray addObject:order];
        }
    }
    if ([state isEqualToString:@"10F"])
    {
        for (int i=0; i<5; i++) {
            OrderInfo* order = [[[OrderInfo alloc]init] autorelease];
            order.OrderName = [NSString stringWithFormat:@"Not %d", i];
            order.OrderStatus = 2;
            [dataArray addObject:order];
        }
    }
    return 200;
    
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_ordersearch];
    NSString* json = [NSString stringWithFormat:@"{\"shopid\":\"%@\", \"state\":\"%@\"}",
                      shopid, state];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        if (nodes != nil)
        {
            NSArray *data = [nodes objectForKey:@"data"];
            if (data && (data.count>0))
            {
                for (int i=0; i<[data count]; i++)
                { 
                    OrderInfo *info = [[[OrderInfo alloc]init]autorelease];
                    NSDictionary *infonodes = [data objectAtIndex:i];
                    info.OrderName = [infonodes objectForKey: @"goodsname"];
                    info.OrderTime = [infonodes objectForKey: @"statedate"];
                    info.OrderAmt = [[infonodes objectForKey: @"amount"] floatValue];
                    info.OrderFee = [[infonodes objectForKey: @"otheramount"] floatValue];
                    info.OrderDesc = [infonodes objectForKey: @"orderdesc"];
                    info.OrderStatusName = [infonodes objectForKey: @"statename"];
                    info.OrderCode = [infonodes objectForKey: @"ordercode"];
                    info.State = [infonodes objectForKey: @"state"];
                    
                    info.OrderAmtAll = info.OrderAmt + info.OrderFee;
                    [dataArray addObject:info];                    
                }
            }
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
    
}

+ (NSInteger) ydddzf: (NSString*)username begindt:(NSString*)begindt enddt:(NSString*)enddt errmsg:(NSString**)errmsg
{
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_ydddzf];
    NSString* json = [NSString stringWithFormat:
                      @"{\"username\":\"%@\",\"begindt\":\"%@\",\"enddt\":\"%@\" }",
                      username, begindt, enddt];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
    
}

+ (NSInteger) ydddzfjlcx: (NSString*)username begindt:(NSString*)begindt enddt:(NSString*)enddt dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg
{
    [dataArray removeAllObjects];
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_ydddzfjlcx];
    NSString* json = [NSString stringWithFormat:
                      @"{\"username\":\"%@\",\"begindt\":\"%@\",\"enddt\":\"%@\" }",
                      username, begindt, enddt];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        if (nodes != nil)
        {
            NSArray *data = [nodes objectForKey:@"data"];
            if (data.count>0)
            {
                for (int i=0; i<[data count]; i++)
                {
                    OrderInfo *info = [[[OrderInfo alloc]init]autorelease];
                    NSDictionary *infonodes = [data objectAtIndex:i];
                    info.OrderName = [infonodes objectForKey: @"goodsname"];
                    info.OrderTime = [infonodes objectForKey: @"goodstime"];
                    /////
                    ////
                    [dataArray addObject:info];
                }
            }
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
    
}

+ (NSInteger) getordercode: (NSString*)shopid userordercode:(NSString*)userordercode goodsid:(NSString*)goodsid amount:(NSString*)amount orderdesc:(NSString*)orderdesc ordercode:(NSString**)ordercode orderid:(NSString**)orderid errmsg:(NSString**)errmsg
{
    
#ifdef try_net
    *ordercode = @"1";
    *orderid = @"1";
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_getordercode];
    NSString* json = [NSString stringWithFormat:@"{\"shopid\":\"%@\", \"userordercode\":\"%@\", \"goodsid\":\"%@\", \"amount\":\"%@\", \"orderdesc\":\"%@\"}", shopid, userordercode, goodsid, amount, orderdesc];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        *ordercode = nil;
        if (nodes != nil)
        {
            *ordercode = [nodes objectForKey:@"ordercode"];
            *orderid = [nodes objectForKey:@"orderid"];
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;

}

+ (NSInteger) getordercode: (NSString*)shopid userordercode:(NSString*)userordercode goodsid:(NSString*)goodsid amount:(NSString*)amount orderdesc:(NSString*)orderdesc ordercode:(NSString**)ordercode orderid:(NSString**)orderid type:(NSString *) type errmsg:(NSString**)errmsg
{
    
#ifdef try_net
    *ordercode = @"1";
    *orderid = @"1";
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_getordercode];
    NSString* json = [NSString stringWithFormat:@"{\"shopid\":\"%@\", \"userordercode\":\"%@\", \"goodsid\":\"%@\", \"amount\":\"%@\", \"orderdesc\":\"%@\", \"type\":\"%@\"}", shopid, userordercode, goodsid, amount, orderdesc,type];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        *ordercode = nil;
        if (nodes != nil)
        {
            *ordercode = [nodes objectForKey:@"ordercode"];
            *orderid = [nodes objectForKey:@"orderid"];
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
    
}


+ (NSInteger) checkcardinfo: (NSString*)cardnbr userid:(NSString**)userid goodsid:(NSString*)goodsid isreg:(BOOL*)isreg cardbank:(NSString **)cardbank errmsg:(NSString**)errmsg
{
#ifdef try_net
    *isreg = NO;
    *userid = @"1";
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_checkcardinfo];
    NSString* json = [NSString stringWithFormat:@"{\"cardnbr\":\"%@\", \"goodsid\":\"%@\"}", cardnbr, goodsid];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        *userid = nil;
        if (nodes != nil)
        {
            *userid = [nodes objectForKey:@"userid"];
            if ([nodes objectForKey:@"cardbank"] == nil)
            {
                *isreg = NO;
            }
            else{
                *isreg = YES;
            }
            
            *cardbank = [nodes objectForKey:@"cardbank"] ;
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
    
}

+ (NSInteger) checkuserinfo: (NSString**)userid username:(NSString*)username usernbr:(NSString*)usernbr userphone:(NSString*)userphone bankcardno:(NSString*)bankcardno bankcardtype:(NSString*)bankcardtype bankname:(NSString*)bankname bankverify:(NSString*)bankverify bankcvv:(NSString*)bankcvv bankpwd:(NSString*)bankpwd orderid:(NSString*)orderid goodsid:(NSString*)goodsid errmsg:(NSString**)errmsg
{
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_checkuserinfo];
    NSString* json = [NSString stringWithFormat:@"{\"userid\":\"%@\", \"username\":\"%@\", \"usernbr\":\"%@\", \"userphone\":\"%@\", \"cardnbr\":\"%@\", \"cardbank\":\"%@\", \"cardtype\":\"%@\", \"cardyxq\":\"%@\", \"cardpsw\":\"%@\", \"cardcvv\":\"%@\", \"orderid\":\"%@\", \"goodsid\":\"%@\"}", *userid, username, usernbr, userphone, bankcardno, bankname, bankcardtype, bankverify, bankpwd, bankcvv, orderid, goodsid];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        if (nodes != nil)
        {
            if ([nodes objectForKey:@"userid"] != nil)
            {
                *userid = [nodes objectForKey:@"userid"];
            }
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
   
    return code;
}

+ (NSInteger) checkcardinfo: (NSString*)cardnbr userid:(NSString**)userid goodsid:(NSString*)goodsid isreg:(BOOL*)isreg cardbank:(NSString **)cardbank ordercode:(NSString *)ordercode errmsg:(NSString**)errmsg
{
#ifdef try_net
    *isreg = NO;
    *userid = @"1";
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_checkcardinfo];
    NSString* json = [NSString stringWithFormat:@"{\"cardnbr\":\"%@\", \"goodsid\":\"%@\", \"ordercode\":\"%@\"}", cardnbr, goodsid, ordercode];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        *userid = nil;
        if (nodes != nil)
        {
            *userid = [nodes objectForKey:@"userid"];
            if ([nodes objectForKey:@"cardbank"] == nil)
            {
                *isreg = NO;
            }
            else{
                *isreg = YES;
            }
            
            *cardbank = [nodes objectForKey:@"cardbank"] ;
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
    
}

+ (NSInteger) checkuserinfo: (NSString**)userid username:(NSString*)username usernbr:(NSString*)usernbr userphone:(NSString*)userphone bankcardno:(NSString*)bankcardno bankcardtype:(NSString*)bankcardtype bankname:(NSString*)bankname bankverify:(NSString*)bankverify bankcvv:(NSString*)bankcvv bankpwd:(NSString*)bankpwd orderid:(NSString*)orderid goodsid:(NSString*)goodsid ordercode:(NSString *)ordercode errmsg:(NSString**)errmsg
{
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_checkuserinfo];
    NSString* json = [NSString stringWithFormat:@"{\"userid\":\"%@\", \"username\":\"%@\", \"usernbr\":\"%@\", \"userphone\":\"%@\", \"cardnbr\":\"%@\", \"cardbank\":\"%@\", \"cardtype\":\"%@\", \"cardyxq\":\"%@\", \"cardpsw\":\"%@\", \"cardcvv\":\"%@\", \"orderid\":\"%@\", \"goodsid\":\"%@\", \"ordercode\":\"%@\"}", *userid, username, usernbr, userphone, bankcardno, bankname, bankcardtype, bankverify, bankpwd, bankcvv, orderid, goodsid, ordercode];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        if (nodes != nil)
        {
            if ([nodes objectForKey:@"userid"] != nil)
            {
                *userid = [nodes objectForKey:@"userid"];
            }
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}


+ (NSInteger) orderpaycheck: (NSString*)shopid ordercode:(NSString*)ordercode userid:(NSString*)userid goodsid:(NSString*)goodsid amount:(NSString*)amount otheramount:(NSString*)otheramount orderdesc:(NSString*)orderdesc orderid:(NSString**)orderid merchantid:(NSString **)merchantID params: (NSString **)params errmsg:(NSString**)errmsg
{
#ifdef try_net
    *orderid = @"1";
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_orderpaycheck];
    NSString* json = [NSString stringWithFormat:@"{\"shopid\":\"%@\", \"ordercode\":\"%@\", \"userid\":\"%@\", \"goodsid\":\"%@\", \"amount\":\"%@\", \"otheramount\":\"%@\", \"orderid\":\"%@\", \"orderdesc\":\"%@\"}", shopid, ordercode, userid, goodsid, amount, otheramount, *orderid, orderdesc];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        *orderid = nil;
        if (nodes != nil)
        {
            *orderid = [nodes objectForKey:@"orderid"];
            *merchantID = [nodes objectForKey:@"merchantid"];
            *params = [nodes objectForKey:@"params"];
            
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}

+ (NSInteger) orderpaycheck: (NSString*)shopid ordercode:(NSString*)ordercode userid:(NSString*)userid goodsid:(NSString*)goodsid amount:(NSString*)amount otheramount:(NSString*)otheramount orderdesc:(NSString*)orderdesc orderid:(NSString**)orderid merchantid:(NSString **)merchantID params: (NSString **)params url:(NSString **)request_url errmsg:(NSString**)errmsg
{
#ifdef try_net
    *orderid = @"1";
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_orderpaycheck];
    NSString* json = [NSString stringWithFormat:@"{\"shopid\":\"%@\", \"ordercode\":\"%@\", \"userid\":\"%@\", \"goodsid\":\"%@\", \"amount\":\"%@\", \"otheramount\":\"%@\", \"orderid\":\"%@\", \"orderdesc\":\"%@\"}", shopid, ordercode, userid, goodsid, amount, otheramount, *orderid, orderdesc];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        *orderid = nil;
        if (nodes != nil)
        {
            *orderid = [nodes objectForKey:@"ordercode"];
            
            NSLog(@"-----------------%@------------------", *orderid);
            
            if ([nodes objectForKey:@"merchantid"]) {
                 *merchantID = [nodes objectForKey:@"merchantid"];
            }
           
            if ([nodes objectForKey:@"params"]) {
                *params = [nodes objectForKey:@"params"];
            }
            
            NSLog(@"--------catch url+++++++++++++++");
            
            if ([nodes objectForKey:@"url"]) {
                *request_url = [nodes objectForKey:@"url"];
                
                NSLog(@"URL:＋＋＋＋＋＋＋＋＋＋＋＋%@＋＋＋＋＋＋＋＋＋＋＋", *request_url);
            } else {
                
                *request_url = @"normal";
                NSLog(@"URL:＋＋＋＋＋＋＋＋＋＋＋＋%@＋＋＋＋＋＋＋＋＋＋＋", *request_url);
            }
            NSLog(@"--------end url+++++++++++++++");
                       
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}


+ (NSInteger) payorder: (NSString*)orderid sms:(NSString*)sms errmsg:(NSString**)errmsg
{
#ifdef try_net
    *errmsg = @"good .... good!!!!";
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_payorder];
    NSString* json = [NSString stringWithFormat:@"{\"orderid\":\"%@\", \"sms\":\"%@\"}", orderid, sms];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}

+ (NSInteger) payordersecond: (NSString*)orderid sms:(NSString*)sms errmsg:(NSString**)errmsg
{
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_payordersecond];
    NSString* json = [NSString stringWithFormat:@"{\"orderid\":\"%@\", \"sms\":\"%@\"}", orderid, sms];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}

+ (NSInteger) querypay: (NSString*)shopid goodsid:(NSString*)goodsid begindt:(NSString*)begindt enddt:(NSString*)enddt orderdesc:(NSString*)orderdesc dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg
{    
    [dataArray removeAllObjects];
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_querypay];
    NSString* json = [NSString stringWithFormat:
                      @"{\"shopid\":\"%@\",\"goodsid\":\"%@\",\"orderdesc\":\"%@\",\"begindt\":\"%@\",\"enddt\":\"%@\" }",
                      shopid, goodsid, orderdesc, begindt, enddt];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        if (nodes != nil)
        {
            NSArray *data = [nodes objectForKey:@"data"];
            if (data && (data.count>0))
            {
                for (int i=0; i<[data count]; i++)
                {
                    OrderInfo *info = [[[OrderInfo alloc]init]autorelease];
                    NSDictionary *infonodes = [data objectAtIndex:i];
                    info.OrderName = [infonodes objectForKey: @"goodsname"];
                    info.OrderTime = [infonodes objectForKey: @"statedate"];
                    info.OrderAmt = [[infonodes objectForKey: @"amount"] floatValue];
                    info.OrderFee = [[infonodes objectForKey: @"otheramount"] floatValue];
                    info.OrderDesc = [infonodes objectForKey: @"orderdesc"];
                    info.OrderStatusName = [infonodes objectForKey: @"statename"];
                    info.OrderCode = [infonodes objectForKey: @"ordercode"];
                    info.State = [infonodes objectForKey: @"state"];
                    info.GoodsID = [infonodes objectForKey: @"goodsid"];
                    
                    info.OrderAmtAll = info.OrderAmt + info.OrderFee;
                    [dataArray addObject:info];
                }
            }
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}

+ (NSInteger) querypaybyid: (NSString*)ordercode goodsid:(NSString*)goodsid dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg
{
    
    [dataArray removeAllObjects];
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_querypaybyid];
    NSString* json = [NSString stringWithFormat:
                      @"{\"ordercode\":\"%@\",\"goodsid\":\"%@\"}",
                      ordercode, goodsid];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    
    if (code == 200)
    {
        NSDictionary *data = [result JSONValue];
        if (data != nil)
        {
            for (int i=0; i<[data count]; i++)
            {
                OrderInfo *info = [[[OrderInfo alloc]init]autorelease];
                NSDictionary *infonodes = data;
                info.OrderID = [infonodes objectForKey: @"orderid"];
                info.OrderName = [infonodes objectForKey: @"goodsname"];
                info.OrderTime = [infonodes objectForKey: @"statedate"];
                info.OrderAmt = [[infonodes objectForKey: @"amount"] floatValue];
                info.OrderFee = [[infonodes objectForKey: @"otheramount"] floatValue];
                info.OrderDesc = [infonodes objectForKey: @"orderdesc"];
                info.OrderStatusName = [infonodes objectForKey: @"statename"];
                info.OrderCode = [infonodes objectForKey: @"ordercode"];
                info.State = [infonodes objectForKey: @"state"];
                info.UserID = [infonodes objectForKey: @"userid"];
                info.GoodsID = [infonodes objectForKey: @"goodsid"];
                
                info.OrderAmtAll = info.OrderAmt + info.OrderFee;
                [dataArray addObject:info];
            }
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}
//photo6
+ (NSInteger) querypaybyid: (NSString*)ordercode goodsid:(NSString*)goodsid dataArray:(NSMutableArray*)dataArray uploadflag:(NSString **)uploadflag errmsg:(NSString**)errmsg
{
    
    [dataArray removeAllObjects];
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_querypaybyid];
    NSString* json = [NSString stringWithFormat:
                      @"{\"ordercode\":\"%@\",\"goodsid\":\"%@\"}",
                      ordercode, goodsid];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    
    if (code == 200)
    {
        NSDictionary *data = [result JSONValue];
        if (data != nil)
        {
            for (int i=0; i<[data count]; i++)
            {
                OrderInfo *info = [[[OrderInfo alloc]init]autorelease];
                NSDictionary *infonodes = data;
                info.OrderID = [infonodes objectForKey: @"orderid"];
                info.OrderName = [infonodes objectForKey: @"goodsname"];
                info.OrderTime = [infonodes objectForKey: @"statedate"];
                info.OrderAmt = [[infonodes objectForKey: @"amount"] floatValue];
                info.OrderFee = [[infonodes objectForKey: @"otheramount"] floatValue];
                info.OrderDesc = [infonodes objectForKey: @"orderdesc"];
                info.OrderStatusName = [infonodes objectForKey: @"statename"];
                info.OrderCode = [infonodes objectForKey: @"ordercode"];
                info.State = [infonodes objectForKey: @"state"];
                info.UserID = [infonodes objectForKey: @"userid"];
                info.GoodsID = [infonodes objectForKey: @"goodsid"];
                
                info.OrderAmtAll = info.OrderAmt + info.OrderFee;
    
                [dataArray addObject:info];
                
                //photo6状态
                *uploadflag = [infonodes objectForKey:@"uploadFlag"];
            }
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}



+ (NSInteger)xykhz:(NSString*)shopid goodsid:(NSString*)goodsid amount:(NSString**)amount errmsg:(NSString**)errmsg
{
    
#ifdef try_net
    *amount = @"0";
    *errmsg = @"注意啦。。。。系统的提现注意事项系统的提现注意事项系统的提现注意事项系统的提现注意事项系统的提现注意事项";
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_xykhz];
    NSString* json = [NSString stringWithFormat:@"{\"shopid\":\"%@\", \"goodsid\":\"%@\"}", shopid, goodsid];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        if (nodes != nil)
        {
            *amount = [nodes objectForKey:@"amount"];
            *errmsg = [nodes objectForKey:@"resultmsg"];
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
    
}

+ (NSInteger)xykhz:(NSString*)shopid goodsid:(NSString*)goodsid amount:(NSString**)amount otheramount: (NSString **) otheramount errmsg:(NSString**)errmsg
{
    
#ifdef try_net
    *amount = @"0";
    *errmsg = @"注意啦。。。。系统的提现注意事项系统的提现注意事项系统的提现注意事项系统的提现注意事项系统的提现注意事项";
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_xykhz];
    NSString* json = [NSString stringWithFormat:@"{\"shopid\":\"%@\", \"goodsid\":\"%@\"}", shopid, goodsid];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        if (nodes != nil)
        {
            *amount = [nodes objectForKey:@"amount"];
            *errmsg = [nodes objectForKey:@"resultmsg"];
            *otheramount = [nodes objectForKey:@"otheramount"];
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
    
}

+ (NSInteger) qxordersearch: (NSString*)shopid goodsid:(NSString*)goodsid begindt:(NSString*)begindt enddt:(NSString*)enddt dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg
{
    [dataArray removeAllObjects];
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_qxordersearch];
    NSString* json = [NSString stringWithFormat:
                      @"{\"shopid\":\"%@\",\"goodsid\":\"%@\",\"begindt\":\"%@\",\"enddt\":\"%@\" }",
                      shopid, goodsid, begindt, enddt];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        if (nodes != nil)
        {
            NSArray *data = [nodes objectForKey:@"data"];
            if (data && (data.count>0))
            {
                for (int i=0; i<[data count]; i++)
                {
                    OrderInfo *info = [[[OrderInfo alloc]init]autorelease];
                    NSDictionary *infonodes = [data objectAtIndex:i];
                    
                    info.OrderID = [infonodes objectForKey: @"orderid"];
                    info.OrderName = [infonodes objectForKey: @"goodsname"];
                    info.OrderTime = [infonodes objectForKey: @"statedate"];
                    info.OrderAmt = [[infonodes objectForKey: @"amount"] floatValue];
                    info.OrderFee = [[infonodes objectForKey: @"otheramount"] floatValue];
                    info.OrderDesc = [infonodes objectForKey: @"orderdesc"];
                    info.OrderStatusName = [infonodes objectForKey: @"statename"];
                    info.OrderCode = [infonodes objectForKey: @"ordercode"];
                    info.State = [infonodes objectForKey: @"state"];
                    info.StateName = [infonodes objectForKey: @"statename"];
                    info.GoodsID = [infonodes objectForKey: @"goodsid"];                    
                    
                    info.OrderAmtAll = info.OrderAmt + info.OrderFee;
                    [dataArray addObject:info];
                }
            }
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}

+ (NSInteger)xyktx:(NSString*)shopid goodsid:(NSString*)goodsid amount:(NSString*)amount dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg
{
    [dataArray removeAllObjects];
#ifdef try_net
    OrderInfo* info = [[[OrderInfo alloc]init]autorelease];
    info.OrderID = @"4233434";
    info.OrderAmt = 1234.33;
    info.OrderFee = 342.32;
    info.State = @"10H";
    info.StateName = @"已生成";
    info.OrderDesc = @"货款";
    info.OrderTime = @"2012-09-12 3:11:33";
    [dataArray addObject:info];
    *errmsg = @"提现请求已经提交，请等待审核";
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_xyktx];
    NSString* json = [NSString stringWithFormat:@"{\"shopid\":\"%@\", \"goodsid\":\"%@\", \"amount\":\"%@\"}", shopid, goodsid, amount];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        if (nodes != nil)
        {
            NSArray *data = [nodes objectForKey:@"data"];
            if (data && (data.count>0))
            {
                for (int i=0; i<[data count]; i++)
                {
                    OrderInfo *info = [[[OrderInfo alloc]init]autorelease];
                    NSDictionary *infonodes = [data objectAtIndex:i];
                    info.OrderID = [infonodes objectForKey: @"orderid"];
                    info.OrderName = [infonodes objectForKey: @"goodsname"];
                    info.OrderTime = [infonodes objectForKey: @"statedate"];
                    info.OrderAmt = [[infonodes objectForKey: @"amount"] floatValue];
                    info.OrderFee = [[infonodes objectForKey: @"otheramount"] floatValue];
                    info.OrderDesc = [infonodes objectForKey: @"orderdesc"];
                    info.OrderStatusName = [infonodes objectForKey: @"statename"];
                    info.OrderCode = [infonodes objectForKey: @"ordercode"];
                    info.State = [infonodes objectForKey: @"state"];
                    info.StateName = [infonodes objectForKey: @"statename"];
                    info.GoodsID = [infonodes objectForKey: @"goodsid"];
                    
                    info.OrderAmtAll = info.OrderAmt + info.OrderFee;
                    [dataArray addObject:info];
                }
            }
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}


+ (NSInteger)delxyktx:(NSString*)orderid goodsid:(NSString*)goodsid errmsg:(NSString**)errmsg
{    
#ifdef try_net
    *errmsg = @"test提现请求已经取消 ";
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_delxyktx];
    NSString* json = [NSString stringWithFormat:@"{\"orderid\":\"%@\", \"goodsid\":\"%@\"}", orderid, goodsid];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        if (nodes != nil)
        {
            *errmsg = [nodes objectForKey:@"resultmsg"];
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
    
}

+ (NSInteger)getxyktxstate:(NSString*)shopid type:(NSString**)type errmsg:(NSString**)errmsg
{
    
#ifdef try_net
    *type = @"0";
    *errmsg = @"xxx";
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_getxyktxstate];
    NSString* json = [NSString stringWithFormat:@"{\"shopid\":\"%@\"}", shopid];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        if (nodes != nil)
        {
            *type = [nodes objectForKey:@"type"];
            *errmsg = [nodes objectForKey:@"resultmsg"];
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
    
}

+ (NSInteger)setxyktxstate:(NSString*)shopid type:(NSString*)type errmsg:(NSString**)errmsg
{    
#ifdef try_net
    *errmsg = @"bbdss";
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_setxyktxstate];
    NSString* json = [NSString stringWithFormat:@"{\"shopid\":\"%@\", \"type\":\"%@\"}", shopid, type];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        if (nodes != nil)
        {
            *errmsg = [nodes objectForKey:@"resultmsg"];
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
    
}

+ (NSInteger)jjkzz:(NSString *)shopid accountname:(NSString *)accountname accountnbr:(NSString *)accountnbr amount: (NSString *)amount orderdesc:(NSString *)orderdesc goodsid: (NSString *)goodsid dataArray:(NSMutableDictionary*)dataArray errmsg:(NSString**)errmsg {
    
    [dataArray removeAllObjects];
#ifdef try_net
    OrderInfo* info = [[[OrderInfo alloc]init]autorelease];
    info.OrderID = @"4233434";
    info.OrderAmt = 1234.33;
    info.OrderFee = 342.32;
    info.State = @"10H";
    info.StateName = @"已生成";
    info.OrderDesc = @"货款";
    info.OrderTime = @"2012-09-12 3:11:33";
    [dataArray addObject:info];
    *errmsg = @"提现请求已经提交，请等待审核";
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_jjkzz];
    NSString* json = [NSString stringWithFormat:@"{\"shopid\":\"%@\", \"accountname\":\"%@\",\"accountnbr\":\"%@\",\"amount\":\"%@\",\"orderdesc\":\"%@\", \"goodsid\":\"%@\"}", shopid, accountname, accountnbr, amount, orderdesc, goodsid];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        if (nodes != nil)
        {
            [dataArray setObject:[nodes objectForKey:@"orderid"] forKey:@"orderid"];
            [dataArray setObject:[nodes objectForKey:@"otheramount"] forKey:@"otheramount"];
            [dataArray setObject:[nodes objectForKey:@"shopid"] forKey:@"shopid"];
            
            /*
            NSArray *data = [nodes objectForKey:@"data"];
            
            if (data && (data.count>0))
            {
                for (int i=0; i<[data count]; i++)
                {
                    OrderInfo *info = [[[OrderInfo alloc]init]autorelease];
                    NSDictionary *infonodes = [data objectAtIndex:i];
                    info.OrderID = [infonodes objectForKey: @"orderid"];
                    info.OrderName = [infonodes objectForKey: @"goodsname"];
                    info.OrderTime = [infonodes objectForKey: @"statedate"];
                    info.OrderAmt = [[infonodes objectForKey: @"amount"] floatValue];
                    info.OrderFee = [[infonodes objectForKey: @"otheramount"] floatValue];
                    info.OrderDesc = [infonodes objectForKey: @"orderdesc"];
                    info.OrderStatusName = [infonodes objectForKey: @"statename"];
                    info.OrderCode = [infonodes objectForKey: @"ordercode"];
                    info.State = [infonodes objectForKey: @"state"];
                    info.StateName = [infonodes objectForKey: @"statename"];
                    info.GoodsID = [infonodes objectForKey: @"goodsid"];
                    
                    info.OrderAmtAll = info.OrderAmt + info.OrderFee;
                    [dataArray addObject:info];
                }
            }
             */
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
    
}

+ (NSInteger) commitOrder: (NSString *)orderid cardnbr: (NSString *)cardnbr cardnbr2: (NSString *)cardnbr2 cardpwd: (NSString *)cardpwd goosid: (NSString *)goodsid dataArray: (NSMutableDictionary *)dataArray errmsg: (NSString **)errmsg {
    
    [dataArray removeAllObjects];

    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_jjktj];
    NSString* json = [NSString stringWithFormat:@"{\"orderid\":\"%@\", \"cardnbr\":\"%@\",\"cardnbr2\":\"%@\",\"cardpwd\":\"%@\",\"goodsid\":\"%@\"}", orderid, cardnbr, cardnbr2, cardpwd, goodsid];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        if (nodes != nil)
        {
            [dataArray setObject:[nodes objectForKey:@"orderid"] forKey:@"orderid"];
            [dataArray setObject:[nodes objectForKey:@"result"] forKey:@"result"];
            [dataArray setObject:[nodes objectForKey:@"resultmsg"] forKey:@"resultmsg"];
            
       
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;

    
    
}

+ (NSInteger) shmx: (NSString*)shopid orgtype:(NSString*)orgtype dataArray:(NSMutableArray*)dataArray errmsg:(NSString**)errmsg
{
    [dataArray removeAllObjects];
#ifdef try_net
    return 200;
#endif
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_shmx];
    NSString* json = [NSString stringWithFormat:
                      @"{\"shopid\":\"%@\",\"orgtype\":\"%@\" }",
                      shopid, orgtype];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        if (nodes != nil)
        {
            NSArray *data = [nodes objectForKey:@"data"];
            if (data && (data.count>0))
            {
                for (int i=0; i<[data count]; i++)
                {
                    UserDetailInfo *info = [[[UserDetailInfo alloc]init]autorelease];
                    NSDictionary *infonodes = [data objectAtIndex:i];
                    
                    info.OrgId = [infonodes objectForKey: @"orgid"];
                    info.OrgName = [infonodes objectForKey: @"orgname"];
                    info.RegPhone = [infonodes objectForKey: @"regphone"];
                    
                    info.ShopID = [infonodes objectForKey: @"shopid"];
                    info.ShopName = [infonodes objectForKey: @"shopname"];
                    
                    info.OtherAmount = [infonodes objectForKey: @"otheramount"] ;
                    info.Amount = [infonodes objectForKey: @"amount"] ;
                    
                    NSLog(@"%@", info.ShopName);
                    NSLog(@"%@", info.Amount);
                    
                    [dataArray addObject:info];
                }
            }
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}

+ (NSInteger) getShopUrl:(NSString *)shopid goodsid: (NSString *)goodsid dataArray: (NSMutableDictionary *) dataArray errmsg: (NSString **)errmsg {
    
    [dataArray removeAllObjects];
    
    NSString* url = [NSString stringWithFormat:@"%@%@", url_base, url_shopurl];
    NSString* json = [NSString stringWithFormat:@"{\"shopid\":\"%@\",\"goodsid\":\"%@\"}", shopid, goodsid];
    NSString* result;
    int code = [self readPostData: url json:json result:&result];
    if (code == 200)
    {
        NSDictionary *nodes = [result JSONValue];
        if (nodes != nil)
        {
            [dataArray setObject:[nodes objectForKey:@"shopaddr"] forKey:@"shopaddr"];
            [dataArray setObject:[nodes objectForKey:@"shopcode"] forKey:@"shopcode"];
            //[dataArray setObject:[nodes objectForKey:@"result"] forKey:@"result"];
            //[dataArray setObject:[nodes objectForKey:@"resultmsg"] forKey:@"resultmsg"];
            
            
        }
    }
    [NetIntf getErrmsg: code resp:result errmsg:errmsg];
    
    return code;
}


@end
