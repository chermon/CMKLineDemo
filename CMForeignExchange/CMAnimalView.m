//
//  CMAnimalView.m
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/18.
//  Copyright © 2020 梦. All rights reserved.
//

#import "CMAnimalView.h"

@implementation CMAnimalView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self creatAnimal];
    }
    return self;
}

- (void)creatAnimal
{
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 21, 9)];
    _imageView.backgroundColor = self.backgroundColor;
    _imageView.center = CGPointMake(self.viewWidth/2.0, self.viewHeight/2.0);

    _imageView.animationImages = @[[UIImage imageNamed:@"loading_0"],[UIImage imageNamed:@"loading_1"],[UIImage imageNamed:@"loading_2"]];
    _imageView.animationDuration = 1.3;
    _imageView.animationRepeatCount = 0;
    [_imageView startAnimating];
    [self addSubview:_imageView];
}
- (void)hide
{
    self.hidden = YES;
}
- (void)show
{
    self.hidden = NO;
}

@end
