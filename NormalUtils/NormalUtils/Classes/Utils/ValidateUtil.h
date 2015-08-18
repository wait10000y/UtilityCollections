//
//  ValidateUtil.h
//  NormalUtils
//
//  Created by wsliang on 15/8/18.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import "BaseObject.h"

@interface ValidateUtil : BaseObject

// base
-(BOOL)validateString:(NSString*)theStr withRegxs:(NSString*)theRegx;

// simple
-(BOOL)validateMobile:(NSString* )mobileNumber;



@end
