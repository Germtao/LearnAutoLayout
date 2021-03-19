//
//  AopLogCom.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/19.
//

#import "AopLogCom.h"

@implementation AopLogCom

- (void)aopAppearLog:(NSDictionary *)dic {
    NSLog(@"aop appear good.");
}
- (void)aopFactorySetTitle:(NSDictionary *)dic {
    NSLog(@"aop factory was set title.");
}

- (void)emergeLog:(NSDictionary *)dic {
    NSString *actionState = dic[@"actionState"];
    NSLog(@"emerge %@", actionState);
}

@end
