//
//  PublishCom.h
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublishCom : NSObject

- (void)viewInVC:(NSDictionary *)dic;

- (void)showEmergeView:(NSDictionary *)dic;
- (void)hideEmergeView:(NSDictionary *)dic;

#pragma mark - emerge 点击状态控制

- (void)confirmEmerge_state_focusFromAddress:(NSDictionary *)dic;
- (void)confirmEmerge_state_focusToAddress:(NSDictionary *)dic;
- (void)confirmEmerge_state_focusPeople:(NSDictionary *)dic;

#pragma mark - 发布

- (void)checkPublish:(NSDictionary *)dic;
- (void)publishing:(NSDictionary *)dic;

- (void)reset:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
