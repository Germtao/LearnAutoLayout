//
//  Coordinate+FirstPage.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/22.
//

#import "Coordinate+FirstPage.h"

@implementation Coordinate (FirstPage)

- (void)firstViewInVC:(UIViewController *)vc {
    // middleware
    [self configMiddlewares];
    
    // 设置 vc
    // 添加 factoryVC 按钮
    NSString *factoryTitle = self.dispatch(CoordinateAction.classMethodIs(@"VCGeneratorCom stateVCTitle"));
    UIViewController *factoryVC = self.dispatch(CoordinateAction.classMethodIs(@"VCGeneratorCom stateVC"));
    
    // Publish 按钮
    NSString *publishTitle = [self classMethod:@"VCGeneratorCom publishVCTitle"];
    UIViewController *publishVC = [self classMethod:@"VCGeneratorCom publishVC"];
    
    NSMutableDictionary *map = Dic.create.key(@"vc").value(vc)
    
    // factory 按钮
    .key(@"factoryMethodButton").value(self.dispatch(CoordinateAction.classMethodIs(@"ButtonCom configButton").parametersIs(Dic.create.key(@"text").value(factoryTitle).key(@"action").value(^(void) {
        self.dispatch(CoordinateAction.classMethodIs(@"FirstListCom pushVC").parametersIs(Dic.create.key(@"vc").value(vc).key(@"toVc").value(factoryVC).done));
    }).done)))
    
    // publish 按钮
    .key(@"publishButton").value(self.dispatch(CoordinateAction.classMethodIs(@"ButtonCom configButton").parametersIs(Dic.create.key(@"text").value(publishTitle).key(@"action").value(^(void) {
        self.dispatch(CoordinateAction.classMethodIs(@"FirstListCom pushVC").parametersIs(Dic.create.key(@"vc").value(vc).key(@"toVc").value(publishVC).done));
    }).done)))
    
    .done;
    
    // 组装
    self.dispatch(CoordinateAction.classMethodIs(@"FirstListCom viewInVC").parametersIs(map).toStateIs(@"0"));
    
    self.dispatch(CoordinateAction.classMethodIs(@"FirstListCom simRequest").parametersIs(Dic.create.key(@"action").value(^(void) {
        NSLog(@"first view in vc current state = %@", self.currentState);
    }).done))
}

- (void)firstViewAppear {
    self.updateCurrentState([NSString stringWithFormat:@"%ld", self.currentState.integerValue + 1]);
    NSLog(@"first page current state = %@", self.currentState);
    self.dispatch(CoordinateAction.classMethodIs(@"FirstListCom diffStateShow"));
}

- (void)configMiddlewares {
    // 也可以通过 prefix suffix 或正则等规则生成这样一份映射表
    self.middleware(@"FirstListCom viewInVC").addMiddlewareAction(CoordinateAction.classMethodIs(@"AppLogCom aopAppearLog"));
    self.middleware(@"VCGeneratorCom factoryMethodVCTitle").addMiddlewareAction(CoordinateAction.classMethodIs(@"AppLogCom aopFactorySetTitle"));
}

@end
