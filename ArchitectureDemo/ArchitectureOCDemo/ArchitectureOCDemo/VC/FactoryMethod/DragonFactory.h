//
//  DragonFactory.h
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/19.
//

#import <Foundation/Foundation.h>
#import "Dragon.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DragonFactory <NSObject>

- (id<Dragon>)newDragon;

@end

NS_ASSUME_NONNULL_END
