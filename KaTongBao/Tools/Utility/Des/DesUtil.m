//
//  DesUtil.m
//  VisaReader
//
//  Created by yangmx on 13-3-18.
//
//

#import "DesUtil.h"
#import "des.h"
#import <CommonCrypto/CommonDigest.h>
#import <Security/Security.h>
#import "GTMBase64.h"

@implementation DesUtil

+ (NSString *)hexStringFromData:(NSData*) dataValue
{
    UInt32 byteLength = [dataValue length], byteCounter = 0;
    UInt32 stringLength = (byteLength*2) + 1, stringCounter = 0;
    unsigned char dstBuffer[stringLength];
    unsigned char srcBuffer[byteLength];
    unsigned char *srcPtr = srcBuffer;
    [dataValue getBytes:srcBuffer];
    const unsigned char t[] = {"0123456789ABCDEF"};
    
    for (;byteCounter < byteLength; byteCounter++){
        unsigned src = *srcPtr;
        dstBuffer[stringCounter++] = t[src>>4];
        dstBuffer[stringCounter++] = t[src & 15];
        srcPtr++;
    }
    dstBuffer[stringCounter] = '\0';
    
    return [NSString stringWithUTF8String:(char*)dstBuffer];
}

+ (NSData *)dataFromHexString:(NSString *)string
{
    NSMutableData *stringData = [[[NSMutableData alloc] init] autorelease];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [string length] / 2; i++) {
        byte_chars[0] = [string characterAtIndex:i*2];
        byte_chars[1] = [string characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [stringData appendBytes:&whole_byte length:1];
    }
    return stringData;
}

+ (NSString*)Des2Decrypt:(NSString*)plainText key:(NSString*)keystr
{
    NSData* input = [DesUtil dataFromHexString:plainText];
    NSData* key = [DesUtil dataFromHexString:keystr];
    unsigned char output[16];
    des2DecryptWithKey((unsigned char*)[input bytes], (unsigned char*)[key bytes], output);
    NSData* value = [NSData dataWithBytes:output length:16];
    return [DesUtil hexStringFromData:value];    
}

+ (NSString*)Des2Decrypt:(NSString*)plainText
{
    NSData* input = [DesUtil dataFromHexString:plainText];
    unsigned char output[16];
    des2Decrypt((unsigned char*)[input bytes], output);
    NSData* value = [NSData dataWithBytes:output length:16];
    return [DesUtil hexStringFromData:value];
}

#define kChosenDigestLength     CC_SHA1_DIGEST_LENGTH

+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt deskey:(NSString*)deskey
{
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)//解密
    {
        NSData *EncryptData = [GTMBase64 decodeData:[plainText dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
    }
    else //加密
    {
        NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    const void *vkey = (const void *)[deskey UTF8String];
    // NSString *initVec = @"init Vec";
    //const void *vinitVec = (const void *) [initVec UTF8String];
    //  Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    //if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
    /*else if (ccStatus == kCC ParamError) return @"PARAM ERROR";
     else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
     else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
     else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
     else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
     else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED"; */
    
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                length:(NSUInteger)movedBytes]
                                        encoding:NSUTF8StringEncoding]
                  autorelease];
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMBase64 stringByEncodingData:myData];
    }
    
    return result;
}

@end
