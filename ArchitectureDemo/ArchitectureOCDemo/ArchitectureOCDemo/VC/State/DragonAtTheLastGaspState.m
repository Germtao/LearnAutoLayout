//
//  DragonAtTheLastGaspState.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/22.
//

#import "DragonAtTheLastGaspState.h"
#import "DragonFight.h"

@implementation DragonAtTheLastGaspState

- (void)dealWithEnemy:(DragonFight *)dragonFight {
    if (dragonFight.energy > 20) {
        NSLog(@"dragon at last gasp, fight with tooth only.");
    } else {
        NSLog(@"dragon can not fight.");
    }
}

@end
