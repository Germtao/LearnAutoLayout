//
//  FieryDragon.h
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/22.
//

#import <Foundation/Foundation.h>
#import "DragonAbility.h"

NS_ASSUME_NONNULL_BEGIN

@interface FieryDragon : NSObject

@property (nonatomic, strong) id<DragonAbility> dragonAblility;

#pragma mark - Bridge

- (void)fly;
- (void)fire;
- (void)eat;

/// builder 组装模式
- (void)action;

@end

NS_ASSUME_NONNULL_END
