//
//  FieryDragon.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/22.
//

#import "FieryDragon.h"

@implementation FieryDragon

- (void)fly {
    [self.dragonAblility fly];
}

- (void)fire {
    [self.dragonAblility fire];
}

- (void)eat {
    [self.dragonAblility eat];
}

- (void)action {
    [self.dragonAblility fly];
    [self.dragonAblility fire];
    [self.dragonAblility eat];
}

@end
