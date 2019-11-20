//
//  YMCodeTextView.m
//  YMCodeTextDemo
//
//  Copyright © 2019 Yormo. All rights reserved.
//

#import "YMCodeTextView.h"

#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16)) / 255.0 green:(((s & 0xFF00) >> 8)) / 255.0 blue:((s & 0xFF)) / 255.0 alpha:1.0]


@interface YMCodeTextView ()

@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat itemMargin;

@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, weak) UIControl *maskView;

@property (nonatomic, strong) NSMutableArray<UILabel *> *labels;

@end

@implementation YMCodeTextView

#pragma mark - 初始化
- (instancetype)initWithCount:(NSInteger)count
                    itemWidth:(CGFloat)width
                   itemHeight:(CGFloat)height
                       margin:(CGFloat)margin {
    if (self = [super init]) {

        self.itemCount = count;
        self.width = width;
        self.height = height;
        self.itemMargin = margin;

        [self configTextField];
    }
    return self;
}

- (void)configTextField {
    self.backgroundColor = [UIColor clearColor];

    self.labels = @[].mutableCopy;

    UITextField *textField = [[UITextField alloc] init];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    if (@available(iOS 12.0, *)) {
        textField.textContentType = UITextContentTypeOneTimeCode;
    } else {
        textField.textContentType = @"one-time-code";
    }
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [textField addTarget:self action:@selector(tfEditingChanged:) forControlEvents:(UIControlEventEditingChanged)];
    textField.textColor = [UIColor clearColor];
    textField.tintColor = [UIColor clearColor];
    [self addSubview:textField];
    self.textField = textField;

    UIButton *maskView = [UIButton new];
    maskView.backgroundColor = [UIColor clearColor];
    [maskView addTarget:self action:@selector(clickMaskView) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:maskView];
    self.maskView = maskView;

    for (NSInteger i = 0; i < self.itemCount; i++) {
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = UIColorFromHex(0x333333);
        label.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:9];
        label.layer.cornerRadius = 4;
        label.backgroundColor = UIColorFromHex(0xE9EAB0);
        [self addSubview:label];
        [self.labels addObject:label];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.labels.count != self.itemCount)
        return;

    CGFloat w = self.width;
    CGFloat x = (self.bounds.size.width - (self.itemMargin * (self.itemCount - 1)) - self.itemCount * w) / 2;

    for (NSInteger i = 0; i < self.labels.count; i++) {
        UILabel *label = self.labels[i];
        label.frame = CGRectMake(x, 0, self.width, self.height);
        x += self.itemMargin + w;
    }

    self.textField.frame = self.bounds;
    self.maskView.frame = self.bounds;
}

#pragma mark - 编辑改变
- (void)tfEditingChanged:(UITextField *)textField {
    if (textField.text.length > self.itemCount) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, self.itemCount)];
    }

    for (int i = 0; i < self.itemCount; i++) {
        UILabel *label = [self.labels objectAtIndex:i];

        if (i < textField.text.length) {
            label.text = [textField.text substringWithRange:NSMakeRange(i, 1)];
        } else {
            label.text = nil;
        }
    }

    // 输入完毕后，自动隐藏键盘
    if (textField.text.length >= self.itemCount) {
        [textField resignFirstResponder];
    }
}

- (void)clickMaskView {
    [self.textField becomeFirstResponder];
}

- (BOOL)endEditing:(BOOL)force {
    [self.textField endEditing:force];
    return [super endEditing:force];
}

- (NSString *)code {
    return self.textField.text;
}


@end
