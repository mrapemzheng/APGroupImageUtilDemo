//
//  HbbImageUtil.m
//  GroupAvatarDemo
//
//  Created by LUOCHENG DE on 15/12/18.
//  Copyright © 2015年 Kate. All rights reserved.
//

#import "APGroupImageUtil.h"

@interface APGroupImageUtil ()

@end

static APGroupImageUtil *static_APGroupImageUtil;
@implementation APGroupImageUtil

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

+ (instancetype)shared
{
    if (static_APGroupImageUtil == nil) {
        static_APGroupImageUtil = [[APGroupImageUtil alloc] init];
    }
    return static_APGroupImageUtil;
}

- (UIImage *)mergeWithImageArray:(NSArray *)imageArray size:(CGSize)size backgroundColor:(UIColor *)backgroundColor;
{
    return [self mergeWithImageArray:imageArray size:size seperateWidth:2 backgroundColor:backgroundColor];
}

- (UIImage *)mergeWithImageUrlArray:(NSArray *)mergeWithImageUrlArray size:(CGSize)size backgroundColor:(UIColor *)backgroundColor;

{
    
    return nil;
}

#pragma mark - private methods

- (UIImage *)mergeWithImageArray:(NSArray *)imageArray size:(CGSize)size seperateWidth:(CGFloat)seperateWidth backgroundColor:(UIColor *)backgroundColor
{
    UIImage *image;
    
//    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO, 2);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    //背景颜色
    if(backgroundColor != nil) {
        CGContextSetFillColorWithColor(contextRef, backgroundColor.CGColor);
        CGContextAddRect(contextRef, CGRectMake(0, 0, size.width, size.height));
        CGContextDrawPath(contextRef, kCGPathFill);
    }
    
    UIImage *subImg;
    CGSize subImgSize = [self getSubImgSizeWithImageArray:imageArray size:size seperateWidth:seperateWidth];
    NSArray *pointArr = [self getCGPointWithImageArray:imageArray withSize:size subImgSize:subImgSize seperateWidth:seperateWidth];
    
    for (NSInteger i = 0;i < imageArray.count; i ++) {
        subImg = [imageArray objectAtIndex:i];
        CGRect rect = CGRectZero;
        rect.origin = [[pointArr objectAtIndex:i] CGPointValue];
        rect.size = subImgSize;
        [subImg drawInRect:rect];
    }
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (CGSize)getSubImgSizeWithImageArray:(NSArray *)imgArr size:(CGSize)size seperateWidth:(CGFloat)seperateWidth
{
    CGSize subImgSize;
    if (imgArr.count <= 4) {
        subImgSize = [self getSubImgSizeUsingSudoku4WithSize:size seperateWidth:seperateWidth];
    } else {
        subImgSize = [self getSubImgSizeUsingSudoku9WithSize:size seperateWidth:seperateWidth];
    }
    return subImgSize;
}

//获取四宫格子图片大小
- (CGSize)getSubImgSizeUsingSudoku4WithSize:(CGSize)size seperateWidth:(CGFloat)seperateWidth
{
    CGSize s4 = CGSizeMake((size.width - (seperateWidth*3))/2, (size.height - (seperateWidth*3))/2);
    return s4;
}

//获取九宫格子图片的大小
- (CGSize)getSubImgSizeUsingSudoku9WithSize:(CGSize)size seperateWidth:(CGFloat)seperateWidth
{
    CGSize s9 = CGSizeMake((size.width - (seperateWidth*4))/3, (size.height - seperateWidth*4)/3);
    return s9;
}

- (NSArray *)getCGPointWithImageArray:(NSArray *)imageArray withSize:(CGSize)size subImgSize:(CGSize)subImgSize seperateWidth:(CGFloat)seperateWidth
{
    NSArray *arr;
    if (imageArray.count == 1) {
        arr = [self getCGPointArrayWithOneSudoWithSize:size subImgSize:subImgSize seperateWidth:seperateWidth];
    } else if(imageArray.count == 2) {
        arr = [self getCGPointArrayWithTwoSudoWithSize:size subImgSize:subImgSize seperateWidth:seperateWidth];
    } else if(imageArray.count == 3) {
        arr = [self getCGPointArrayWithThreeSudoWithSize:size subImgSize:subImgSize seperateWidth:seperateWidth];
    } else if(imageArray.count == 4) {
        arr = [self getCGPointArrayWithFourSudoWithSize:size subImgSize:subImgSize seperateWidth:seperateWidth];
    } else if(imageArray.count == 5) {
        arr = [self getCGPointArrayWithFiveSudoWithSize:size subImgSize:subImgSize seperateWidth:seperateWidth];
    } else if(imageArray.count >= 6) {
        NSInteger imageCount = imageArray.count;
        if(imageCount > 9) {
            imageCount = 9;
        }
        arr = [self getCGPointArrayWithNineSudoWithSize:size subImgSize:subImgSize imageCount:imageCount seperateWidth:seperateWidth];
    }
    return arr;
}

//1图片的布局
- (NSArray *)getCGPointArrayWithOneSudoWithSize:(CGSize)size subImgSize:(CGSize)subImgSize seperateWidth:(CGFloat)seperateWidth
{
    CGPoint point1 = CGPointMake((size.width-subImgSize.width)/2, (size.height-subImgSize.height)/2);
    return @[[NSValue valueWithCGPoint:point1]];
}

//2张图片的布局
- (NSArray *)getCGPointArrayWithTwoSudoWithSize:(CGSize)size subImgSize:(CGSize)subImgSize seperateWidth:(CGFloat)seperateWidth
{
    CGPoint point1 = CGPointMake(seperateWidth, (size.height-subImgSize.height)/2);
    CGPoint point2 = CGPointMake(subImgSize.width + seperateWidth*2, (size.height-subImgSize.height)/2);
    
    return @[[NSValue valueWithCGPoint:point1], [NSValue valueWithCGPoint:point2]];
}

//3图布局
- (NSArray *)getCGPointArrayWithThreeSudoWithSize:(CGSize)size subImgSize:(CGSize)subImgSize seperateWidth:(CGFloat)seperateWidth
{
    CGPoint point1 = CGPointMake((size.width-subImgSize.width)/2, seperateWidth);
    CGPoint point2 = CGPointMake(seperateWidth, subImgSize.height + seperateWidth*2);
    CGPoint point3 = CGPointMake(subImgSize.width + seperateWidth*2, subImgSize.height + seperateWidth*2);
    
    return @[[NSValue valueWithCGPoint:point1], [NSValue valueWithCGPoint:point2], [NSValue valueWithCGPoint:point3]];
}

//4图布局
- (NSArray *)getCGPointArrayWithFourSudoWithSize:(CGSize)size subImgSize:(CGSize)subImgSize seperateWidth:(CGFloat)seperateWidth
{
    CGPoint point1 = CGPointMake(seperateWidth, seperateWidth);
    CGPoint point2 = CGPointMake(subImgSize.width + seperateWidth*2, seperateWidth);
    CGPoint point3 = CGPointMake(seperateWidth, subImgSize.height + seperateWidth*2);
    CGPoint point4 = CGPointMake(subImgSize.width +seperateWidth*2, subImgSize.height + seperateWidth*2);
    
    return @[[NSValue valueWithCGPoint:point1], [NSValue valueWithCGPoint:point2], [NSValue valueWithCGPoint:point3], [NSValue valueWithCGPoint:point4]];
}

//5图布局
- (NSArray *)getCGPointArrayWithFiveSudoWithSize:(CGSize)size subImgSize:(CGSize)subImgSize seperateWidth:(CGFloat)seperateWidth
{
    CGPoint point1 = CGPointMake((size.width - subImgSize.width*2)/2, (size.height - subImgSize.height*2)/2);
    CGPoint point2 = CGPointMake((size.width - subImgSize.width*2)/2 + subImgSize.width + seperateWidth, (size.height - subImgSize.height*2)/2);
    CGPoint point3 = CGPointMake(seperateWidth, point1.y + subImgSize.height + seperateWidth);
    CGPoint point4 = CGPointMake(subImgSize.height + seperateWidth*2, point1.y + subImgSize.height + seperateWidth);
    CGPoint point5 = CGPointMake(subImgSize.height*2 + (seperateWidth * 3), point1.y + subImgSize.height + seperateWidth);
    
    return @[[NSValue valueWithCGPoint:point1], [NSValue valueWithCGPoint:point2], [NSValue valueWithCGPoint:point3], [NSValue valueWithCGPoint:point4], [NSValue valueWithCGPoint:point5]];
}

//6-9宫格布局
- (NSArray *)getCGPointArrayWithNineSudoWithSize:(CGSize)size subImgSize:(CGSize)subImgSize imageCount:(NSInteger)imageCount seperateWidth:(CGFloat)seperateWidth
{
    NSMutableArray *arr = [NSMutableArray array];
    
    NSInteger count = imageCount;
    NSInteger columnPerRow = 3;
    NSInteger rowPerColumn = 3;
    
    NSInteger columnIndex = 0;
    NSInteger rowIndex = 0;
    NSInteger allRowCount = 0;
    for (NSInteger i = 0; i < count; i ++) {
        
        columnIndex = i % columnPerRow;
        rowIndex = i / columnPerRow;
        
        if (count % columnPerRow == 0) {
            allRowCount = count / columnPerRow;
        } else {
            allRowCount = count / columnPerRow + 1;
        }
        
        CGPoint point = CGPointMake(columnIndex * subImgSize.width + (seperateWidth*(columnIndex + 1)), ((rowPerColumn - allRowCount)*subImgSize.height)/2 + (rowIndex * subImgSize.height) + (seperateWidth *(rowIndex+1)));
        
        [arr addObject:[NSValue valueWithCGPoint:point]];
    }
    
    return arr;
}

@end
