//
//  DragonState.h
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/22.
//

#import <Foundation/Foundation.h>

@class DragonFight;

NS_ASSUME_NONNULL_BEGIN

@protocol DragonState <NSObject>

- (void)dealWithEnemy:(DragonFight *)dragonFight;

@end

NS_ASSUME_NONNULL_END
