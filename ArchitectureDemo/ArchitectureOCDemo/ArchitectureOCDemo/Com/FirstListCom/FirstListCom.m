//
//  FirstListCom.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/19.
//

#import "FirstListCom.h"
#import <Masonry/Masonry.h>

@implementation FirstListCom

- (void)viewInVc:(NSDictionary *)dic {
    UIViewController *vc = dic[@"vc"];
    UIButton *fmBtn = dic[@"factoryMethodButton"];
    [vc.view addSubview:fmBtn];
    [fmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(vc.view);
        make.top.equalTo(vc.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(200, 55));
    }];
    
    UIButton *pBtn = dic[@"publishButton"];
    [vc.view addSubview:pBtn];
    [pBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(vc.view);
        make.top.equalTo(fmBtn.mas_bottom).offset(50);
        make.size.mas_equalTo(CGSizeMake(200, 55));
    }];
}

- (void)pushVC:(NSDictionary *)dic {
    UIViewController *vc = dic[@"vc"];
    UIViewController *toVc = dic[@"toVc"];
    [vc.navigationController pushViewController:toVc animated:true];
}

#pragma mark - demo subscriber

- (void)inVCSubscriberDispatch:(NSDictionary *)dic {
    NSLog(@"inVc subscriber dispatch.");
}

- (void)outVCSubscriberDispatch:(NSDictionary *)dic {
    NSLog(@"outVc subscriber dispatch.");
}

- (void)simRequest:(NSDictionary *)dic {
    void (^action)(void) = dic[@"action"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        action();
    });
}

#pragma mark - demo state

- (void)diffStateShow:(NSDictionary *)dic {
    NSLog(@"current state is 0, diffStateShow.");
}

- (void)diffStateShow_state_1:(NSDictionary *)dic {
    NSLog(@"current state is 1, diffStateShow_state_1.");
}

- (void)diffStateShow_state_2:(NSDictionary *)dic {
    NSLog(@"current state is 2, diffStateShow_state_2.");
}

@end
