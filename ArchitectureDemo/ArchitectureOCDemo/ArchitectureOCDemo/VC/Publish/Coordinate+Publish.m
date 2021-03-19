//
//  Coordinate+Publish.m
//  ArchitectureOCDemo
//
//  Created by QDSG on 2021/3/19.
//

#import "Coordinate+Publish.h"
#import "EmergeCom.h"
#import "PublishCom.h"
#import "ButtonCom.h"

@implementation Coordinate (Publish)

- (void)publishInVC:(UIViewController *)vc {
    NSMutableDictionary *dic = Dic.create.key(@"vcView").value(vc.view)
    
    // 标题
    .key(@"fromAddressBtn").value(self.dispatch(CoordinateAction.classCheck([ButtonCom class]).methodCheck(@selector(configButton:)).parametersIs(Dic.create.key(@"text").value(@"标题").key(@"action").value(^(void) {
        // 浮层显示
        self.dispatch(CoordinateAction.classMethodIs(EmergeCom_updateConfirmBtnTitle).parametersIs(Dic.create.key(@"title").value(@"成长的烦恼").done));
        self.dispatch(CoordinateAction.classCheck([PublishCom class]).methodCheck(@selector(showEmergeView:)).toStateIs(@"focusTitle"));
    }).done)))
    
    // 内容
    .key(@"toAddressBtn").value(self.dispatch(CoordinateAction.classMethodIs(@"ButtonCom configButton").parametersIs(Dic.create.key(@"text").value(@"内容").key(@"action").value(^(void) {
        self.dispatch(CoordinateAction.classCheck([EmergeCom class]).methodCheck(@selector(updateConfirmBtnTitle:)).parametersIs(Dic.create.key(@"title").value(@"这个说来话长...").done));
        self.dispatch(CoordinateAction.classMethodIs(@"PublishCom showEmergeView").toStateIs(@"focusContent"));
    }).done)))
    
    // 价格
    .key(@"peopleBtn").value(self.dispatch(CoordinateAction.classMethodIs(@"ButtonCom configButton").parametersIs(Dic.create.key(@"text").value(@"价格").key(@"action").value(^(void) {
        self.dispatch(CoordinateAction.classMethodIs(@"EmergeCom updateConfirmBtnTitle").parametersIs(Dic.create.key(@"title").value(@"5毛").done));
        self.dispatch(CoordinateAction.classMethodIs(@"PublishCom showEmergeView").toStateIs(@"focusPrice"));
    }).done)))
    
    // 浮层确认选择
    .key(@"emergeView").value(self.dispatch(CoordinateAction.classMethodIs(@"EmergeCom emergeView").parametersIs(Dic.create.key(@"confirmBtn").value(self.dispatch(CoordinateAction.classMethodIs(@"ButtonCom configButton").parametersIs(Dic.create.key(@"title").value(@"").key(@"action").value(^(void) {
        // 根据状态执行不同的内容
        self.dispatch(CoordinateAction.classMethodIs(@"PublishCom confirmEmerge").parametersIs(Dic.create.key(@"title").value(self.dispatch(CoordinateAction.classMethodIs(@"EmergeCom confirmBtnTitle"))).done));
        self.dispatch(CoordinateAction.classMethodIs(@"PublishCom hideEmergeView").toStateIs(@"emergeHide"));
    }).done))).done)))
    
    // 发布按钮
    .key(@"publishBtn").value(self.dispatch(CoordinateAction.classMethodIs(@"ButtonCom configButton").parametersIs(Dic.create.key(@"text").value(@"发布").key(@"action").value(^(void) {
        self.dispatch(CoordinateAction.classMethodIs(@"PublishCom publishing"));
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self notifyObservers:@"publishOk"];
        });
    }).done)))
    
    .done;
    
    self.dispatch(CoordinateAction.classIs(@"PublishCom").methodIs(@"viewInVC").parametersIs(dic));
    self.dispatch(CoordinateAction.classMethodIs(@"PublishCom checkPublish"));
    
    // 切面
    // 统计
    self.middleware(@"PublishCom showEmergeView").addMiddlewareAction(CoordinateAction.classMethodIs(@"AopLogCom emergeLog").parametersIs(Dic.create.key(@"actionState").value(@"show").done));
    self.middleware(@"PublishCom confirmEmerge").addMiddlewareAction(CoordinateAction.classMethodIs(@"AopLogCom emergeLog").parametersIs(Dic.create.key(@"actionState").value(@"confirm").done));
    
    // 处理是否可发布的逻辑
    self.middleware(@"PublishCom hideEmergeView").addMiddlewareAction(CoordinateAction.classMethodIs(@"PublishCom checkPublish"));
    
    // 观察者管理
    self.observerWithIdentifier(@"publishOk").addObserver(CoordinateAction.classMethodIs(@"PublishCom reset")).addObserver(CoordinateAction.classMethodIs(@"PublishCom checkPublish"));
    
    CoordinateAction *action = CoordinateAction.classCheck([ButtonCom class]).methodCheck(@selector(configButton:));
    action.methodCheck(@selector(configButton:));
}

@end
