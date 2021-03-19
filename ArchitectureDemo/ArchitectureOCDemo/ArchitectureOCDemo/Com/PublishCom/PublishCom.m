//
//  PublishCom.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/19.
//

#import "PublishCom.h"
#import <Masonry/Masonry.h>

@interface PublishCom ()

@property (nonatomic, weak) UIView *vcView;
@property (nonatomic, strong) UIButton *fromAddressBtn;
@property (nonatomic, strong) UIButton *toAddressBtn;
@property (nonatomic, strong) UIButton *peopleBtn;
@property (nonatomic, strong) UIView *emergeView;
@property (nonatomic, strong) UIButton *publishBtn;

@property (nonatomic, strong) UIView *adView;

@end

@implementation PublishCom

- (void)viewInVC:(NSDictionary *)dic {
    self.vcView = dic[@"vcView"];
    self.fromAddressBtn = dic[@"fromAddressBtn"];
    self.toAddressBtn = dic[@"toAddressBtn"];
    self.peopleBtn = dic[@"peopleBtn"];
    self.emergeView = dic[@"emergeView"];
    self.publishBtn = dic[@"publishBtn"];
    
    if (!self.fromAddressBtn || !self.toAddressBtn || !self.peopleBtn || !self.emergeView) {
        return;
    }
    
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor lightGrayColor];
    [self.vcView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vcView).offset(60);
        make.centerX.equalTo(self.vcView);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
    [topView addSubview:self.fromAddressBtn];
    [self.fromAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView).offset(20);
        make.centerX.equalTo(topView);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
    
    [topView addSubview:self.toAddressBtn];
    [self.toAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fromAddressBtn.mas_bottom).offset(20);
        make.centerX.equalTo(topView);
        make.size.equalTo(self.fromAddressBtn);
    }];
    
    [topView addSubview:self.peopleBtn];
    [self.peopleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.toAddressBtn.mas_bottom).offset(20);
        make.centerX.equalTo(topView);
        make.size.mas_equalTo(CGSizeMake(70, 40));
    }];
    
    [self.vcView addSubview:self.publishBtn];
    [self.publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(self.vcView);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    [self.vcView addSubview:self.emergeView];
    [self.emergeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vcView.mas_bottom);
        make.centerX.equalTo(self.vcView);
        make.size.mas_equalTo(CGSizeMake(320, 200));
    }];
}

- (void)showEmergeView:(NSDictionary *)dic {
    [self.emergeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vcView.mas_bottom).offset(-200);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.vcView layoutIfNeeded];
    }];
}
- (void)hideEmergeView:(NSDictionary *)dic {
    [self.emergeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vcView.mas_bottom);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.vcView layoutIfNeeded];
    }];
}

#pragma mark - 状态管理

- (void)confirmEmerge_state_focusFromAddress:(NSDictionary *)dic {
    NSString *title = dic[@"title"];
    [self.fromAddressBtn setTitle:title forState:UIControlStateNormal];
    self.fromAddressBtn.tag = 1;
}

- (void)confirmEmerge_state_focusToAddress:(NSDictionary *)dic {
    NSString *title = dic[@"title"];
    [self.toAddressBtn setTitle:title forState:UIControlStateNormal];
    self.toAddressBtn.tag = 1;
}

- (void)confirmEmerge_state_focusPeople:(NSDictionary *)dic {
    NSString *title = dic[@"title"];
    [self.peopleBtn setTitle:title forState:UIControlStateNormal];
    self.peopleBtn.tag = 1;
}

#pragma mark - 发布

- (void)checkPublish:(NSDictionary *)dic {
    if (self.fromAddressBtn.tag == 1 && self.toAddressBtn.tag == 1 && self.peopleBtn.tag == 1) {
        self.publishBtn.backgroundColor = [UIColor blackColor];
    } else {
        self.publishBtn.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)publishing:(NSDictionary *)dic {
    self.publishBtn.backgroundColor = [UIColor redColor];
}

- (void)reset:(NSDictionary *)dic {
    [self.fromAddressBtn setTitle:@"标题" forState:UIControlStateNormal];
    self.fromAddressBtn.tag = 0;
    
    [self.toAddressBtn setTitle:@"内容" forState:UIControlStateNormal];
    self.toAddressBtn.tag = 0;
    
    [self.peopleBtn setTitle:@"价格" forState:UIControlStateNormal];
    self.peopleBtn.tag = 0;
    
    [UIView animateWithDuration:0.1 animations:^{
        [self.vcView layoutIfNeeded];
    }];
}

@end
