//
//  NSString+create.h
//  NormalUtils
//
//  Created by wsliang on 15/8/19.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (create)

// max length:300
+(NSString *)randomString;

+(NSString*)randomStringWithLength:(uint32_t)theLength;


@end
