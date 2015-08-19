//
//  NSString+create.m
//  NormalUtils
//
//  Created by wsliang on 15/8/19.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import "NSString+create.h"

@implementation NSString (create)



+(NSString *)randomString
{
  int nLength = random()%300+1;
  return [self randomStringWithLength:nLength];
  
}

+(NSString*)randomStringWithLength:(uint32_t)theLength
{
  char data[theLength];
  for (int x=0;x<theLength;data[x++] = (char)('A' + (arc4random_uniform(62))));
  return [[NSString alloc] initWithBytes:data length:theLength encoding:NSUTF8StringEncoding];
}






@end
