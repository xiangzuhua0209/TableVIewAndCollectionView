//
//  OneCollectionViewCell.h
//  TableVIewAndCollectionView
//
//  Created by DayHR on 2016/12/27.
//  Copyright © 2016年 xiangzuhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *headView;//选中指示条

@end
