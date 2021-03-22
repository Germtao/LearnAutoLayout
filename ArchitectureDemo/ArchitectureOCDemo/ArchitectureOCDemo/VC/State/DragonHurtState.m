//
//  DragonHurtState.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/22.
//

#import "DragonHurtState.h"
#import "DragonFight.h"
#import "DragonAtTheLastGaspState.h"

@implementation DragonHurtState

- (void)dealWithEnemy:(DragonFight *)dragonFight {
    if (dragonFight.energy > 60) {
        NSLog(@"dragon is hurt and keep fight with fire.");
    } else {
        dragonFight.dragonState = [[DragonAtTheLastGaspState alloc] init];
        [dragonFight fight];
    }
}

@end
