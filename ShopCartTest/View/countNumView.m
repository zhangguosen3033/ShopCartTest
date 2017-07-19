//
//  countNumView.m
//  ShopCartTest
//
//  Created by ygkj on 2017/7/18.
//  Copyright © 2017年 ygkj. All rights reserved.
//

#import "countNumView.h"
#import "Masonry.h"
@implementation countNumView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.addBtn];
        [self addSubview:self.reduceBtn];
        [self addSubview:self.countTextfiled];
        
        [self MakeAutoLayerOuter];

    }
    return self;
}

-(UIButton*)addBtn
{
    if (!_addBtn) {
        _addBtn=[UIButton new];
//        [_addBtn addTarget:self action:@selector(clickaddBtn) forControlEvents:UIControlEventTouchUpInside];
        [_addBtn setImage:[UIImage imageNamed:@"加号@2x"] forState:UIControlStateNormal];
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"加号方形@2x"] forState:UIControlStateNormal];
    }
    return _addBtn;
}
-(UIButton*)reduceBtn
{
    if (!_reduceBtn) {
        _reduceBtn=[UIButton new];
//        [_reduceBtn addTarget:self action:@selector(clickreduceBtn) forControlEvents:UIControlEventTouchUpInside];
        [_reduceBtn setImage:[UIImage imageNamed:@"减号-@2x"] forState:UIControlStateNormal];
        [_reduceBtn setBackgroundImage:[UIImage imageNamed:@"减号方形@2x"] forState:UIControlStateNormal];
    }
    return _reduceBtn;
}

-(UITextField*)countTextfiled
{
    if (!_countTextfiled) {
        _countTextfiled=[UITextField new];
        [_countTextfiled setBackground:[UIImage imageNamed:@"数字方形@2x"]];
        _countTextfiled.text = @"1";
        _countTextfiled.textAlignment = NSTextAlignmentCenter;
        _countTextfiled.adjustsFontSizeToFitWidth =YES;
        
    }
    return _countTextfiled;
}



-(void)MakeAutoLayerOuter{
    
    [self.reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.width.height.equalTo(@25);
    }];
    [self.countTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.reduceBtn.mas_right).offset(0.5);
        make.top.equalTo(self);
        make.height.equalTo(@25);
        make.width.equalTo(@50);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.countTextfiled.mas_right).offset(0.5);
        make.top.equalTo(self);
        make.width.height.equalTo(@25);
    }];

}
@end
