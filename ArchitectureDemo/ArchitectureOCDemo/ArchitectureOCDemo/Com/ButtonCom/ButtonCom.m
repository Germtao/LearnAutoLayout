//
//  ButtonCom.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/19.
//

#import "ButtonCom.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation ButtonCom

- (UIButton *)configButton:(NSDictionary *)dic {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *text = dic[@"text"];
    void(^action)(void) = dic[@"action"];
    UIColor *textColor = dic[@"textColor"];
    UIColor *bgColor = dic[@"bgColor"];
    if (text) {
        [button setTitle:text forState:UIControlStateNormal];
    } else {
        [button setTitle:@"Button" forState:UIControlStateNormal];
    }
    if (textColor) {
        button.titleLabel.textColor = textColor;
    } else {
        button.titleLabel.textColor = [UIColor whiteColor];
    }
    if (bgColor) {
        button.backgroundColor = bgColor;
    } else {
        button.backgroundColor = [UIColor blackColor];
    }
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (action) {
            action();
        }
    }];
    return button;
}

@end
