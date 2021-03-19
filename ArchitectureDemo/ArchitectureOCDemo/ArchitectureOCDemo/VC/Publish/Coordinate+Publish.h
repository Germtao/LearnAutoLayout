//
//  Coordinate+Publish.h
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/19.
//

#import "Coordinate.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Coordinate (Publish)

- (void)publishInVC:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
