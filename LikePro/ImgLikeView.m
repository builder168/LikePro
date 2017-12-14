//
//  ImgLikeView.m
//  LikePro
//
//  Created by builder on 2017/12/14.
//  Copyright © 2017年 builder. All rights reserved.
//

#import "ImgLikeView.h"

@interface ImgLikeView ()

@property (nonatomic,strong) UIImageView *imgView;

@end

@implementation ImgLikeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - setter

- (void)setImgName:(NSString *)imgName{
    [self.imgView setImage:[UIImage imageNamed:imgName]];
}

#pragma mark - getter

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_imgView];
        _imgView.clipsToBounds = YES;
        _imgView.layer.cornerRadius = _imgView.frame.size.height * 0.125*0.25;
    }
    return _imgView;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
