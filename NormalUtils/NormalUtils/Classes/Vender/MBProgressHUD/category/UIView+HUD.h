//
//  UIView+HUD.h
//  TestWebViewController
//
//  Created by wsliang on 15/5/25.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"

typedef void(^AlertViewSelectBlock)(BOOL isOK);

@interface UIView (HUD)<MBProgressHUDDelegate>

+(id)loadNibView:(NSString*)theNibName;

- (void)async:(void(^)(void))block;
- (void)async_main:(void(^)(void))block;

-(BOOL)isLastIOS7;
-(BOOL)isLastIOS6;
-(float)getIOSVersion;

-(UIViewAutoresizing)getViewAllResizingMask;

// --------- hud ---------
-(void)showHUDLoading;
-(void)showHUDLoadingTips:(NSString*)theTips;
-(void)showHUDLoadingTips:(NSString*)theTips details:(NSString*)theDetail;
-(MBProgressHUD *)showHUDProgressTips:(NSString *)theTips;

-(void)hideHUDLoading:(NSTimeInterval)delayTime;

-(void)showHUDSuccessTips:(NSString*)theTips hideDelay:(NSTimeInterval)delayTime;
-(void)showHUDFailTips:(NSString*)theTips hideDelay:(NSTimeInterval)delayTime;
-(void)showHUDWarnTips:(NSString*)theTips hideDelay:(NSTimeInterval)delayTime;
-(void)showHUDCustomView:(UIView*)theCustomView withTips:(NSString*)theTips hideDelay:(NSTimeInterval)delayTime;
-(void)showHUDTextTips:(NSString*)theTips detail:(NSString*)theDetail hideDelay:(NSTimeInterval)delayTime;

-(void)showHUDExcuteBlock:(void(^)(MBProgressHUD *hudView))exBlock complete:(void(^)(void))theBlock;
-(void)showHUDProgressBlock:(void(^)(MBProgressHUD *hudView))exBlock complete:(void(^)(void))theBlock;

// -------------------

-(void)showAlertView:(NSString*)title withContent:(NSString*)content;
-(void)showAlertViewSelect:(NSString*)title content:(NSString*)content choseBlock:(AlertViewSelectBlock)theBlock;




@end