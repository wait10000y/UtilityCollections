//
//  UIView+HUD.m
//  TestWebViewController
//
//  Created by wsliang on 15/5/25.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import "UIView+HUD.h"

#import "MBProgressHUD.h"

#define HUDViewTagInSuperView 4026
#define alertViewTagInSuperView 4027
static AlertViewSelectBlock mBlock;
//static MBProgressHUD *mHUD;

@implementation UIView (HUD)


-(MBProgressHUD*)createHUD
{
    @synchronized(self){
        MBProgressHUD *tempHUD = (MBProgressHUD*)[self viewWithTag:HUDViewTagInSuperView];
        if (!tempHUD) {
            tempHUD = [[MBProgressHUD alloc] initWithView:self];
            tempHUD.removeFromSuperViewOnHide = YES;
            [self addSubview:tempHUD];
        }
        return tempHUD;
    }
}

-(MBProgressHUD*)findHUD
{
    @synchronized(self){
        MBProgressHUD *tempHUD = (MBProgressHUD*)[self viewWithTag:HUDViewTagInSuperView];
        if (!tempHUD) {
            for (MBProgressHUD *temp in self.subviews) {
                if ([temp isKindOfClass:[MBProgressHUD class]]) {
                    tempHUD = temp;break;
                }
            }
        }
        return tempHUD;
    }
}


-(void)showHUDLoading
{
    [self showHUDLoadingTips:nil details:nil];
}

//-(void)showHUDLoadingColor:(UIColor*)bgColor indicatorColor:(UIColor*)indicatorColor
//{
//    MBProgressHUD *mHUD = [self createHUD];
//    mHUD.color = bgColor;
//    mHUD.activityIndicatorColor = indicatorColor;
//    [self addSubview:mHUD];
//    [self showHUDLoadingTips:nil details:nil];
//}

-(void)showHUDLoadingTips:(NSString*)theTips
{
    [self showHUDLoadingTips:theTips details:nil];
}

