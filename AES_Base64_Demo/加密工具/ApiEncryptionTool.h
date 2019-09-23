//
//  ApiEncryptionTool.h
//  AES_Base64_Demo
//
//  Created by HoolaiGame on 2019/9/23.
//  Copyright © 2019 CoderChan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApiEncryptionTool : NSObject

/**
 AES加密
 
 @param key 明文
 @return 密文
 */
+ (NSString *)encryWithKey:(NSString *)key;

/**
 AES解密
 
 @param key 密文
 @return 明文
 */
+ (NSString *)decryWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
