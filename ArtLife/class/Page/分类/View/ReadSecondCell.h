//
//  ReadSecondCell.h
//  文艺生活
//
//  Created by 吕晓冰 on 17/3/18.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReadSecondListModel;
@interface ReadSecondCell : UITableViewCell
@property (nonatomic,strong) ReadSecondListModel *listModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
