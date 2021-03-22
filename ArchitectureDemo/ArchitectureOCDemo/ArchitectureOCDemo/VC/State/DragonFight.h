//
//  DragonFight.h
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/22.
//

#import <Foundation/Foundation.h>
#import "DragonState.h"

NS_ASSUME_NONNULL_BEGIN

@interface DragonFight : NSObject

@property (nonatomic, strong) id<DragonState> dragonState;

@property (nonatomic, assign) NSUInteger energy;

@property (nonatomic, assign) BOOL isWin;

- (void)fight;

@end

NS_ASSUME_NONNULL_END
