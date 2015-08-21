//
//  NSString+drawing.m
//  NormalUtils
//
//  Created by wsliang on 15/8/20.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import "NSString+drawing.h"

@implementation NSString (drawing)





-(CGSize)sizeWithFont:(UIFont *)font constraintSize:(CGSize)size
{
  if ([[UIDevice currentDevice].systemVersion intValue] >= 7) {
    NSDictionary *dic = font.fontDescriptor.fontAttributes;
    return [self boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:dic
                              context:nil].size;
  }
  return [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
  
}


@end
