//
//  FirstListCom.h
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstListCom : NSObject

- (void)viewInVc:(NSDictionary *)dic;
- (void)pushVC:(NSDictionary *)dic;

#pragma mark - demo subscriber

- (void)inVCSubscriberDispatch:(NSDictionary *)dic;
- (void)outVCSubscriberDispatch:(NSDictionary *)dic;

- (void)simRequest:(NSDictionary *)dic;

#pragma mark - demo state

- (void)diffStateShow:(NSDictionary *)dic;
- (void)diffStateShow_state_1:(NSDictionary *)dic;
- (void)diffStateShow_state_2:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
