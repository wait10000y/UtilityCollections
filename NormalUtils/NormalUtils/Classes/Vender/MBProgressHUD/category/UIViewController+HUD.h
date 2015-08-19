//
//  UIViewController+HUD.h
//  NormalUtils
//
//  Created by wsliang on 15/8/19.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import <UIKit/UIKit.h>
import <objc/runtime.h>
#import "MBProgressHUD.h"


#define deviceIsPad   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define deviceIsPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

typedef void(^AlertBlock)(BOOL isOK);

@interface UIViewController (HUD)

- (void)async:(void(^)(void))block;
- (void)async_main:(void(^)(void))block;

+(id)loadNibViewController:(NSString*)theNibName;
+(id)loadNibView:(NSString*)theNibName;

-(BOOL)isLastIOS7;
-(BOOL)isLastIOS6;
-(float)getIOSVersion;

- (void) presentTransparentController:(UIViewController *)controller withDuration:(CGFloat) duration;



/*
 Simple wrap of MBProgressHUD
 */



-(MBProgressHUD*)hud;
-(void)setHud:(MBProgressHUD *)hud;

- (void)showHUD;
- (void)hideHUD;
- (void)showHUDNoAnimate;
- (void)showHUDWithOvertime;
- (void)showHUDWithText:(NSString *)aText;
- (void)showHUDSuccess:(NSString *)sucessString;
- (void)showHUDFailed:(NSString *)failedString;

- (void)showHUDAutoDismiss:(NSString *)string;
- (void)showHUDSuccessAutoDismiss:(NSString *)sucessString;
- (void)showHUDFailedAutoDismiss:(NSString *)failedInfo;



-(void)showAlertView:(NSString*)title withContent:(NSString*)content;
-(void)showAlertViewSelect:(NSString*)title content:(NSString*)content choseBlock:(AlertBlock)theBlock;

/*
 others showView
 */
-(UIViewAutoresizing)getViewAllResizingMask;

@end