-(void)showHUDLoadingTips:(NSString*)theTips details:(NSString*)theDetail
{
    MBProgressHUD *mHUD = [self createHUD];
    mHUD.mode = MBProgressHUDModeIndeterminate;
//	mHUD.delegate = self;
//    mHUD.minSize = CGSizeMake(135.f, 135.f);
//	mHUD.square = YES;
	mHUD.labelText = theTips;
	mHUD.detailsLabelText = theDetail;
	[mHUD show:YES];
//	[mHUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

-(MBProgressHUD *)showHUDProgressTips:(NSString *)theTips
{
    MBProgressHUD *mHUD = [self createHUD];
    //MBProgressHUDModeDeterminate,
    //MBProgressHUDModeDeterminateHorizontalBar,
    //MBProgressHUDModeAnnularDeterminate,
    mHUD.mode = MBProgressHUDModeAnnularDeterminate;
    mHUD.labelText = theTips;
    [mHUD show:YES];
    return mHUD;
}

-(void)hideHUDLoading:(NSTimeInterval)delayTime
{
    [[self findHUD] hide:YES afterDelay:delayTime];
}

-(void)showHUDSuccessTips:(NSString*)theTips hideDelay:(NSTimeInterval)delayTime
{
    UIImageView *imgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-success"]];
    [self showHUDCustomView:imgview withTips:theTips hideDelay:delayTime];
}

-(void)showHUDFailTips:(NSString*)theTips hideDelay:(NSTimeInterval)delayTime
{
    UIImageView *imgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-error"]];
    [self showHUDCustomView:imgview withTips:theTips hideDelay:delayTime];
}

-(void)showHUDWarnTips:(NSString*)theTips hideDelay:(NSTimeInterval)delayTime
{
    UIImageView *imgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-info"]];
    [self showHUDCustomView:imgview withTips:theTips hideDelay:delayTime];
}

-(void)showHUDTextTips:(NSString*)theTips detail:(NSString*)theDetail hideDelay:(NSTimeInterval)delayTime
{
    MBProgressHUD *mHUD = [self createHUD];
    mHUD.mode = MBProgressHUDModeText;
	mHUD.labelText = theTips;
    mHUD.detailsLabelText = theDetail;
	mHUD.margin = 10.f;
	mHUD.removeFromSuperViewOnHide = YES;
    [mHUD show:YES];
	[mHUD hide:YES afterDelay:delayTime];
//    [self showHUDCustomView:nil withTips:theTips hideDelay:delayTime];
}


-(void)showHUDCustomView:(UIView*)theCustomView withTips:(NSString*)theTips hideDelay:(NSTimeInterval)delayTime
{
    MBProgressHUD *mHUD = [self createHUD];
    mHUD.customView = theCustomView;
	mHUD.mode = MBProgressHUDModeCustomView;
    mHUD.labelText = theTips;
	[mHUD show:YES];
	[mHUD hide:YES afterDelay:delayTime];
}


-(void)showHUDExcuteBlock:(void(^)(MBProgressHUD *hudView))exBlock complete:(void(^)(void))theBlock
{
#if NS_BLOCKS_AVAILABLE
	MBProgressHUD *mHUD = [self createHUD];
    
	[mHUD showAnimated:YES whileExecutingBlock:^{
        if (exBlock) { exBlock(mHUD); }
    } completionBlock:^{
        [mHUD removeFromSuperview];
        if (theBlock) { theBlock(); }
    }];
#endif
}

-(void)showHUDProgressBlock:(void(^)(MBProgressHUD *hudView))exBlock complete:(void(^)(void))theBlock
{
#if NS_BLOCKS_AVAILABLE
	MBProgressHUD *mHUD = [self createHUD];
    mHUD.mode = MBProgressHUDModeAnnularDeterminate;
    
	[mHUD showAnimated:YES whileExecutingBlock:^{
        if (exBlock) { exBlock(mHUD); }
    } completionBlock:^{
        [mHUD removeFromSuperview];
        if (theBlock) { theBlock(); }
    }];
#endif
}

//-(void)showHUDProgress
//{
//    MBProgressHUD *mHUD = [self createHUD];
//    
//    mHUD.mode = MBProgressHUDModeDeterminate;
//    mHUD.progress = 0.8f;
//    
//    
//    mHUD.dimBackground = YES;
//    mHUD.color = [UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];
//    [mHUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
//}
//
//- (void)myTask {
//	// This just increases the progress indicator in a loop
//    MBProgressHUD *hud = [self findHUD];
//    if (hud) {
//        float progress = 0.0f;
//        while (progress < 1.0f) {
//            progress += 0.01f;
//            [self findHUD].progress = progress;
//        }
//    }
//    usleep(50000);
//}


// -------------------------------

-(void)showAlertView:(NSString*)title withContent:(NSString*)content
{
    UIAlertView *alertv = [[UIAlertView alloc] initWithTitle:title?:@"   " message:content delegate:nil cancelButtonTitle:@"确  定" otherButtonTitles:nil,nil];
    alertv.tag = alertViewTagInSuperView;
    [alertv show];
}


-(void)showAlertViewSelect:(NSString*)title content:(NSString*)content choseBlock:(AlertViewSelectBlock)theBlock
{
    mBlock = theBlock;
    UIAlertView *alertv = [[UIAlertView alloc] initWithTitle:title?:@"   " message:content delegate:self cancelButtonTitle:@"取  消" otherButtonTitles:@"确  定",nil];
    alertv.tag = alertViewTagInSuperView;
    [alertv show];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == alertViewTagInSuperView) {
        if (mBlock) {
            mBlock(buttonIndex==1);
            mBlock = nil;
        }
    }
}

// -------------------------------

- (void)async:(void(^)(void))block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

- (void)async_main:(void(^)(void))block{
    dispatch_async(dispatch_get_main_queue(), block);
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

-(UIViewAutoresizing)getViewAllResizingMask
{
    return UIViewAutoresizingFlexibleLeftMargin|
    UIViewAutoresizingFlexibleWidth|
    UIViewAutoresizingFlexibleRightMargin|
    UIViewAutoresizingFlexibleTopMargin|
    UIViewAutoresizingFlexibleHeight|
    UIViewAutoresizingFlexibleBottomMargin;
}

















-(void)hudWasHidden:(MBProgressHUD *)hud
{

}




@end
