//
//  DragonAbility.h
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DragonAbility <NSObject>

- (void)fly;
- (void)fire;
- (void)eat;

@end

NS_ASSUME_NONNULL_END
