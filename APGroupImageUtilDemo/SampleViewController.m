//
//  SampleViewController.m
//  GroupAvatarDemo
//
//  Created by LUOCHENG DE on 15/12/19.
//  Copyright © 2015年 Kate. All rights reserved.
//

#import "SampleViewController.h"
#import "APGroupImageUtil.h"

@interface SampleViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iv1;
@property (weak, nonatomic) IBOutlet UIImageView *iv2;
@property (weak, nonatomic) IBOutlet UIImageView *iv3;
@property (weak, nonatomic) IBOutlet UIImageView *iv4;
@property (weak, nonatomic) IBOutlet UIImageView *iv5;
@property (weak, nonatomic) IBOutlet UIImageView *iv6;
@property (weak, nonatomic) IBOutlet UIImageView *iv7;
@property (weak, nonatomic) IBOutlet UIImageView *iv8;
@property (weak, nonatomic) IBOutlet UIImageView *iv9;

@end

@implementation SampleViewController
{
    NSArray *_imageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _imageArray = @[@"Group.bundle/1.png", @"Group.bundle/2.png", @"Group.bundle/3.png", @"Group.bundle/4.png", @"Group.bundle/5.png", @"Group.bundle/6.png", @"Group.bundle/7.png", @"Group.bundle/8.png", @"Group.bundle/9.png"];
    
    [self setImgWithIV:self.iv1 imageCount:1];
    [self setImgWithIV:self.iv2 imageCount:2];
    [self setImgWithIV:self.iv3 imageCount:3];
    [self setImgWithIV:self.iv4 imageCount:4];
    [self setImgWithIV:self.iv5 imageCount:5];
    [self setImgWithIV:self.iv6 imageCount:6];
    [self setImgWithIV:self.iv7 imageCount:7];
    [self setImgWithIV:self.iv8 imageCount:8];
    [self setImgWithIV:self.iv9 imageCount:9];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setImgWithIV:(UIImageView *)iv imageCount:(NSInteger)count
{
    NSMutableArray *imgArray = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i ++) {
        NSString *imgStr = [_imageArray objectAtIndex:i];
        UIImage *uim = [UIImage imageNamed:imgStr];
        [imgArray addObject:uim];
    }
    
    UIImage *img = [[APGroupImageUtil shared] mergeWithImageArray:imgArray size:iv.frame.size backgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];
    [iv setImage:img];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
