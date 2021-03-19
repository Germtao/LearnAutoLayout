//
//  LabelCom.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/19.
//

#import "LabelCom.h"

@implementation LabelCom

- (UILabel *)configLabel:(NSDictionary *)dic {
    UILabel *label = [UILabel new];
    NSString *text = dic[@"text"];
    UIColor *textColor = dic[@"textColor"];
    if (text) {
        label.text = text;
    } else {
        label.text = @"label";
    }
    if (textColor) {
        label.textColor = textColor;
    } else {
        label.textColor = [UIColor blackColor];
    }
    return label;
}

@end
