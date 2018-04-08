//
//  WJBannerScrollView.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/7.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickWithBlock)(NSInteger index);

@interface BannerScroll : UIScrollView

@end

@interface WJBannerScrollView : UIScrollView

/**
 *  创建本地图片
 *
 *  @param imageNames   图片名字数组
 *  @param block        点击block
 *  @return             创建本地图片，不自动切换
 */
-(id)initWithImageNames:(NSArray *)imageNames clickBlock:(ClickWithBlock)block;


/**
 *  创建本地图片
 *
 *  @param imageNames   图片名字数组
 *  @param block        点击block
 *  @param timeInterval 自动切换时间(0为不切换)
 *  @return             创建本地图片
 */
-(id)initWithImageNames:(NSArray *)imageNames autoTimerInterval:(NSTimeInterval)timeInterval clickBlock:(ClickWithBlock)block;


/**
 *  创建网络图片
 *
 *  @param imageNames    图片名字数组
 *  @param block         点击block
 *  @return              创建网络图片，不自动切换
 */
-(id)initWithImageUrls:(NSArray *)imageUrls clickBlock:(ClickWithBlock)block;

/**
 *  创建网络图片
 *
 *  @param imageNames   图片名字数组
 *  @param block        点击block
 *  @param timeInterval 自动切换时间(0为不切换)
 *  @return             创建网络图片
 */
-(id)initWithImageUrls:(NSArray *)imageUrls autoTimerInterval:(NSTimeInterval)timeInterval clickBlock:(ClickWithBlock)block;



@end
