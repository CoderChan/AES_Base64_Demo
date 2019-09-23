//
//  Base64Tool.hpp
//  AES_Base64_Demo
//
//  Created by HoolaiGame on 2019/9/23.
//  Copyright © 2019 CoderChan. All rights reserved.
//

#ifndef Base64Tool_hpp
#define Base64Tool_hpp

#include <stdio.h>
#include <string>


std::string base64_encode(unsigned char const* , unsigned int len);
std::string base64_decode(std::string const& s);

#endif /* Base64Tool_hpp */
