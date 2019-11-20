//
//  YMCodeTextView.h
//  YMCodeTextDemo
//
//  Copyright © 2019 Yormo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMCodeTextView : UIView

- (instancetype)initWithCount:(NSInteger)count
                    itemWidth:(CGFloat)width
                    itemHeight:(CGFloat)height
                       margin:(CGFloat)margin;

@end

NS_ASSUME_NONNULL_END
