//
//  BaseViewController.m
//  NormalUtils
//
//  Created by wsliang on 15/8/18.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavigationController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

+(id)loadWithNib:(NSString*)theNibName
{
  return [[[self class] alloc] initWithNibName:theNibName?:NSStringFromClass([self class]) bundle:nil];
}

+(UIView*)loadViewWithNib:(NSString*)theNibName withIndex:(int)theIndex
{
  NSArray *viewArr = [[NSBundle mainBundle] loadNibNamed:theNibName owner:nil options:nil];
  if (viewArr.count > theIndex) {
    return viewArr[theIndex];
  }
  return nil;
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

-(void)setDisableAutorotate:(BOOL)tDisableAutorotate
{
  _disableAutorotate = tDisableAutorotate;
  if ([self.navigationController isKindOfClass:[BaseNavigationController class]]) {
    ((BaseNavigationController*)self.navigationController).disableAutorotate = _disableAutorotate;
  }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
  return !self.disableAutorotate;
}

- (BOOL)shouldAutorotate
{
  return self.disableAutorotate?NO:[super shouldAutorotate];
}








@end
