//
//  UIWebView+operations.h
//  NormalUtils
//
//  Created by wsliang on 15/8/19.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (operations)








+(void)customCacheForWebview;


- (NSArray *)htmlGetImgUrls;

- (int)htmlNodeCountOfTag:(NSString *)tagName;


@end
