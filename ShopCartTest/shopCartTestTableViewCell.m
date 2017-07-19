//
//  shopCartTestTableViewCell.m
//  ShopCartTest
//
//  Created by ygkj on 2017/7/15.
//  Copyright © 2017年 ygkj. All rights reserved.
//

#import "shopCartTestTableViewCell.h"
#import "Masonry.h"
@implementation shopCartTestTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.selectBtn];
        [self addSubview:self.titleLb];
        [self addSubview:self.money];
        [self addSubview:self.detailInforLabel];
        [self addSubview:self.iconImage];
        [self addSubview:self.countView];

        [self MakeAutoLayerOuter];
    }
    return self;
}
#pragma mark -自定义方法
-(void)setModel:(ShopCartAllDataModel *)model
{
    _model=model;
    self.titleLb.text = [NSString stringWithFormat:@"%@",_model.goods_name];
    self.detailInforLabel.text = [NSString stringWithFormat:@"%@",_model.goods_attr];
    self.money.text = [NSString stringWithFormat:@"%@",_model.formated_market_price];
    if (!model.checked) {
        
        self.selectBtn.selected = NO;
    }else{
        self.selectBtn.selected = YES;

    }
}
-(void)goto_supplier{
        
    if (_delegate) {
        [self.delegate singleClickWithCell:self];
    }
}
-(void)clickaddBtn{
    
    if (_delegate) {
        [self.delegate clickCountViewAddBtnWithCell:self WithCountView:self.countView];
    }
}
-(void)clickreduceBtn{
    
    if (_delegate) {
        [self.delegate clickCountViewReduceBtnWithCell:self WithCountView:self.countView];
    }
}

#pragma mark========Setter/Getter方法===========
-(UIButton*)selectBtn
{
    if (!_selectBtn) {
        _selectBtn=[UIButton new];
        UIImage *btimg = [UIImage imageNamed:@"未选@2x"];
        UIImage *selectImg = [UIImage imageNamed:@"选中@2x"];
        [_selectBtn setImage:btimg forState:UIControlStateNormal];
        [_selectBtn setImage:selectImg forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(goto_supplier) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

-(UILabel*)titleLb
{
    if (!_titleLb) {
        _titleLb=[UILabel new];
        _titleLb.textColor=[UIColor blackColor];
        _titleLb.font=[UIFont systemFontOfSize:15];
        _titleLb.numberOfLines = 0;
//        _titleLb.adjustsFontSizeToFitWidth =YES;
        _titleLb.text =@"这是一条测试的商品信息";
    }
    return _titleLb;
}
-(UILabel*)money
{
    if (!_money) {
        _money=[UILabel new];
        _money.textColor=[UIColor redColor];
        _money.font=[UIFont systemFontOfSize:14];
        _money.numberOfLines = 0;
        _money.adjustsFontSizeToFitWidth =YES;
        _money.text =@"￥100";
    }
    return _money;
}

-(UILabel*)detailInforLabel
{
    if (!_detailInforLabel) {
        _detailInforLabel=[UILabel new];
        _detailInforLabel.textColor=[UIColor grayColor];
        _detailInforLabel.font=[UIFont systemFontOfSize:12];
        _detailInforLabel.numberOfLines = 0;
//        _detailInforLabel.adjustsFontSizeToFitWidth =YES;
        _detailInforLabel.text =@"这是一条测试商品规格信息";
    }
    return _detailInforLabel;
}
-(UIImageView*)iconImage
{
    if (!_iconImage) {
        _iconImage=[UIImageView new];
        _iconImage.image =[UIImage imageNamed:@"图片加载失败.png"];
    }
    return _iconImage;
}
-(countNumView*)countView
{
    if (!_countView) {
        _countView=[countNumView new];
        [_countView.addBtn addTarget:self action:@selector(clickaddBtn) forControlEvents:UIControlEventTouchUpInside];
        [_countView.reduceBtn addTarget:self action:@selector(clickreduceBtn) forControlEvents:UIControlEventTouchUpInside];

    }
    return _countView;
}
-(void)MakeAutoLayerOuter{
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.mas_top).offset(67/2.0);
        make.width.height.equalTo(@20);
    }];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectBtn.mas_right).offset(6);
        make.top.equalTo(self.mas_top).offset(12);
        make.width.height.equalTo(@(124/2.0));
    }];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImage.mas_right).offset(6);
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(self.mas_top).offset(12);
        make.height.equalTo(@15);
    }];
    [self.detailInforLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImage.mas_right).offset(6);
        make.right.equalTo(self.mas_right).offset(-11);
        make.top.equalTo(self.titleLb.mas_bottom).offset(4);
        make.height.equalTo(@10);
    }];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImage.mas_right).offset(6);
        make.top.equalTo(self.detailInforLabel.mas_bottom).offset(17);
        make.height.equalTo(@15);
        make.width.equalTo(@100);

    }];
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.detailInforLabel.mas_bottom).offset(8);
        make.height.equalTo(@25);
        make.width.equalTo(@102);
        
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
