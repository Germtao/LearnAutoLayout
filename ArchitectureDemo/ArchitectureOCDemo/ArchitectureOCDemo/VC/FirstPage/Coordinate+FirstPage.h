//
//  Coordinate+FirstPage.h
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/22.
//

#import "Coordinate.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Coordinate (FirstPage)

- (void)firstViewInVC:(UIViewController *)vc;
- (void)firstViewAppear;

@end

NS_ASSUME_NONNULL_END
