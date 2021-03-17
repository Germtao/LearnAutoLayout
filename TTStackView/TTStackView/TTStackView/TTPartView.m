//
//  TTPartView.m
//  TTStackView
//
//  Created by QDSG on 2021/3/16.
//

#import "TTPartView.h"
#import <UIImageView+WebCache.h>
#import <Masonry/Masonry.h>
#import "UIImage+Color.h"
#import "UIColor+HexString.h"

@implementation TTPartView

+ (TTPartView *)createView:(void (^)(TTPartMaker * _Nonnull))partMaker {
    TTPartView *partView = [[self alloc] init];
    partView.maker = [[TTPartMaker alloc] init];
    partMaker(partView.maker);
    [partView buildPartView];
    return partView;
}

#pragma mark - private

- (TTPartView *)buildPartView {
    if (self.maker.image) {
        
        if (self.maker.view) {
            if ([self.maker.view isKindOfClass:[UIImageView class]]) {
                [self updateImageView:(UIImageView *)self.maker.view];
            }
        } else {
            UIImageView *imageView = [[UIImageView alloc] init];
            [self updateImageView:imageView];
            self.maker.view = imageView;
        }
        
    }
    else if (self.maker.text.length > 0 || self.maker.font) {
        
        if (self.maker.view) {
            if ([self.maker.view isKindOfClass:[UILabel class]]) {
                [self updateLabel:(UILabel *)self.maker.view];
            }
        } else {
            UILabel *label = [[UILabel alloc] init];
            [self updateLabel:label];
            self.maker.view = label;
        }
        
    }
    
    // 处理有背景的情况
    if (self.maker.backColor || self.maker.backPaddingHorizontal || self.maker.backPaddingVertical) {
        
        UIView *backView = [[UIView alloc] init];
        if (self.maker.backColor) {
            backView.backgroundColor = self.maker.backColor;
        } else {
            backView.backgroundColor = [UIColor clearColor];
        }
        
        UIView *view = self.maker.view;
        CGFloat paddingV = self.maker.backPaddingVertical;
        CGFloat paddingH = self.maker.backPaddingHorizontal;
        [backView addSubview:view];
        
        if (paddingV > 0 || paddingH > 0) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(backView).offset(paddingH);
                make.right.equalTo(backView).offset(-paddingH);
                make.top.equalTo(backView).offset(paddingV);
                make.bottom.equalTo(backView).offset(-paddingV);
            }];
        } else {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(backView);
            }];
        }
        
        // 设置边线
        if (self.maker.backBoardColor) {
            backView.layer.borderColor = self.maker.backBoardColor.CGColor;
        }
        
        if (self.maker.backBoardWidth > 0) {
            backView.layer.borderWidth = self.maker.backBoardWidth;
        }
        
        if (self.maker.backBoardRadius > 0) {
            backView.layer.cornerRadius = self.maker.backBoardRadius;
        }
        
        self.maker.view = backView;
    }
    
    // 处理有button的情况
    if (self.maker.button) {
        [self.maker.view addSubview:self.maker.button];
        if (self.maker.buttonHighlightColor) {
            // 点击效果
            [self.maker.button setBackgroundImage:[UIImage imageWithColor:self.maker.buttonHighlightColor]
                                         forState:UIControlStateHighlighted];
        } else {
            [self.maker.button setBackgroundImage:[UIImage imageWithColor:[[UIColor colorWithHexString:@"000000"] colorWithAlphaComponent:0.05]]
                                         forState:UIControlStateHighlighted];
        }
        [self.maker.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.maker.view);
        }];
    }
    return self;
}

- (void)updateLabel:(UILabel *)label {
    label.text = self.maker.text;
    label.textColor = self.maker.color;
    label.font = self.maker.font;
}

- (void)updateImageView:(UIImageView *)imageView {
    if (self.maker.imageUrl.length > 0) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.maker.imageUrl] placeholderImage:self.maker.imagePlaceholder];
    } else {
        [imageView setImage:self.maker.image];
    }
}

@end
