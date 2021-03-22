//
//  BridgeVC.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/22.
//

#import "BridgeVC.h"
#import "FieryDragon.h"
#import "RedFieryDragonAbility.h"
#import "BlackFieryDragonAbility.h"

@interface BridgeVC ()

@end

@implementation BridgeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    FieryDragon *fieryDragon = [[FieryDragon alloc] init];
    
    fieryDragon.dragonAblility = [[RedFieryDragonAbility alloc] init];
    [fieryDragon fly];
    [fieryDragon fire];
    [fieryDragon eat];
    
    fieryDragon.dragonAblility = [[BlackFieryDragonAbility alloc] init];
    [fieryDragon fly];
    [fieryDragon fire];
    [fieryDragon eat];
}

@end
