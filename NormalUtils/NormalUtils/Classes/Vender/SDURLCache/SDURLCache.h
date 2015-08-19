//
//  SDURLCache.h
//  SDURLCache
// Copyright (c) 2010-2011 Olivier Poitrey <rs@dailymotion.com>
// Modernized to use GCD by Peter Steinberger <steipete@gmail.com>
//
//  Created by Olivier Poitrey on 15/03/10.
//  Copyright 2010 Dailymotion. All rights reserved.
//

/*
 
 SDURLCache *urlCache = [[SDURLCache alloc] initWithMemoryCapacity:1024*1024*4   // 4MB mem cache
 diskCapacity:1024*1024*20 // 20MB disk cache
 diskPath:[SDURLCache defaultCachePath]];
 
 urlCache.minCacheInterval = 10*60; // 默认 10分钟
 
 [NSURLCache setSharedURLCache:urlCache];
 
 */

#import <Foundation/Foundation.h>

@interface SDURLCache : NSURLCache
{
    @private
    NSString *_diskCachePath;
    NSMutableDictionary *_diskCacheInfo;
    BOOL _diskCacheInfoDirty;
    BOOL _ignoreMemoryOnlyStoragePolicy;
    NSUInteger _diskCacheUsage;
    NSTimeInterval _minCacheInterval;
    dispatch_source_t _maintenanceTimer;
    BOOL _timerPaused;
}

/*
 * Defines the minimum number of seconds between now and the expiration time of a cacheable response
 * in order for the response to be cached on disk. This prevent from spending time and storage capacity
 * for an entry which will certainly expire before behing read back from disk cache (memory cache is
 * best suited for short term cache). The default value is set to 5 minutes (300 seconds).
 */
@property (nonatomic, assign) NSTimeInterval minCacheInterval;

/*
 * Allow the responses that have a storage policy of NSURLCacheStorageAllowedInMemoryOnly to be cached
 * on the disk anyway.
 *
 * This is mainly a workaround against cache policies generated by the UIWebViews: starting from iOS 4.2,
 * it always has a cache policy of NSURLCacheStorageAllowedInMemoryOnly.
 * The default value is YES
 */
@property (nonatomic, assign) BOOL ignoreMemoryOnlyStoragePolicy;

/*
 * Returns a default cache director path to be used at cache initialization. The generated path directory
 * will be located in the application's cache directory and thus won't be synced by iTunes.
 */
+ (NSString *)defaultCachePath;

/*
 * Checks if the provided URL exists in cache.
 */
- (BOOL)isCached:(NSURL *)url;

//- (NSUInteger)currentDiskUsage; // supper

@end
