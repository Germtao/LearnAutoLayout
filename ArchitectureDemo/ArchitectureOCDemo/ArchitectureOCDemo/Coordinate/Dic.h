//
//  Dic.h
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dic : NSObject

+ (Dic *)create;

- (Dic *(^)(NSString *))key;
- (Dic *(^)(id))value;
- (NSMutableDictionary *)done;

@end

NS_ASSUME_NONNULL_END
