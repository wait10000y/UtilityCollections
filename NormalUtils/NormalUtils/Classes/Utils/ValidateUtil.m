//
//  ValidateUtil.m
//  NormalUtils
//
//  Created by wsliang on 15/8/18.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import "ValidateUtil.h"

@implementation ValidateUtil


#pragma mark 验证电话号码
-(BOOL)validateMobile:(NSString* )mobileNumber
{
  NSString *mobileStr = @"^((145|147)|(15[^4])|(17[6-8])|((13|18)[0-9]))\\d{8}$";
  return [self validateString:mobileNumber withRegxs:mobileStr];
}

-(BOOL)validateString:(NSString*)theStr withRegxs:(NSString*)theRegx
{
  if (theRegx) {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",theRegx];
    return [predicate evaluateWithObject:theStr];
  }
  return YES;
}



@end
