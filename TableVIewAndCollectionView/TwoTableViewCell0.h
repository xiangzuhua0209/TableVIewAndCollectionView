//
//  TwoTableViewCell0.h
//  TableVIewAndCollectionView
//
//  Created by DayHR on 2016/12/27.
//  Copyright © 2016年 xiangzuhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoTableViewCell0 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end
