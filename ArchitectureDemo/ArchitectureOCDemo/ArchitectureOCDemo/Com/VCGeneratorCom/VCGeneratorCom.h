//
//  VCGeneratorCom.h
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VCGeneratorCom : NSObject

- (UIViewController *)factoryMethodVC:(NSDictionary *)dic;
- (NSString *)factoryMethodVCTitle:(NSDictionary *)dic;

- (UIViewController *)publishVC:(NSDictionary *)dic;
- (NSString *)publishVCTitle:(NSDictionary *)dic;

- (UIViewController *)stateVC:(NSDictionary *)dic;
- (NSString *)stateVCTitle:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
