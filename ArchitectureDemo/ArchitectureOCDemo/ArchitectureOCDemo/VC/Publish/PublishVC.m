//
//  PublishVC.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/19.
//

#import "PublishVC.h"
#import "Coordinate+Publish.h"

@interface PublishVC ()

@property (nonatomic, strong) Coordinate *coordinate;

@end

@implementation PublishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.coordinate publishInVC:self];
}

- (Coordinate *)coordinate {
    if (!_coordinate) {
        _coordinate = [Coordinate new];
    }
    return _coordinate;
}

@end
