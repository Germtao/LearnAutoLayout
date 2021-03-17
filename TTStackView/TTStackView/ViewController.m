//
//  ViewController.m
//  TTStackView
//
//  Created by QDSG on 2021/3/16.
//

#import "ViewController.h"
#import "TTAssembleView.h"
#import <Masonry/Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) TTAssembleView *assembleView;

@property (nonatomic, copy) NSString *assembleStr;
@property (nonatomic, strong) NSDictionary *assembleMap;
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIButton *clickBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    [self asyncMake];
}

- (void)makeUI {
    self.avatarView = [UIImageView new];
    self.avatarView.clipsToBounds = YES;
    self.avatarView.layer.cornerRadius = 35 / 2;
    self.clickBtn = [UIButton new];
}

- (void)asyncMake {
    self.assembleMap = @{@"avatarView": self.avatarView, @"clickBtn": self.clickBtn};
    
    // 排列居中
    NSString *sizeStr = @"width:25, height:18";
    NSString *centerStr = ASS(@"{hc(padding:30,extendWith:1)[(imageName:starmingicon,%@)][(imageName:starmingicon:%@)][(imageName:starmingicon:%@)]}", sizeStr, sizeStr, sizeStr);
    
    // 嵌套组合布局
    NSString *midStr = @"{ht(padding:10,extendWith:2)[avatarView(imageName:avatar)][{vl(padding:10)[(text:T AO,color:AAA0A3)][(text:哈哈哈哈哈,color:E3DEE0,font:13)][(text:喜欢游戏编程看小说,color:E3DEE0,font:13)]}(width:210,backColor:FAF8F9,backPaddingHorizontal:10,backPaddingVertical:10,radius:8)]}";
    
    // 按钮
    NSString *followBtnStr = @"{hc(padding:4,extendWith:1)[(imageName:starmingicon,width:14,height:10)][(text:关注,font:16,color:FFFFFF)]}";
    
    // 说明区域
    NSString *descStr = @"{hc(padding:5.5,extendWith:1)[(text:TTAssembleView.演示,color:E3DEE0,font:13)][(imageName:starmingicon,width:14,height:10,ignoreAlignment:left)][(text:www.baidu.com,color:E3DEE0,font:13)]}";
    
    // 整体组装
    self.assembleStr = ASS(@"{vc(padding:20)[%@][%@(backColor:AAA0A3,radius:8,backBorderWidth:1,backBorderColor:E3DEE0,backPaddingHorizontal:80,backPaddingVertical:20,button:<clickBtn>)][%@][%@(ignoreAlignment:top,isFill:1)]}", midStr, followBtnStr, centerStr, descStr);
    
    __weak typeof(self) weakSelf = self;
    [TTAssembleView formatStringAsync:self.assembleStr objectsMap:self.assembleMap completion:^(TTAssembleView * assembleView) {
        [weakSelf.view addSubview:assembleView];
        [assembleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.view).offset(30);
            make.left.equalTo(weakSelf.view).offset(20);
            make.right.equalTo(weakSelf.view).offset(-20);
            make.bottom.equalTo(weakSelf.view).offset(-20);
        }];
    }];
}

@end
