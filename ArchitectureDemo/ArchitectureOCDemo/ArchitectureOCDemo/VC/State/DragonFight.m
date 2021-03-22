//
//  DragonFight.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/22.
//

#import "DragonFight.h"
#import "DragonFullEnergyState.h"

@implementation DragonFight

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dragonState = [[DragonFullEnergyState alloc] init];
    }
    return self;
}

- (void)fight {
    [self.dragonState dealWithEnemy:self];
}

@end
