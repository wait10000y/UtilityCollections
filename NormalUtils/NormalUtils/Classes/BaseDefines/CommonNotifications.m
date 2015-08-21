//
//  CommonNotifications.m
//  NormalUtils
//
//  Created by wsliang on 15/8/20.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import "CommonNotifications.h"

@implementation CommonNotifications




- (void)viewDidAppear:(BOOL)animated
{
  //add notification
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tableViewScrollToBottom) name:UIKeyboardDidShowNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)keyboardChange:(NSNotification *)notification
{
  NSDictionary *userInfo = [notification userInfo];
  NSTimeInterval animationDuration;
  UIViewAnimationCurve animationCurve;
  CGRect keyboardEndFrame;
  
  [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
  [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
  [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
  
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:animationDuration];
  [UIView setAnimationCurve:animationCurve];
  
//  //adjust ChatTableView's height
//  if (notification.name == UIKeyboardWillShowNotification) {
//    self.bottomConstraint.constant = keyboardEndFrame.size.height+40;
//  }else{
//    self.bottomConstraint.constant = 40;
//  }
//  
//  [self.view layoutIfNeeded];
//  
//  //adjust UUInputFunctionView's originPoint
//  CGRect newFrame = IFView.frame;
//  newFrame.origin.y = keyboardEndFrame.origin.y - newFrame.size.height;
//  IFView.frame = newFrame;
  
  [UIView commitAnimations];
  
}

//tableView Scroll to bottom
- (void)tableViewScrollToBottom
{
//  if (self.chatModel.dataSource.count==0)
//    return;
//  
//  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chatModel.dataSource.count-1 inSection:0];
//  [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


@end
