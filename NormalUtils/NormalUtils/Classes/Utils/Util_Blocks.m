//
//  Util_Blocks.m
//  NormalUtils
//
//  Created by wsliang on 15/8/18.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import "Util_Blocks.h"

@implementation Util_Blocks


#pragma mark 验证电话号码
-(BOOL)validateMobile:(NSString* )mobileNumber
{
  NSString *mobileStr = @"^((145|147)|(15[^4])|(17[6-8])|((13|18)[0-9]))\\d{8}$";
  NSPredicate *cateMobileStr = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobileStr];
  
  if ([cateMobileStr evaluateWithObject:mobileNumber]==YES)
  {
    return YES;
  }
  return NO;
}


@end
