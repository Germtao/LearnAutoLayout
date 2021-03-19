//
//  FactoryMethodVC.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/19.
//

#import "FactoryMethodVC.h"
#import "BlackDragonFactory.h"
#import "RedDragonFactory.h"
#import <Masonry/Masonry.h>

@interface FactoryMethodVC ()

@property (nonatomic, strong) UILabel *dragonLabel;

@property (nonatomic, strong) id<DragonFactory> dragonFactory;

@end

@implementation FactoryMethodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.dragonLabel];
    [self.dragonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
    }];
    
    BOOL isRed = YES;
    if (isRed) {
        self.dragonFactory = [[RedDragonFactory alloc] init];
    } else {
        self.dragonFactory = [[BlackDragonFactory alloc] init];
    }
    id<Dragon> dragon = [self.dragonFactory newDragon];
    
    self.dragonLabel.text = dragon.eat;
    self.dragonLabel.textColor = dragon.color;
}

- (UILabel *)dragonLabel {
    if (!_dragonLabel) {
        _dragonLabel = [[UILabel alloc] init];
    }
    return _dragonLabel;
}

@end
