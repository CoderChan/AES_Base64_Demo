//
//  ApiEncryptionTool.m
//  AES_Base64_Demo
//
//  Created by HoolaiGame on 2019/9/23.
//  Copyright © 2019 CoderChan. All rights reserved.
//

#import "ApiEncryptionTool.h"
#include <stdio.h>
#include <iostream>
#include "AESTool.hpp"
#include "Base64Tool.hpp"


@implementation ApiEncryptionTool

using namespace std;

const char g_key[33] = "12f862d21d3ceafba1b88e5f22960d55";
const char g_iv[17] = "1234567812345678";


#pragma mark - 原始加密函数
string EncryptionAES(const string& strSrc) //AESº”√‹
{
    size_t length = strSrc.length();
    int block_num = length / BLOCK_SIZE + 1;
    //√˜Œƒ
    char* szDataIn = new char[block_num * BLOCK_SIZE + 1];
    memset(szDataIn, 0x00, block_num * BLOCK_SIZE + 1);
    strcpy(szDataIn, strSrc.c_str());
    
    //Ω¯––PKCS7PaddingÃÓ≥‰°£
    int k = length % BLOCK_SIZE;
    int j = length / BLOCK_SIZE;
    int padding = BLOCK_SIZE - k;
    for (int i = 0; i < padding; i++)
    {
        szDataIn[j * BLOCK_SIZE + k + i] = padding;
    }
    szDataIn[block_num * BLOCK_SIZE] = '\0';
    
    //º”√‹∫Ûµƒ√‹Œƒ
    char *szDataOut = new char[block_num * BLOCK_SIZE + 1];
    memset(szDataOut, 0, block_num * BLOCK_SIZE + 1);
    
    //Ω¯––Ω¯––AESµƒCBCƒ£ Ωº”√‹
    AESTool aes;
    aes.MakeKey(g_key, g_iv, 32, 16);
    aes.Encrypt(szDataIn, szDataOut, block_num * BLOCK_SIZE, AESTool::CBC);
    string str = base64_encode((unsigned char*) szDataOut,
                               block_num * BLOCK_SIZE);
    delete[] szDataIn;
    delete[] szDataOut;
    return str;
}

#pragma mark - 原始解密函数
string DecryptionAES(const string& strSrc) //AESΩ‚√‹
{
    string strData = base64_decode(strSrc);
    size_t length = strData.length();
    //√‹Œƒ
    char *szDataIn = new char[length + 1];
    memcpy(szDataIn, strData.c_str(), length+1);
    //√˜Œƒ
    char *szDataOut = new char[length + 1];
    memcpy(szDataOut, strData.c_str(), length+1);
    
    //Ω¯––AESµƒCBCƒ£ ΩΩ‚√‹
    AESTool aes;
    aes.MakeKey(g_key, g_iv, 32, 16);
    aes.Decrypt(szDataIn, szDataOut, length, AESTool::CBC);
    
    //»•PKCS7PaddingÃÓ≥‰
    if (0x00 < szDataOut[length - 1] <= 0x16)
    {
        int tmp = szDataOut[length - 1];
        for (int i = length - 1; i >= length - tmp; i--)
        {
            if (szDataOut[i] != tmp)
            {
                memset(szDataOut, 0, length);
                //                cout << "»•ÃÓ≥‰ ß∞‹£°Ω‚√‹≥ˆ¥Ì£°£°" << endl;
                break;
            }
            else
                szDataOut[i] = 0;
        }
    }
    string strDest(szDataOut);
    delete[] szDataIn;
    delete[] szDataOut;
    return strDest;
}



#pragma mark - 加密函数
// AES加密
+ (NSString *)encryWithKey:(NSString *)key
{
    const char *charString = [key UTF8String];
    
    string str = EncryptionAES(charString);
    
    NSString *ocString = [NSString stringWithCString:str.c_str() encoding:[NSString defaultCStringEncoding]];
    
    return ocString;
    
}



#pragma mark - 解密函数
// AES解密
+ (NSString *)decryWithKey:(NSString *)key
{
    const char *charString = [key UTF8String];
    
    string str = DecryptionAES(charString);
    
    NSString *ocString = [NSString stringWithCString:str.c_str() encoding:[NSString defaultCStringEncoding]];
    
    return ocString;
}


#pragma mark - 测试函数
+ (void)testAction
{
    testAction();
}


void testAction()
{
    NSString *kkk = [ApiEncryptionTool encryWithKey:@"abc"];
    NSLog(@"abc的加密结果 = %@",kkk);
    
    kkk = @"s96k17BxUzBrunMmnufttsoMGOu9hzhejdkjJ04ZlgaoQDxxJ6VEuwu/CydyfsK3iuRHwalMay8ogp7iOHOldYuAA/s8hpx4E8BCKGazFF5dTLF0j59wIxNkjzdSUYYa7qpwgL09naMeAUxxuQ8X/bLj+JydTu7dzkRtYJVUNiY=";
    NSString *ppp = [ApiEncryptionTool decryWithKey:kkk];
    NSLog(@"解密结果 = %@",ppp);
    
}

@end
