//
//  ViewController.m
//  ShopCartTest
//
//  Created by ygkj on 2017/7/15.
//  Copyright © 2017年 ygkj. All rights reserved.
//

#import "shopCartTestViewController.h"
#import "MJExtension.h"
#import "Masonry.h"

#import "shopCartTestTableViewCell.h"
#import "ShopCartAllDataModel.h"
@interface shopCartTestViewController ()<UITableViewDataSource,UITableViewDelegate,shopCartBtnSelcetDelegate>

@property(nonatomic,strong)UIButton *rightTopBtn;

@property(nonatomic,strong)UITableView *shopCartTableView;
@property(nonatomic,strong)UIView *bottomBaseView;
@property(nonatomic,strong)UIButton *allSelectBtn;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIButton *makeSureBtn;

@end

@implementation shopCartTestViewController
{
    NSMutableArray *originalArray;
    NSMutableArray *transformDataArray;
    NSMutableArray *deleteGoodsArray;
    UIButton* sectionHeaderBtn;

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor grayColor];
    originalArray =[[NSMutableArray alloc]init];
    transformDataArray =[[NSMutableArray alloc]init];
    deleteGoodsArray =[[NSMutableArray alloc]init];

    [self.view addSubview:self.shopCartTableView];
    [self.view addSubview:self.bottomBaseView];
    [self.bottomBaseView addSubview:self.allSelectBtn];
    [self.bottomBaseView addSubview:self.priceLabel];
    [self.bottomBaseView addSubview:self.makeSureBtn];

    [self initData];
    [self setRightTopBtn];

    [self makeMasonryConstraintLayout];

}
#pragma mark -请求数据
-(void)initData{
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shopCartTestData" ofType:@"json"]];
    NSDictionary *temptDic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    originalArray = [temptDic objectForKey:@"content"];
    
    for (NSArray *goodsarray in originalArray) {
            NSMutableArray *newGoodsArray =[[NSMutableArray alloc]initWithArray:goodsarray];
            NSMutableDictionary* dict=[[NSMutableDictionary alloc] init];
            [dict setObject:@NO forKey:@"checked"];
            [dict setObject:@NO forKey:@"checkedSection"];
            [newGoodsArray addObject:dict];
            NSArray *oneSectionDataArray = [ShopCartAllDataModel mj_objectArrayWithKeyValuesArray:newGoodsArray];
            [transformDataArray addObject:oneSectionDataArray];
    }
    
    NSMutableArray *allDetailArray = [[NSMutableArray alloc]init];
    for (int i= 0; i< transformDataArray.count; i++) {
        NSMutableArray *temptArray =[[NSMutableArray alloc]initWithArray:transformDataArray[i]];
        NSMutableArray *sectionDetailArray = [[NSMutableArray alloc]init];
        for (int j= 0; j <temptArray.count -1; j++) {
            [sectionDetailArray addObject:transformDataArray[i][j]];
        }
        if (sectionDetailArray.count) {
            [allDetailArray addObject:sectionDetailArray];
        }
    }
    [transformDataArray removeAllObjects];
    [transformDataArray addObjectsFromArray:allDetailArray];
    

}
#pragma mark -UITableView  的相关代理方法处理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *rowsNumArray =transformDataArray[section];
    return rowsNumArray.count;
 }
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return transformDataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifile=@"Cell";
    shopCartTestTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:identifile];
    if (!cell) {
        cell=[[shopCartTestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifile tableView:tableView];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (originalArray.count>0) {
        ShopCartAllDataModel * model=transformDataArray[indexPath.section][indexPath.row];
        cell.model=model;
    }
    cell.delegate =self;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ShopCartAllDataModel *goodsModel = transformDataArray[section][0];
   
    UIView  *heardView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35)];
    heardView.tag = 1999+section;
    //添加向右的箭头
    UIImageView * right=[[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-10-12, 10, 7, 12)];
    right.image=[UIImage imageNamed:@"right_btn"];
    [heardView addSubview:right];
    
    sectionHeaderBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 8, 20, 20)];
    UIImage *btimg = [UIImage imageNamed:@"未选@2x"];
    UIImage *selectImg = [UIImage imageNamed:@"选中@2x"];
    [sectionHeaderBtn setImage:btimg forState:UIControlStateNormal];
    [sectionHeaderBtn setImage:selectImg forState:UIControlStateSelected];
    [sectionHeaderBtn addTarget:self action:@selector(goto_supplier_action:) forControlEvents:UIControlEventTouchUpInside];
    sectionHeaderBtn.tag = section;
    [heardView addSubview:sectionHeaderBtn];
    
    //判断显示情况
    if (goodsModel.checkedSection) {
        sectionHeaderBtn.selected =YES;
    }else{
        sectionHeaderBtn.selected =NO;
    }
    
    UIImageView *  storeImage = [[UIImageView alloc]initWithFrame:CGRectMake(35, 8, 20, 20)];
    storeImage.image =[UIImage imageNamed:@"测试店家图标"];
    [heardView addSubview:storeImage];

    UILabel *  storeNameLb = [[UILabel alloc]initWithFrame:CGRectMake(60, 8, 100, 20)];
    storeNameLb.textColor =[UIColor blackColor];
    storeNameLb.text =goodsModel.suppliers_name;
    [heardView addSubview:storeNameLb];

    return heardView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 177/2.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark -自定义方法
