//
//  HbbImageUtil.h
//  GroupAvatarDemo
//
//  Created by LUOCHENG DE on 15/12/18.
//  Copyright © 2015年 Kate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  图片合成工具
 */
@interface APGroupImageUtil : NSObject

+ (instancetype)shared;

- (UIImage *)mergeWithImageArray:(NSArray *)imageArray size:(CGSize)size backgroundColor:(UIColor *)backgroundColor;

- (UIImage *)mergeWithImageUrlArray:(NSArray *)mergeWithImageUrlArray size:(CGSize)size backgroundColor:(UIColor *)backgroundColor;

@end
