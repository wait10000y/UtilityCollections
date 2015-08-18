//
//  BaseNavigationController.m
//  NormalUtils
//
//  Created by wsliang on 15/8/18.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import "BaseNavigationController.h"


#define startX -200;

#define KEY_WINDOW [[UIApplication sharedApplication]keyWindow]
#define ONE_CONTROLLER (self.viewControllers.count<=1)


@interface BaseNavigationController ()
{
  CGPoint startTouch;
  UIImageView *lastScreenShotView;
  UIView *blackMask;
  UIPanGestureRecognizer *recognizer;
}

@property (nonatomic,retain) NSMutableArray *screenShotsList;
@property (nonatomic, retain) UIView *backGroundView;
@property (nonatomic,assign) BOOL isMoving;
@property (nonatomic, assign) BOOL isOpened;

@end


@implementation BaseNavigationController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //屏蔽掉iOS7以后自带的滑动返回手势 否则有BUG
  if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    self.interactivePopGestureRecognizer.enabled = NO;
  }
  
  self.screenShotsList = [[NSMutableArray alloc]initWithCapacity:2];
  self.canDragBack = YES;  
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  [self.screenShotsList addObject:[self capture]];
  [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
  [self.screenShotsList removeLastObject];
  return [super popViewControllerAnimated:animated];
}

-(void)setCanDragBack:(BOOL)theFlag
{
  _canDragBack = theFlag;
  if (theFlag) {
    if (!recognizer) {
      recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(paningGestureReceive:)];
      [recognizer delaysTouchesBegan];
    }
    [self.view addGestureRecognizer:recognizer];
  }else{
    if (recognizer) {
      [self.view removeGestureRecognizer:recognizer];
      //      recognizer = nil;
    }
  }
}

#pragma mark - Utility Methods -

- (UIImage *)capture
{
  UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
  [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return img;
}

//- (void)moveViewWithX:(float)x
//{
//  float balpha = x < 0 ? -x : x;
//  CATransform3D transform = CATransform3DIdentity;
//  transform = CATransform3DRotate(transform,(M_PI/180*(x/kDeviceWidth)*50), 0, 0, 1);
//  [self.view.layer setTransform:transform];
//  float alpha = 0.4 - (balpha/800);
//  blackMask.alpha = alpha;
//
//}


- (void)moveViewWithX:(float)x
{
  x = x>320?320:x;
  x = x<0?0:x;
  
  CGRect frame = self.view.frame;
  frame.origin.x = x;
  self.view.frame = frame;
  float scale = (x/6400)+0.95;
  float alpha = 0.4 - (x/800);
  
  lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
  blackMask.alpha = alpha;
}


-(BOOL)isBlurryImg:(CGFloat)tmp
{
  return YES;
}

#pragma mark - UIPanGestureRecongnizer
- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
  if(!self.canDragBack) return;
  
  // we get the touch position by the window's coordinate
  CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];
  
  if (ONE_CONTROLLER) return;
  
  // begin paning, show the backGroundView(last screenshot),if not exist, create it.
  if (recoginzer.state == UIGestureRecognizerStateBegan) {
    NSLog(@"--- move begin ---");
    _isMoving = YES;
    startTouch = touchPoint;
    
    if (!self.backGroundView)
    {
      CGRect frame = self.view.frame;
      
      self.backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
      [self.view.superview insertSubview:self.backGroundView belowSubview:self.view];
      
      blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
      blackMask.backgroundColor = [UIColor blackColor];
      [self.backGroundView addSubview:blackMask];
    }
    
    self.backGroundView.hidden = NO;
    
    if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
    
    UIImage *lastScreenShot = [self.screenShotsList lastObject];
    lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
    [self.backGroundView insertSubview:lastScreenShotView belowSubview:blackMask];
    if (ONE_CONTROLLER) {
      self.backGroundView.hidden = YES;
      _isMoving = NO;
      UIImage *image = [self capture];
      lastScreenShotView = [[UIImageView alloc]initWithImage:image];
    }
    //End paning, always check that if it should move right or move left automatically
  }else if (recoginzer.state == UIGestureRecognizerStateEnded){
    NSLog(@"--- move end ---");
    if (touchPoint.x - startTouch.x > 50)
    {
      [UIView animateWithDuration:0.3 animations:^{
        [self moveViewWithX:320];
      } completion:^(BOOL finished) {
        CGRect frame = self.view.frame;
        frame.origin.x = 200;
        if (!ONE_CONTROLLER) {
          [self popViewControllerAnimated:NO];
          frame.origin.x = 0;
        }
        self.view.frame = frame;
        _isMoving = NO;
        NSLog(@"--- move complete ---");
      }];
    }
    else
    {
      [UIView animateWithDuration:0.3 animations:^{
        [self moveViewWithX:0];
      } completion:^(BOOL finished) {
        _isMoving = NO;
        self.backGroundView.hidden = YES;
        NSLog(@"--- move complete ---");
      }];
    }
    return;
    
    // cancal panning, alway move to left side automatically
  }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
    NSLog(@"--- move cancel ---");
    [UIView animateWithDuration:0.3 animations:^{
      [self moveViewWithX:0];
    } completion:^(BOOL finished) {
      _isMoving = NO;
      self.backGroundView.hidden = YES;
      NSLog(@"--- move complete ---");
    }];
    return;
  }
  // it keeps move with touch
  if (_isMoving) {
    [UIView animateWithDuration:0.3 animations:^{
      [self moveViewWithX:touchPoint.x - startTouch.x];
    }];
  }
}


// 支持 旋转 功能
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
  return !self.disableAutorotate;
}
- (BOOL)shouldAutorotate
{
  return self.disableAutorotate?NO:[super shouldAutorotate];
}


@end
