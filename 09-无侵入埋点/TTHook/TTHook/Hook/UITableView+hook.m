//
//  UITableView+hook.m
//  TTHook
//
//  Created by QDSG on 2021/3/23.
//

#import "UITableView+hook.h"
#import "TTHook.h"
#import <objc/runtime.h>

@implementation UITableView (hook)

+ (void)load {
    SEL fromSelectorDelegate = @selector(setDelegate:);
    SEL toSelectorDelegate = @selector(hook_setDelegate:);
    [TTHook hookClass:self fromSelector:fromSelectorDelegate toSelector:toSelectorDelegate];
}

#pragma mark - toSelector

- (void)hook_setDelegate:(id<UITableViewDelegate>)delegate {
    [self insertToSetDelegate:delegate];
    [self hook_setDelegate:delegate];
}

- (void)insertToSetDelegate:(id<UITableViewDelegate>)delegate {
    SEL fromSelector = @selector(tableView:didSelectRowAtIndexPath:);
    SEL toSelector = @selector(hook_tableView:didSelectRowAtIndexPath:);
    
    // 被替换类的实例方法
    Method fromMethod = class_getInstanceMethod([delegate class], fromSelector);
    
    // 替换类的实例方法
    Method toMethod = class_getInstanceMethod([self class], toSelector);
    
    // class_addMethod 添加要替换的方法
    class_addMethod([delegate class], toSelector, method_getImplementation(toMethod), method_getTypeEncoding(toMethod));
    
    method_exchangeImplementations(fromMethod, class_getInstanceMethod([delegate class], toSelector));
}

- (void)hook_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"hook did select row at indexpath: (%ld - %ld)", indexPath.section, indexPath.row);
    [self hook_tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
