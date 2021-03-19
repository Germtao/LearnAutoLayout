//
//  Dragon.h
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Dragon <NSObject>

- (NSString *)fly;

- (NSString *)fire;

- (NSString *)eat;

- (UIColor *)color;

@end

NS_ASSUME_NONNULL_END
