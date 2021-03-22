//
//  FirstPageVC.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/19.
//

#import "FirstPageVC.h"
#import "Coordinate+FirstPage.h"

@interface FirstPageVC ()

@property (nonatomic, strong) Coordinate *coordinate;

@end

@implementation FirstPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.coordinate firstViewInVC:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.coordinate firstViewAppear];
}

#pragma mark - getter

- (Coordinate *)coordinate {
    if (!_coordinate) {
        _coordinate = [Coordinate new];
    }
    return _coordinate;
}

@end
