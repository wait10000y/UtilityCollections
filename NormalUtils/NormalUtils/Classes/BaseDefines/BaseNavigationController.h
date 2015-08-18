//
//  BaseNavigationController.h
//  NormalUtils
//
//  Created by wsliang on 15/8/18.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController

@property (nonatomic) BOOL disableAutorotate; // 是否不支持自动旋转

// 支持向右滑动 返回上一界面功能; 默认为特效开启,有的界面 手势冲突时,可以设置禁用此功能
@property (nonatomic, assign) BOOL canDragBack;


@end
