//
//  RedDragonFactory.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/19.
//

#import "RedDragonFactory.h"
#import "RedDragon.h"

@implementation RedDragonFactory

- (id<Dragon>)newDragon {
    return [[RedDragon alloc] init];
}

@end
