//
//  StateVC.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/19.
//

#import "StateVC.h"
#import "DragonFight.h"

@interface StateVC ()

@end

@implementation StateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self dragonFight];
}

- (void)dragonFight {
    DragonFight *dragonFight = [[DragonFight alloc] init];
    
    dragonFight.energy = 100;
    [dragonFight fight];
    
    dragonFight.energy = 70;
    [dragonFight fight];
    
    dragonFight.energy = 50;
    [dragonFight fight];
    
    dragonFight.energy = 10;
    [dragonFight fight];
}

@end
