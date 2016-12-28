//
//  TwoViewController.m
//  TableVIewAndCollectionView
//
//  Created by DayHR on 2016/12/27.
//  Copyright © 2016年 xiangzuhua. All rights reserved.
//

#import "TwoViewController.h"
#import "TwoTableViewCell0.h"
#import "DataModel.h"
#import "UIColor+RGB.h"
#import "CollectionViewCell.h"

@interface TwoViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray * dataArr;//存储数据的数组
@property(nonatomic,strong)NSMutableArray * selectStateArr;//状态数组


@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initObject];
    [self getData];
    [self initView];
}
#pragma mark -- 初始化对象
-(void)initObject{
    
}
#pragma mark -- 获取数据
-(void)getData{
    for (int i = 0; i < 20; i++) {
        DataModel * model = [[DataModel alloc] init];
        model.title = [NSString stringWithFormat:@"无欲无求%d",i];
        model.count = arc4random()%5;//随机数0~4
        [self.dataArr addObject:model];
        [self.selectStateArr addObject:@"0"];
    }
}
#pragma mark -- 初始化视图
-(void)initView{
    //tableView注册设置代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册xib cell
    [self.tableView registerNib:[UINib nibWithNibName:@"TwoTableViewCell0" bundle:nil] forCellReuseIdentifier:@"TwoTableViewCell0"];
}
#pragma mark -- 代理方法
#pragma mark -- uitableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DataModel * model = self.dataArr[indexPath.row];
    if ([self.selectStateArr[indexPath.row] isEqualToString:@"0"]) {
        return 50;
    } else {
        return 50 * (model.count+1);
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TwoTableViewCell0 * cell = [tableView dequeueReusableCellWithIdentifier:@"TwoTableViewCell0" forIndexPath:indexPath];
    DataModel * model = self.dataArr[indexPath.row];
    cell.label.text = model.title;
    cell.label.textColor = ZJYColorHex(@"858586");
    cell.collectionView.hidden = YES;//隐藏collectionView
    //是否显示三角图标
    if (model.count > 1) {//有多辆车的情况
        cell.button.hidden = NO;//显示箭头
        cell.button.tag = 1000 + indexPath.row;
        //判断是否展开collectionView，点击了就展开
        NSString * single = self.selectStateArr[indexPath.row];
        if ([single isEqualToString:@"0"]) {//没有点击三角箭头
            if ([cell.subviews containsObject:cell.collectionView]) {//判断是否包含collectionView,包含则删除
                [cell.collectionView removeFromSuperview];
            }
            cell.collectionViewHeight.constant = 0.0;
            cell.collectionView.hidden = YES;//隐藏collectionView
        } else {//点击了三角箭头
            cell.collectionView.hidden = NO;//显示collectionView
            cell.label.textColor = ZJYColorHex(@"3788f8");
            cell.collectionViewHeight.constant = 50.0 * (model.count);
            cell.collectionView.delegate = self;
            cell.collectionView.dataSource = self;
            cell.collectionView.backgroundColor = [UIColor whiteColor];
            cell.collectionView.tag= 2000+indexPath.row;
            [cell.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"CollectionViewCell"];
            [cell.collectionView reloadData];
        }
    }else{//无多辆车
        cell.button.hidden = YES;//隐藏箭头
    }
    //添加点击事件
    [cell.button addTarget:self action:@selector(moreBusButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark -- collectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger index = collectionView.tag - 2000;
    DataModel * model = self.dataArr[index];
    return model.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = collectionView.tag - 2000;
    NSString * single = self.selectStateArr[index];
    if ([single isEqualToString:@"0"]) {//没有被点击
        return CGSizeMake(0, 0);
    } else {//点击了
        return CGSizeMake(kScreenWidth, 50);
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    cell.label.text = @"自挂东南枝";
    cell.imageV.image = [UIImage imageNamed:@"OvalCopy"];
    if (indexPath.row%2 == 0) {
        cell.backgroundColor = ZJYColorHex(@"f6f8fa");
    } else {
        cell.backgroundColor = ZJYColorHex(@"D0E4F7");
    }
    return cell;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.01;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.01;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
#pragma mark -- 点击事件
//返回
- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//点击tableView细胞上的箭头按钮  tag 1000 + x
-(void)moreBusButtonAction:(UIButton*)sender{
    NSInteger index= sender.tag -1000;
    NSString * single = self.selectStateArr[index];
    if ([single isEqualToString:@"0"]) {//点击展开
        //改变决定细胞高度的标识
        [self.selectStateArr replaceObjectAtIndex:index  withObject:@"1"];//替换标识值
        [sender setImage:[UIImage imageNamed:@"jiantou"] forState:(UIControlStateNormal)];//改变箭头图标
        [self.tableView reloadData];
    } else {//点击关闭
        //改变决定细胞高度的标识
        [self.selectStateArr replaceObjectAtIndex:index  withObject:@"0"];
        [sender setImage:[UIImage imageNamed:@"TriangleCopy"] forState:(UIControlStateNormal)];//改变箭头图标
        //改变对应细胞的高度
        [self.tableView reloadData];
    }
}
#pragma mark -- 私有方法

#pragma mark -- 懒加载
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}
-(NSMutableArray *)selectStateArr{
    if (!_selectStateArr) {
        _selectStateArr = [[NSMutableArray alloc] init];
    }
    return _selectStateArr;
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
