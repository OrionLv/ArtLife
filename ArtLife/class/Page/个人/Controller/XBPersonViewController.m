//
//  XBPersonViewController.m
//  ArtLife
//
//  Created by lxb on 2017/2/17.
//  Copyright © 2017年 lxb. All rights reserved.
//

#import "XBPersonViewController.h"
#import "GobelDefine.h"
#import "XBHeaderView.h"
#import "XBPersonCell.h"

@interface XBPersonViewController ()<UITableViewDelegate, UITableViewDataSource>

/**UITableVIew*/
@property (nonatomic, strong) UITableView *tableView;

/**数据*/
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation XBPersonViewController

#pragma mark - 懒加载
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XBPersonCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}


#pragma mark - load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化导航栏
    [self setupNavigation];
    //初始化控件
    [self setupSubViews];
}

#pragma mark - private Method
-(void)setupNavigation{
    
    self.navigationItem.title = @"个人";
}

#pragma mark - private Method

-(void)setupSubViews{

    //设置背景色
    self.tableView.backgroundColor = UIColorFromRGB(defaultColor);
    
    self.dataArray = @[@"创作灵感", @"github地址", @"个人博客", @"简书地址", @"版本", @"特别鸣谢"];
    
    //创建tableView
    [self.view addSubview:self.tableView];
    
    [self setupTopView];
}

-(void)setupTopView{
    
    UIView *headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 180)];
    headview.backgroundColor = UIColorFromRGB(defaultColor);

    XBHeaderView *topView = [XBHeaderView loadHeadView];
    topView.frame = CGRectMake(0, 0, SCREENWIDTH, 160);
    topView.controller = self;
    [headview addSubview:topView];
    
    self.tableView.tableHeaderView = headview;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        return  4;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XBPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(indexPath.section == 0){
        
        cell.headLabel.text = self.dataArray[indexPath.row];
    }else{
        
        cell.headLabel.text = self.dataArray[indexPath.row + 4];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Blog]];
}

@end
