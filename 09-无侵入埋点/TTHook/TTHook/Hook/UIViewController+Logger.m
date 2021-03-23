//
//  UIViewController+Logger.m
//  TTHook
//
//  Created by QDSG on 2021/3/23.
//

#import "UIViewController+Logger.h"
#import "TTHook.h"

@implementation UIViewController (Logger)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 通过 @selector 获得被替换和替换方法的 SEL，作为 TTHook:hookClass:fromeSelector:toSelector 的参数传入
        SEL fromSelectorAppear = @selector(viewWillAppear:);
        SEL toSelectorAppear = @selector(hook_viewWillAppear:);
        [TTHook hookClass:self fromSelector:fromSelectorAppear toSelector:toSelectorAppear];
        
        SEL fromSelectorDisappear = @selector(viewWillDisappear:);
        SEL toSelectorDisappear = @selector(hook_viewWillDisappear:);
        [TTHook hookClass:self fromSelector:fromSelectorDisappear toSelector:toSelectorDisappear];
    });
}

#pragma mark - toSelector

- (void)hook_viewWillAppear:(BOOL)animated {
    [self insertToViewWillAppear];
    [self hook_viewWillAppear:animated];
}

- (void)hook_viewWillDisappear:(BOOL)animated {
    [self insertToViewWillDisappear];
    [self hook_viewWillDisappear:animated];
}

#pragma mark - 埋点

- (void)insertToViewWillAppear {
    // 在 viewWillAppear 时进行日志的埋点
    NSLog(@"hook_viewWillAppear - %@", NSStringFromClass([self class]));
}

- (void)insertToViewWillDisappear {
    // 在 viewWillDisappear 时进行日志的埋点
    NSLog(@"hook_viewWillDisappear - %@", NSStringFromClass([self class]));
}

@end
