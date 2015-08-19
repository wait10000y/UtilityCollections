//
//  UIViewController+HUD.m
//  NormalUtils
//
//  Created by wsliang on 15/8/19.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import "UIViewController+HUD.h"

@implementation UIViewController (HUD)

static MBProgressHUD *mHud;
static AlertBlock mBlock;

#pragma mark - ASync

-(MBProgressHUD*)hud
{
  return mHud;
}

-(void)setHud:(MBProgressHUD *)hud
{
  mHud = hud;
}

- (void)async:(void(^)(void))block{
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

- (void)async_main:(void(^)(void))block{
  dispatch_async(dispatch_get_main_queue(), block);
}

+(id)loadNibViewController:(NSString*)theNibName
{
  return [[[self class] alloc] initWithNibName:theNibName?:NSStringFromClass([self class]) bundle:nil];
}

+(id)loadNibView:(NSString*)theNibName
{
  NSArray *viewArr = [[NSBundle mainBundle] loadNibNamed:theNibName owner:nil options:nil];
  if (viewArr.count>0) {
    return [viewArr firstObject];
  }
  return nil;
}


-(BOOL)isLastIOS7
{
  return ([UIDevice currentDevice].systemVersion.floatValue >= 7.0);
}

-(BOOL)isLastIOS6
{
  return ([UIDevice currentDevice].systemVersion.floatValue >= 6.0);
}

-(float)getIOSVersion
{
  return [UIDevice currentDevice].systemVersion.floatValue;
}

- (void) presentTransparentController:(UIViewController *)controller withDuration:(CGFloat) duration {
  
  //    controller.view.backgroundColor = [UIColor clearColor];
  controller.view.transform = CGAffineTransformMakeTranslation(0, controller.view.frame.size.height);
  [UIView animateWithDuration:duration animations:^{
    controller.view.transform = CGAffineTransformMakeTranslation(0, 0);
  }];
  
  self.modalPresentationStyle = UIModalPresentationCurrentContext;//让进入的动画失效
  [self presentViewController:controller animated:NO completion:^{
    self.modalPresentationStyle = UIModalPresentationFullScreen;
  }];
}




#pragma mark - HUD

-(MBProgressHUD*)createHUD
{
  if(!self.hud){
    if(self.navigationController.view){
      self.hud = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
      [self.navigationController.view addSubview:self.hud];
    }else{
      self.hud = [[MBProgressHUD alloc]initWithView:self.view];
      [self.view addSubview:self.hud];
    }
  }
  return self.hud;
}
- (void)showHUD{
  [self createHUD];
  self.hud.mode = MBProgressHUDModeIndeterminate;
  self.hud.customView = nil;
  self.hud.labelText = nil;
  [self.hud show:YES];
}

-(void)hideHUD{
  [self hideHUD:0];
}

- (void)showHUDNoAnimate{
  [self createHUD];
  self.hud.mode = MBProgressHUDModeIndeterminate;
  self.hud.customView = nil;
  self.hud.labelText = nil;
  [self.hud show:YES];
}

- (void)showHUDSuccess:(NSString *)sucessString{
  [self createHUD];
  self.hud.mode = MBProgressHUDModeCustomView;
  self.hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon-success"]];
  self.hud.labelText = sucessString;
  [self.hud show:YES];
}

- (void)showHUDFailed:(NSString *)failedString{
  [self createHUD];
  self.hud.mode = MBProgressHUDModeCustomView;
  self.hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon-error"]];
  self.hud.labelText = failedString;
  [self.hud show:YES];
}

- (void)showHUDWithOvertime{
  [self showHUD];
  [self hideHUD:29];
}


- (void)hideHUD:(NSTimeInterval)delay{
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.hud hide:YES afterDelay:delay];
    //        [self.hud removeFromSuperview];
    //        self.hud.mode = MBProgressHUDModeIndeterminate;
    //        self.hud = nil;
  });
}

- (void)showHUDWithText:(NSString *)aText{
  [self createHUD];
  self.hud.mode = MBProgressHUDModeIndeterminate;
  self.hud.customView = nil;
  self.hud.labelText = aText;
  [self.hud show:YES];
}

- (void)showHUDFailedAutoDismiss:(NSString *)failedInfo{
  [self showHUDFailed:failedInfo];
  [self hideHUD:2];
}

- (void)showHUDSuccessAutoDismiss:(NSString *)sucessString{
  [self showHUDSuccess:sucessString];
  [self hideHUD:0.75];
}

- (void)showHUDAutoDismiss:(NSString *)string{
  [self createHUD];
  self.hud.mode = MBProgressHUDModeText;
  self.hud.customView = nil;
  self.hud.labelText = string;
  [self.hud show:YES];
  [self.hud hide:YES afterDelay:2];
}

-(void)showAlertView:(NSString*)title withContent:(NSString*)content
{
  UIAlertView *alertv = [[UIAlertView alloc] initWithTitle:title?:@"   " message:content delegate:nil cancelButtonTitle:@"确  定" otherButtonTitles:nil,nil];
  alertv.tag = 1001;
  [alertv show];
}


-(void)showAlertViewSelect:(NSString*)title content:(NSString*)content choseBlock:(AlertBlock)theBlock
{
  mBlock = theBlock;
  UIAlertView *alertv = [[UIAlertView alloc] initWithTitle:title?:@"   " message:content delegate:self cancelButtonTitle:@"取  消" otherButtonTitles:@"确  定",nil];
  alertv.tag = 1001;
  [alertv show];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
  if (alertView.tag == 1001) {
    if (mBlock) {
      mBlock(buttonIndex==1);
      mBlock = nil;
    }
  }
}


#pragma mark - others showView
-(UIViewAutoresizing)getViewAllResizingMask
{
  return UIViewAutoresizingFlexibleLeftMargin|
  UIViewAutoresizingFlexibleWidth|
  UIViewAutoresizingFlexibleRightMargin|
  UIViewAutoresizingFlexibleTopMargin|
  UIViewAutoresizingFlexibleHeight|
  UIViewAutoresizingFlexibleBottomMargin;
}

@end
