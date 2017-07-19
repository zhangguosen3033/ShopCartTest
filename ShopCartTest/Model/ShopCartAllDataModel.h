//
//  ShopCartAllDataModel.h
//  ShopCartTest
//
//  Created by ygkj on 2017/7/15.
//  Copyright © 2017年 ygkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCartAllDataModel : NSObject
@property(nonatomic,copy) NSString* is_promote_group;

@property (nonatomic, copy) NSString *rec_id;//购物车订单id

@property (nonatomic, copy) NSString *suppliers_id;//店铺id

@property (nonatomic, copy) NSString *goods_sn;//商品编号

@property (nonatomic, copy) NSString *extension_code;

@property (nonatomic, copy) NSString *is_shipping;//

@property (nonatomic, copy) NSString *suppliers_name;//店铺名称

@property (nonatomic, copy) NSString *goods_thumb;

@property (nonatomic, copy) NSString *formated_subtotal;

@property (nonatomic, copy) NSString *user_id;//用户id

@property (nonatomic, copy) NSString *market_price;

@property (nonatomic, copy) NSString *is_real;

@property (nonatomic, copy) NSString *gonghuo_id;

@property (nonatomic, copy) NSString *goods_name;

@property (nonatomic, copy) NSString *goods_attr;//商品属性

@property (nonatomic, copy) NSString *parent_id;

@property (nonatomic, copy) NSString *formated_market_price;//带格式的市场价格

@property (nonatomic, copy) NSString *formated_goods_price;//带格式的商品价格

@property (nonatomic, assign) float goods_rebate;//f返利

@property (nonatomic, copy) NSString *yuan_goods_price;

@property (nonatomic, copy) NSString *subtotal;//总价

@property (nonatomic, copy) NSString *is_gift;

@property (nonatomic, copy) NSString *goods_number;

@property (nonatomic, copy) NSString *goods_id;

@property (nonatomic, copy) NSString *goods_price;

@property (nonatomic, copy) NSString *brand_name;

@property (nonatomic, copy) NSString *goods_weight;

@property (nonatomic, copy) NSString * suppliers_headimg;

@property (nonatomic, assign) BOOL checked;
@property (nonatomic, assign) BOOL checkedSection;

@end
