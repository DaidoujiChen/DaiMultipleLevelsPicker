//
//  ImageCell.m
//  DaiMultipleLevelsPicker
//
//  Created by DaidoujiChen on 2015/5/28.
//  Copyright (c) 2015年 DaidoujiChen. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = self.image;
    [self.contentView addSubview:imageView];
}

@end
