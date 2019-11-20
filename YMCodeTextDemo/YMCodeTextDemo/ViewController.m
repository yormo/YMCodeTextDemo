//
//  ViewController.m
//  YMCodeTextDemo
//
//  Created by 含包阁 on 2019/11/20.
//  Copyright © 2019 Yormo. All rights reserved.
//

#import "ViewController.h"
#import "YMCodeTextView.h"
#define SW ([UIScreen mainScreen].bounds.size.width)
#define SH ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"timg.png"];
    [self.view addSubview:imageView];
    
    CGFloat x = 30;
    CGFloat w = SW - x * 2;
    CGFloat h = 50;
    CGFloat y = (SH - 50) / 2 ;
    
    YMCodeTextView *code2View = [[YMCodeTextView alloc] initWithCount:6 margin:20];
    code2View.frame = CGRectMake(x, y, w, h);
    [self.view addSubview:code2View];
    
    
}


@end
