//
//  shopCartTestTableViewCell.h
//  ShopCartTest
//
//  Created by ygkj on 2017/7/15.
//  Copyright © 2017年 ygkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartAllDataModel.h"
#import "countNumView.h"
@protocol shopCartBtnSelcetDelegate <NSObject>
-(void)singleClickWithCell:(UITableViewCell *)cell;

-(void)clickCountViewAddBtnWithCell:(UITableViewCell *)cell WithCountView:(countNumView *)countView;
-(void)clickCountViewReduceBtnWithCell:(UITableViewCell *)cell WithCountView:(countNumView *)countView;

@end
@interface shopCartTestTableViewCell : UITableViewCell

@property(nonatomic,strong)UIButton * selectBtn;
@property(nonatomic,strong)UILabel * titleLb;
@property(nonatomic,strong)UILabel * money;//价格
@property(nonatomic,strong)UILabel * detailInforLabel;//规格
@property(nonatomic,strong)UIImageView * iconImage;//右侧图像
@property(nonatomic,strong)countNumView * countView;

@property(nonatomic,strong)ShopCartAllDataModel * model;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView;

@property(nonatomic,weak)id <shopCartBtnSelcetDelegate> delegate;
@end
