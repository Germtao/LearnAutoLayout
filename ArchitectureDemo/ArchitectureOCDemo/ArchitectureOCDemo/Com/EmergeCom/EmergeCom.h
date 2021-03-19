//
//  EmergeCom.h
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *const EmergeCom_emergeView = @"EmergeCom emergeView";
static NSString *const EmergeCom_updateConfirmBtnTitle = @"EmergeCom updateConfirmBtnTitle";
static NSString *const EmergeCom_confirmBtnTitle = @"EmergeCom confirmBtnTitle";

NS_ASSUME_NONNULL_BEGIN

@interface EmergeCom : NSObject

- (UIView *)emergeView:(NSDictionary *)dic;
- (void)updateConfirmBtnTitle:(NSDictionary *)dic;
- (NSString *)confirmBtnTitle:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
