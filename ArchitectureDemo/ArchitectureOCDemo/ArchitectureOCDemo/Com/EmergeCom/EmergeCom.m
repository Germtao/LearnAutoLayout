//
//  EmergeCom.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/19.
//

#import "EmergeCom.h"
#import <Masonry/Masonry.h>

@interface EmergeCom ()

@property (nonatomic, strong) UIView *emergeView;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation EmergeCom

- (UIView *)emergeView:(NSDictionary *)dic {
    self.emergeView = [UIView new];
    self.emergeView.backgroundColor = [UIColor lightGrayColor];
    
    self.confirmBtn = dic[@"confirmBtn"];
    if (self.confirmBtn) {
        [self.emergeView addSubview:self.confirmBtn];
        [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.emergeView);
            make.size.mas_equalTo(CGSizeMake(200, 40));
        }];
    }
    return self.emergeView;
}

- (void)updateConfirmBtnTitle:(NSDictionary *)dic {
    NSString *title = dic[@"title"];
    if (!title) {
        title = @"确定";
    }
    [self.confirmBtn setTitle:title forState:UIControlStateNormal];
}

- (NSString *)confirmBtnTitle:(NSDictionary *)dic {
    return [self.confirmBtn titleForState:UIControlStateNormal];
}

@end
