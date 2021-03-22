//
//  DragonFullEnergyState.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/22.
//

#import "DragonFullEnergyState.h"
#import "DragonFight.h"
#import "DragonHurtState.h"

@implementation DragonFullEnergyState

- (void)dealWithEnemy:(DragonFight *)dragonFight {
    if (dragonFight.energy > 80) {
        NSLog(@"dragon fight with full enemy.");
    } else {
        dragonFight.dragonState = [[DragonHurtState alloc] init];
        [dragonFight fight];
    }
}

@end
