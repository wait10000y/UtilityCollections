//
//  BaseViewController.h
//  NormalUtils
//
//  Created by wsliang on 15/8/18.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic) BOOL disableAutorotate;

+(id)loadWithNib:(NSString*)theNibName;
+(UIView*)loadViewWithNib:(NSString*)theNibName withIndex:(int)theIndex;

-(UIViewAutoresizing)getViewAllResizingMask;

-(BOOL)isLastIOS7;
-(BOOL)isLastIOS6;
-(float)getIOSVersion;


@end
