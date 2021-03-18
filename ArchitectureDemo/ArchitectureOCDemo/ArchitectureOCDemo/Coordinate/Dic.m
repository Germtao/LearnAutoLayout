//
//  Dic.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/18.
//

#import "Dic.h"

@interface Dic ()

@property (nonatomic, strong) NSMutableDictionary *chainDic;

@property (nonatomic, strong) NSString *chainCurrentKey;

@end

@implementation Dic

+ (Dic *)create {
    return [[Dic alloc] init];
}

- (Dic * _Nonnull (^)(NSString * _Nonnull))key {
    return ^Dic *(NSString *pKey) {
        self.chainCurrentKey = pKey;
        return self;
    };
}

- (Dic * _Nonnull (^)(id _Nonnull))value {
    return ^Dic *(id pValue) {
        self.chainDic[self.chainCurrentKey] = pValue;
        return self;
    };
}

- (NSMutableDictionary *)done {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.chainDic];
    self.chainDic = [NSMutableDictionary new];
    return dict;
}

#pragma mark - getter

- (NSMutableDictionary *)chainDic {
    if (!_chainDic) {
        _chainDic = [NSMutableDictionary dictionary];
    }
    return _chainDic;
}

@end
