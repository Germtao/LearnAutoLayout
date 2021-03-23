//
//  UIButton+hook.m
//  TTHook
//
//  Created by QDSG on 2021/3/23.
//

#import "UIButton+hook.h"
#import "TTHook.h"

@implementation UIButton (hook)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL fromSelector = @selector(sendAction:to:forEvent:);
        SEL toSelector = @selector(hook_sendAction:to:forEvent:);
        [TTHook hookClass:self fromSelector:fromSelector toSelector:toSelector];
    });
}

#pragma mark - toSelctor

- (void)hook_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [self insertToSendAction:action to:target forEvent:event];
    [self hook_sendAction:action to:target forEvent:event];
}

#pragma mark - 埋点

- (void)insertToSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    // 日志记录
    if ([[[event allTouches] anyObject] phase] == UITouchPhaseEnded) {
        NSString *actionString = NSStringFromSelector(action);
        NSString *targetName = NSStringFromClass([target class]);
        // 通过 “action 选择器名 NSStringFromSelector(action)” + “视图类名 NSStringFromClass([target class])”组合成一个唯一的标识，来进行埋点记录
        NSLog(@"sendAction:to:forEvent: - %@ - %@", targetName, actionString);
    }
}

@end
