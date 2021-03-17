//
//  TTPartView.h
//  TTStackView
//
//  Created by QDSG on 2021/3/16.
//

#import <Foundation/Foundation.h>
#import "TTPartMaker.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTPartView : NSObject

@property (nonatomic, strong) TTPartMaker *maker;

+ (TTPartView *)createView:(void(^)(TTPartMaker *make))partMaker;

@end

NS_ASSUME_NONNULL_END
