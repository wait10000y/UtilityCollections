//
//  UIWebView+operations.m
//  NormalUtils
//
//  Created by wsliang on 15/8/19.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import "UIWebView+operations.h"
#import "SDURLCache.h"

@implementation UIWebView (operations)




- (void)loadFromURL:(NSString*)URLString
{
  NSString *encodedUrl = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes (NULL, (__bridge CFStringRef) URLString, NULL, NULL,kCFStringEncodingUTF8);
  NSURL *url = [NSURL URLWithString:encodedUrl];
  NSURLRequest *req = [NSURLRequest requestWithURL:url];
  [self loadRequest:req];
}

- (void)loadFromHtmlFile:(NSString*)htmlName
{
  NSString *filePath = [[NSBundle mainBundle]pathForResource:htmlName ofType:@"html"];
  NSURL *url = [NSURL fileURLWithPath:filePath];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [self loadRequest:request];
}



+(void)customCacheForWebview
{
  SDURLCache *urlCache = [[SDURLCache alloc] initWithMemoryCapacity:1024*1024*4   // 4MB mem cache
                                           diskCapacity:1024*1024*20 // 20MB disk cache
                                               diskPath:[SDURLCache defaultCachePath]];
  
  urlCache.minCacheInterval = 10*60; // 默认 10分钟
  
  [NSURLCache setSharedURLCache:urlCache];
  
}









// 获取所有图片链接
- (NSArray *)htmlGetImgUrls
{
  NSMutableArray *arrImgURL = [[NSMutableArray alloc] init];
  for (int i = 0; i < [self htmlNodeCountOfTag:@"img"]; i++) {
    NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].src", i];
    [arrImgURL addObject:[self stringByEvaluatingJavaScriptFromString:jsString]];
  }
  return arrImgURL;
}

// img,div, etc.
- (int)htmlNodeCountOfTag:(NSString *)tagName
{
  NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('%@').length", tagName];
  int len = [[self stringByEvaluatingJavaScriptFromString:jsString] intValue];
  return len;
}



@end