#pragma mark -点击组头试图
-(void)goto_supplier_action:(UIButton *)sectionBtn{
    ShopCartAllDataModel *model = transformDataArray[sectionBtn.tag][0];
    model.checkedSection =!model.checkedSection;
    NSArray *sectionArray = transformDataArray[sectionBtn.tag];
    for (int i = 0; i < sectionArray.count; i++) {
        ShopCartAllDataModel *goodsModel = transformDataArray[sectionBtn.tag][i];
        goodsModel.checked = model.checkedSection;
    }
    [self.shopCartTableView reloadData];
    [self checkSelcetState];
    [self CalculatedPrice];

    
}
#pragma mark -点击cell上的按钮
-(void)singleClickWithCell:(UITableViewCell *)cell{

    NSIndexPath * indexPath = [self.shopCartTableView indexPathForCell:cell];
    ShopCartAllDataModel *goodsModel = transformDataArray[indexPath.section][indexPath.row];
    goodsModel.checked = !goodsModel.checked;
    NSArray *sectionArray = transformDataArray[indexPath.section];//获取当前组内的数组
    NSInteger totalCount = 0;
    for (int i = 0; i < sectionArray.count; i++) {
        ShopCartAllDataModel *goodsModel = transformDataArray[indexPath.section][i];
        if (goodsModel.checked) {
            totalCount++;
        }
    }
    BOOL sectionSelect = (totalCount == sectionArray.count);
    if (sectionSelect) {
        ShopCartAllDataModel *model = transformDataArray[indexPath.section][0];
        model.checkedSection = YES;
    }else{
        ShopCartAllDataModel *model = transformDataArray[indexPath.section][0];
        model.checkedSection = NO;
    };
    [self.shopCartTableView reloadData];
    
    [self checkSelcetState];
    [self CalculatedPrice];

}
#pragma mark - 价格的计算
-(void)CalculatedPrice{
    float price = 0;
    for (int i= 0; i< transformDataArray.count; i++) {
        NSMutableArray *temptArray =[[NSMutableArray alloc]initWithArray:transformDataArray[i]];
        for (int j= 0; j <temptArray.count; j++) {
            ShopCartAllDataModel *goodsModel = temptArray[j];
            if (goodsModel.checked) {
                price = price+ [goodsModel.market_price floatValue];
            }
        }
    }
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f元",price];
}
#pragma mark -全选按钮
-(void)clickAllSelctBtn{
    self.allSelectBtn.selected = !self.allSelectBtn.selected;

    if (self.allSelectBtn.selected) {
        for (int i= 0; i< transformDataArray.count; i++) {
            NSMutableArray *temptArray =[[NSMutableArray alloc]initWithArray:transformDataArray[i]];
            for (int j= 0; j <temptArray.count; j++) {
                ShopCartAllDataModel *goodsModel = temptArray[j];
                goodsModel.checked =YES;
                goodsModel.checkedSection =YES;
            }
        }
        [self.shopCartTableView reloadData];
        [self CalculatedPrice];
        
    }else{
        for (int i= 0; i< transformDataArray.count; i++) {
            NSMutableArray *temptArray =[[NSMutableArray alloc]initWithArray:transformDataArray[i]];
            for (int j= 0; j <temptArray.count; j++) {
                ShopCartAllDataModel *goodsModel = temptArray[j];
                goodsModel.checked =NO;
                goodsModel.checkedSection =NO;
            }
        }
        [self.shopCartTableView reloadData];
        [self CalculatedPrice];
        
    }
}
#pragma mark -加减按钮 协议方法
//加
-(void)clickCountViewAddBtnWithCell:(UITableViewCell *)cell WithCountView:(countNumView *)countView{
    NSIndexPath * indexPath = [self.shopCartTableView indexPathForCell:cell];
    ShopCartAllDataModel *goodsModel = transformDataArray[indexPath.section][indexPath.row];
    
    countView.reduceBtn.enabled =YES;
    NSInteger addNum =[countView.countTextfiled.text integerValue];
    addNum ++;
    countView.countTextfiled.text = [NSString stringWithFormat:@"%ld",addNum];
    
    NSDictionary *rowDic =originalArray[indexPath.section][indexPath.row];
    goodsModel.market_price = [NSString stringWithFormat:@"%.2f",[[rowDic objectForKey:@"market_price" ] floatValue]*addNum];
    
    [self.shopCartTableView reloadData];
    [self checkSelcetState];
    [self CalculatedPrice];
}
//减
-(void)clickCountViewReduceBtnWithCell:(UITableViewCell *)cell WithCountView:(countNumView *)countView{
    
    NSIndexPath * indexPath = [self.shopCartTableView indexPathForCell:cell];
    ShopCartAllDataModel *goodsModel = transformDataArray[indexPath.section][indexPath.row];
    
    NSInteger reduceNum =[countView.countTextfiled.text integerValue];
    NSDictionary *rowDic =originalArray[indexPath.section][indexPath.row];
    
    if ( reduceNum <= 1) {
        
        countView.reduceBtn.enabled =NO;
        goodsModel.market_price = [NSString stringWithFormat:@"%.2f",[[rowDic objectForKey:@"market_price" ] floatValue]*1];
        
    }else{
        countView.reduceBtn.enabled =YES;
        reduceNum --;
        countView.countTextfiled.text = [NSString stringWithFormat:@"%ld",reduceNum];
        goodsModel.market_price = [NSString stringWithFormat:@"%.2f",[[rowDic objectForKey:@"market_price" ] floatValue]*reduceNum];
        
    }
    [self.shopCartTableView reloadData];
    [self checkSelcetState];
    [self CalculatedPrice];
    
}
#pragma mark --- 导航栏编辑相关
-(void)setRightTopBtn{
    
    self.rightTopBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.rightTopBtn.frame = CGRectMake(0, 0, 40, 40);
    [self.rightTopBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.rightTopBtn setTitle:@"完成" forState:UIControlStateSelected];
    self.rightTopBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.rightTopBtn.selected =NO;
    [self.rightTopBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightTopBtn addTarget:self action:@selector(editBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightTopBtn];
}
- (void)editBtnClicked{
    
    self.rightTopBtn.selected = !self.rightTopBtn.selected;
    if (self.rightTopBtn.selected) {
        [self.makeSureBtn setTitle:@"删除" forState:UIControlStateNormal];
    }else{
        [self.makeSureBtn setTitle:@"结算" forState:UIControlStateNormal];
 
    }
    
}

#pragma mark -结算按钮
-(void)clickMakeSureBtn{
    if (self.rightTopBtn.selected) {//删除相关选中商品
        for (int i= 0; i< transformDataArray.count; i++) {
            NSMutableArray *temptArray =[[NSMutableArray alloc]initWithArray:transformDataArray[i]];
            for (int j= 0; j <temptArray.count; j++) {
                ShopCartAllDataModel *goodsModel = temptArray[j];
                if (goodsModel.checked && self.rightTopBtn.selected) {
                   //把要删除的数据存进一个数组
                    [deleteGoodsArray addObject:goodsModel.goods_sn];

                    [self deletaGoods];//删除数据
                }else{
                    [self deletaGoods];

                }
            }
        }
    }else{//结算相关选中商品
        for (int i= 0; i< transformDataArray.count; i++) {
            NSMutableArray *temptArray =[[NSMutableArray alloc]initWithArray:transformDataArray[i]];
            for (int j= 0; j <temptArray.count; j++) {
                ShopCartAllDataModel *goodsModel = temptArray[j];
                if (goodsModel.checked) {
                    
                    //得到选中的数据信息
                }
            }
        }

    }
}
#pragma mark -处理删除数据  排除要删除信息后新造一个数据源
-(void)deletaGoods{
    NSMutableArray *backDetailArray = [[NSMutableArray alloc]init];
    for (int i= 0; i< transformDataArray.count; i++) {
        NSMutableArray *temptArray =[[NSMutableArray alloc]initWithArray:transformDataArray[i]];
        NSMutableArray *sectionDetailArray = [[NSMutableArray alloc]init];
        for (int j= 0; j <temptArray.count; j++) {
            ShopCartAllDataModel *goodsModel = temptArray[j];
            if (![deleteGoodsArray containsObject:goodsModel.goods_sn]) {
                [sectionDetailArray addObject:transformDataArray[i][j]];
            }
         }
        if (sectionDetailArray.count) {
            [backDetailArray addObject:sectionDetailArray];
        }
    }
    [transformDataArray removeAllObjects];
    [transformDataArray addObjectsFromArray:backDetailArray];
    [self.shopCartTableView reloadData];
    [self CalculatedPrice];
}
#pragma mark -每次选中都走的方法检查是否全部选中
-(void)checkSelcetState{

    NSInteger totalSelected = 0;
    NSInteger realRowNum = 0;
    for (int i= 0; i< transformDataArray.count; i++) {
        NSMutableArray *temptArray =[[NSMutableArray alloc]initWithArray:transformDataArray[i]];
        for (int j= 0; j <temptArray.count; j++) {
            ShopCartAllDataModel *goodsModel = temptArray[j];
            realRowNum ++;
            if (goodsModel.checked) {
                totalSelected ++;
            }
        }
    }
    if (totalSelected == realRowNum) {
        
        self.allSelectBtn.selected =YES;
    }else{
        self.allSelectBtn.selected =NO;
 
    }
}
#pragma mark -控件的懒加载
-(UITableView *)shopCartTableView{
    
    if (!_shopCartTableView) {
        _shopCartTableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _shopCartTableView.backgroundColor=[UIColor whiteColor];
        _shopCartTableView.delegate=self;
        _shopCartTableView.dataSource=self;
        _shopCartTableView.showsVerticalScrollIndicator = NO;
    }
    return _shopCartTableView;
}
-(UIView *)bottomBaseView{
    if (!_bottomBaseView) {
        _bottomBaseView =[UIView new];
        _bottomBaseView.backgroundColor =[UIColor whiteColor];
    }
    return _bottomBaseView;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel =[UILabel new];
        _priceLabel.text = @"0元";
    }
    return _priceLabel;
}
-(UIButton*)allSelectBtn
{
    if (!_allSelectBtn) {
        _allSelectBtn=[UIButton new];
        UIImage *btimg = [UIImage imageNamed:@"未选@2x"];
        UIImage *selectImg = [UIImage imageNamed:@"选中@2x"];
        [_allSelectBtn setImage:btimg forState:UIControlStateNormal];
        [_allSelectBtn setImage:selectImg forState:UIControlStateSelected];
        [_allSelectBtn addTarget:self action:@selector(clickAllSelctBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allSelectBtn;
}
-(UIButton*)makeSureBtn
{
    if (!_makeSureBtn) {
        _makeSureBtn=[UIButton new];
        [_makeSureBtn setBackgroundColor:[UIColor redColor]];
        [_makeSureBtn setTitle:@"结算" forState:UIControlStateNormal];
        [_makeSureBtn addTarget:self action:@selector(clickMakeSureBtn) forControlEvents:UIControlEventTouchUpInside];
        }
    return _makeSureBtn;
}

#pragma mark -MasonryConstraintLayout布局
-(void)makeMasonryConstraintLayout{
    
    [self.shopCartTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.bottomBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.equalTo(@52);
    }];
    [self.allSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomBaseView).offset(10);
        make.top.equalTo(self.bottomBaseView.mas_top).offset(18);
        make.width.height.equalTo(@20);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allSelectBtn.mas_right).offset(10);
        make.top.equalTo(self.allSelectBtn);
    }];
    [self.makeSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomBaseView);
        make.top.height.equalTo(self.bottomBaseView);
        make.width.equalTo(@100);
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
