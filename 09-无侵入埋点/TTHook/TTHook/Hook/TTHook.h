//
//  TTHook.h
//  TTHook
//
//  Created by QDSG on 2021/3/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTHook : NSObject

+ (void)hookClass:(Class)classObject fromSelector:(SEL)fromSelector toSelector:(SEL)toSelector;

@end

NS_ASSUME_NONNULL_END
