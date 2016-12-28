//
//  OneViewController.m
//  TableVIewAndCollectionView
//
//  Created by DayHR on 2016/12/27.
//  Copyright © 2016年 xiangzuhua. All rights reserved.
//

#import "OneViewController.h"
#import "OneCollectionViewCell.h"
#import "UIColor+RGB.h"
#import "OneTableViewCell.h"

@interface OneViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property(nonatomic,strong)NSArray * collectionViewtitleArr;//collectionView的标题数据
@property(nonatomic,strong)NSArray * collectionViewImageNameArr;//collectionView的图片名称数据
@property(nonatomic,strong)NSArray * tableViewtitleArr;//
@property(nonatomic,assign)NSInteger selectedRowForCollectionView;//选中的左边列表的行数
@property(nonatomic,strong)UIView * coverView;//蒙版
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initObject];
    [self getData];
    [self initView];
}
#pragma mark -- 初始化对象
-(void)initObject{
    self.selectedRowForCollectionView = -1;
}
#pragma mark -- 获取数据
-(void)getData{
    self.collectionViewtitleArr = @[@"长沙",@"上海",@"北京",@"广州"];
    self.collectionViewImageNameArr = @[@"城市",@"城市",@"城市",@"城市"];
    self.tableViewtitleArr = @[@[@"岳麓",@"芙蓉",@"星沙",@"开福",@"天心",@"雨花",@"浏阳",@"宁乡",@"望城"],@[@"浦东",@"杨浦",@"静安",@"普陀",@"虹口",@"黄埔",@"闵行区",@"宝山",@"长宁",@"徐汇区",@"嘉定",@"松江",@"青浦",@"奉贤",@"金山"],@[@"东城",@"西城",@"朝阳",@"海淀",@"大兴",@"昌平",@"房山",@"丰台",@"密云",@"延庆",@"门头沟",@"石景山",@"平谷"],@[@"天河",@"荔湾",@"白云",@"越秀",@"从化",@"增城",@"海珠",@"南沙",@"番禺",@"花都"]];
}
#pragma mark -- 初始化视图
-(void)initView{
    //
}
#pragma mark -- 代理方法
#pragma mark -- UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tableViewtitleArr[self.selectedRowForCollectionView] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 53;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 53;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OneTableViewCell" forIndexPath:indexPath];
    cell.imageV.image = [UIImage imageNamed:@"头像"];
    cell.label.text = self.tableViewtitleArr[self.selectedRowForCollectionView][indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //取到选择的城市和区名
    NSString * city = self.collectionViewtitleArr[self.selectedRowForCollectionView];
    NSString * area = self.tableViewtitleArr[self.selectedRowForCollectionView][indexPath.row];
    //将城市名和区名赋值给选择按钮
    [self.dataSelectButton setTitle:[NSString stringWithFormat:@"%@ %@",city,area] forState:(UIControlStateNormal)];
    //删掉列表
    [self deleteTabelViewAndCollectionView];
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setFrame:CGRectMake(0, 0, kScreenWidth*2/3, 53)];
    [button setTitle:@"全部" forState:(UIControlStateNormal)];
    [button setTitleColor:ZJYColorHex(@"232425") forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button addTarget:self action:@selector(allDriverHeadViewAction:) forControlEvents:(UIControlEventTouchUpInside)];
    button.backgroundColor =  ZJYColorHex(@"eeeeee");
    return button;
}
#pragma mark -- UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionViewtitleArr.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(94, 53);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    OneCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OneCollectionViewCell" forIndexPath:indexPath];
    cell.label.text = self.collectionViewtitleArr[indexPath.row];
    if (self.selectedRowForCollectionView == 0&&indexPath.row == 0) {//判断是第一行或者选中第一行，则将其颜色设置为选中状态
        cell.backgroundColor = [UIColor whiteColor];
        cell.headView.backgroundColor = ZJYColorHex(@"3d8bf5");
        cell.label.textColor = ZJYColorHex(@"3d8bf5");
    }else{
        cell.backgroundColor = ZJYColorHex(@"f3f3f3");
        cell.headView.backgroundColor = ZJYColorHex(@"f3f3f3");
        cell.label.textColor = ZJYColorHex(@"494b4c");
    }
    cell.imageView.image = [UIImage imageNamed:self.collectionViewImageNameArr[indexPath.row]];
    return cell;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.01;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.01;
}
//选中时的操作
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedRowForCollectionView = indexPath.row;
    //选中之后的cell变颜色，其他的复原
    for (int i = 0; i < self.collectionViewtitleArr.count; i++) {
        OneCollectionViewCell *cell = (OneCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.backgroundColor = (i == indexPath.row)?[UIColor whiteColor]:ZJYColorHex(@"f3f3f3");
        cell.headView.backgroundColor  = (i == indexPath.row)?ZJYColorHex(@"3d8bf5"):ZJYColorHex(@"f3f3f3");
        cell.label.textColor = (i == indexPath.row)?ZJYColorHex(@"3d8bf5"):ZJYColorHex(@"494b4c");
    }
    [self.tableView reloadData];
}
#pragma mark -- 点击事件
- (IBAction)selectedAction:(UIButton *)sender {
    self.selectedRowForCollectionView = 0;
    [self addTableViewAndCollectionView];
}
//返回按钮点击事件
- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//点击线路选择中的所有驾驶员按钮---全部
-(void)allDriverHeadViewAction:(UIButton*)sender{
    NSString * city = self.collectionViewtitleArr[self.selectedRowForCollectionView];
    [self.dataSelectButton setTitle:[NSString stringWithFormat:@"%@",city] forState:(UIControlStateNormal)];
    [self deleteTabelViewAndCollectionView];
}
//点击空白，恢复界面
-(void)tapAction{
    [self deleteTabelViewAndCollectionView];
}
#pragma mark -- 私有方法
//添加蒙版
-(void)addCoverView{
    if (![self.view.subviews containsObject:self.coverView]) {
        self.coverView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight)];
        self.coverView.backgroundColor = [UIColor blackColor];
        self.coverView.alpha = 0.3;
        [self.view addSubview:self.coverView];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self.coverView addGestureRecognizer:tap];
    }
}
//删除蒙版、隐藏时间选择器、按钮行回复图标和文字颜色
-(void)deleteCoverView{
    //删除蒙版
    if ([self.view.subviews containsObject:self.coverView]) {
        [self.coverView removeFromSuperview];
    }
}
//创建线路及驾驶员选择tableView
-(void)addTableViewAndCollectionView{
    //添加蒙版
    [self addCoverView];
    //添加列表
    if (![self.view.subviews containsObject:self.collectionView]) {
        UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc]init];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 120, 94, kScreenHeight -120) collectionViewLayout:flowLayout];
        self.collectionView.backgroundColor = ZJYColorHex(@"f0f0f0");
        [self.view addSubview:self.collectionView];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.bounces = NO;
        //注册
        [self.collectionView registerNib:[UINib nibWithNibName:@"OneCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"OneCollectionViewCell"];
    }
    if (![self.view.subviews containsObject:self.tableView]) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(94, 120, kScreenWidth - 94, kScreenHeight - 120) style:(UITableViewStylePlain)];
        [self.view addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.bounces = NO;
        //注册
        [self.tableView registerNib:[UINib nibWithNibName:@"OneTableViewCell" bundle:nil] forCellReuseIdentifier:@"OneTableViewCell"];
    }
}
//删除线路选择及驾驶员选择tableView
-(void)deleteTabelViewAndCollectionView{
    //删除蒙版
    [self deleteCoverView];
    //删除列表
    if ([self.view.subviews containsObject:self.tableView]) {
        [self.tableView removeFromSuperview];
    }
    if ([self.view.subviews containsObject:self.collectionView]) {
        [self.collectionView removeFromSuperview];
    }
}
#pragma mark -- 懒加载
-(NSArray *)tableViewtitleArr{
    if (!_tableViewtitleArr) {
        _tableViewtitleArr = [[NSArray alloc] init];
    }
    return _tableViewtitleArr;
}
-(NSArray *)collectionViewtitleArr{
    if (!_collectionViewtitleArr) {
        _collectionViewtitleArr = [[NSArray alloc] init];
    }
    return _collectionViewtitleArr;
}
-(NSArray *)collectionViewImageNameArr{
    if (!_collectionViewImageNameArr) {
        _collectionViewImageNameArr = [[NSArray alloc] init];
    }
    return _collectionViewImageNameArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
