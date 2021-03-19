//
//  BlackDragonFactory.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/19.
//

#import "BlackDragonFactory.h"
#import "BlackDragon.h"

@implementation BlackDragonFactory

- (id<Dragon>)newDragon {
    return [[BlackDragon alloc] init];
}

@end
