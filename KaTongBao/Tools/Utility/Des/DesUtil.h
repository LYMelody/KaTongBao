//
//  DesUtil.h
//  VisaReader
//
//  Created by yangmx on 13-3-18.
//
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface DesUtil : NSObject

+ (NSString *)hexStringFromData:(NSData*) dataValue;
+ (NSData *)dataFromHexString:(NSString *)string;
+ (NSString*)Des2Decrypt:(NSString*)plainText key:(NSString*)key;
+ (NSString*)Des2Decrypt:(NSString*)plainText;
+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt deskey:(NSString*)deskey;

@end
