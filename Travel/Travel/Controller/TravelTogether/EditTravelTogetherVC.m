//
//  EditTravelTogetherVC.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/13.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "EditTravelTogetherVC.h"
#import "EditTravelTogetherHeaderView.h"
#import "FBKVOController.h"
#import "EditTravelTogetherTableViewCell.h"
#import "ChooseLanguageVC.h"
#import "TravelContentRichTextEditor.h"
#import "TravelTogetherDetailVC.h"

@interface EditTravelTogetherVC ()<EditTravelTogetherHeaderViewDelegate,UITableViewDelegate,UITableViewDataSource,TravelContentRichTextEditorDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) EditTravelTogetherHeaderView *tableHeaderView;
@property (nonatomic, strong) FBKVOController *KVOController;

@property (nonatomic, strong) EditTravelTogetherTableViewCell_0_0 *tableViewCell_0_0; //旅行目的地
@property (nonatomic, strong) EditTravelTogetherTableViewCell_0_1 *tableViewCell_0_1; //开始时间
@property (nonatomic, strong) EditTravelTogetherTableViewCell_0_2 *tableViewCell_0_2; //结束时间时间
@property (nonatomic, strong) EditTravelTogetherTableViewCell_0_3 *tableViewCell_0_3; //旅行人数
@property (nonatomic, strong) EditTravelTogetherTableViewCell_0_4 *tableViewCell_0_4; //交通状况
@property (nonatomic, strong) EditTravelTogetherTableViewCell_0_5 *tableViewCell_0_5; //语言支持
@property (nonatomic, strong) EditTravelTogetherTableViewCell_0_6 *tableViewCell_0_6; //同行人员
@property (nonatomic, strong) EditTravelTogetherTableViewCell_0_7 *tableViewCell_0_7; //旅行花费预算
@property (nonatomic, strong) EditTravelTogetherTableViewCell_0_8 *tableViewCell_0_8; //导游

@end

@implementation EditTravelTogetherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑一起旅行";
    self.edgesForExtendedLayout = UIRectEdgeTop;
    if (!self.navigationItem.backBarButtonItem) {
        [self addLeftCloseButtonItemWithImage];
    }
    [self addRightButtonWithTitle:@"预览" seletor:@selector(preViewTravelTogether)];
    
    self.travelTogether = [[TravelTogetherPrivate alloc]init];

    self.KVOController = [[FBKVOController alloc]initWithObserver:self];
    [self.KVOController observe:self.travelTogether keyPath:@"destinatin" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew action:@selector(changeValue)];
    [self.KVOController observe:self.travelTogether keyPath:@"startTime" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew action:@selector(changeValue)];
    [self.KVOController observe:self.travelTogether keyPath:@"endTime" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew action:@selector(changeValue)];
    [self.KVOController observe:self.travelTogether keyPath:@"peopleNumber" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew action:@selector(changeValue)];
    [self.KVOController observe:self.travelTogether keyPath:@"peopleNumberCanExceed" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew action:@selector(changeValue)];
    [self.KVOController observe:self.travelTogether keyPath:@"peopleNumberCanExceed" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew action:@selector(changeValue)];
    // Do any additional setup after loading the view.
}

- (void)changeValue {
    self.tableViewCell_0_1.travelTogether = self.travelTogether;
    self.tableViewCell_0_2.travelTogether = self.travelTogether;
    self.tableViewCell_0_3.travelTogether = self.travelTogether;
    self.tableViewCell_0_4.travelTogether = self.travelTogether;
    self.tableViewCell_0_5.travelTogether = self.travelTogether;
    self.tableViewCell_0_6.travelTogether = self.travelTogether;
    self.tableViewCell_0_7.travelTogether = self.travelTogether;
    self.tableViewCell_0_8.travelTogether = self.travelTogether;
}

- (void)loadContentView {
    _tableView = [[UITableView alloc]initWithFrame:self.contentView.bounds style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = self.tableHeaderView;
//    _tableView.tableFooterView = [UIView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = UIColorFromHex(0xf7f8f9);
    [self.contentView addSubview:_tableView];
}

- (EditTravelTogetherHeaderView *)tableHeaderView {
    if (_tableHeaderView == nil) {
        _tableHeaderView = [[EditTravelTogetherHeaderView alloc]init];
        _tableHeaderView.delegate = self;
    }
    return _tableHeaderView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 9;
            break;
        case 1:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellID = @"defaultCell";
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                if (!_tableViewCell_0_0) {
                    _tableViewCell_0_0 = [[EditTravelTogetherTableViewCell_0_0 alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
                    _tableViewCell_0_0.travelTogether = self.travelTogether;
                }
                return _tableViewCell_0_0;
            }break;
            case 1:{
                if (!_tableViewCell_0_1) {
                    _tableViewCell_0_1 = [[EditTravelTogetherTableViewCell_0_1 alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
                    _tableViewCell_0_1.travelTogether = self.travelTogether;
                }
                return _tableViewCell_0_1;
            }break;
            case 2:{
                if (!_tableViewCell_0_2) {
                    _tableViewCell_0_2 = [[EditTravelTogetherTableViewCell_0_2 alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
                    _tableViewCell_0_2.travelTogether = self.travelTogether;
                }
                return _tableViewCell_0_2;
            }break;
            case 3:{
                if (!_tableViewCell_0_3) {
                    _tableViewCell_0_3 = [[EditTravelTogetherTableViewCell_0_3 alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
                    _tableViewCell_0_3.travelTogether = self.travelTogether;
                }
                return _tableViewCell_0_3;
            }break;
            case 4:{
                if (!_tableViewCell_0_4) {
                    _tableViewCell_0_4 = [[EditTravelTogetherTableViewCell_0_4 alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
                    _tableViewCell_0_4.travelTogether = self.travelTogether;
                }
                return _tableViewCell_0_4;
            }break;
            case 5:{
                if (!_tableViewCell_0_5) {
                    _tableViewCell_0_5 = [[EditTravelTogetherTableViewCell_0_5 alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
                    _tableViewCell_0_5.travelTogether = self.travelTogether;
                }
                return _tableViewCell_0_5;
            }break;
            case 6:{
                if (!_tableViewCell_0_6) {
                    _tableViewCell_0_6 = [[EditTravelTogetherTableViewCell_0_6 alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
                    _tableViewCell_0_6.travelTogether = self.travelTogether;
                }
                return _tableViewCell_0_6;
            }break;
            case 7:{
                if (!_tableViewCell_0_7) {
                    _tableViewCell_0_7 = [[EditTravelTogetherTableViewCell_0_7 alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
                    _tableViewCell_0_7.travelTogether = self.travelTogether;
                }
                return _tableViewCell_0_7;
            }break;
            case 8:{
                if (!_tableViewCell_0_8) {
                    _tableViewCell_0_8 = [[EditTravelTogetherTableViewCell_0_8 alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
                    _tableViewCell_0_8.travelTogether = self.travelTogether;
                }
                return _tableViewCell_0_8;
            }break;
            default:
                break;
        }
    }
    //暂时废弃

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"旅行目的地";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 1:
                cell.textLabel.text = @"开始时间";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 2:
                cell.textLabel.text = @"结束时间";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 3:
                cell.textLabel.text = @"旅行人数";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 4:
                cell.textLabel.text = @"交通状况";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 5:
                cell.textLabel.text = @"语音支持";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 6:
                cell.textLabel.text = @"同行人员";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 7:
                cell.textLabel.text = @"旅行花费预算";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 8:
                cell.textLabel.text = @"导游";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
                
            default:
                break;
        }
    }
    else {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"编辑旅行计划描述";
                break;
                
            default:
                break;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 1)return 0;
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 5: {
                ChooseLanguageVC *vc = [[ChooseLanguageVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
    if (indexPath.section == 1) {
        TravelContentRichTextEditor *vc = [[TravelContentRichTextEditor alloc]init];
        vc.title = @"编辑一起旅行详情";
        vc.contentString = self.travelTogether.detail;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)saveContentString:(NSString *)contentString {
    self.travelTogether.detail = contentString;
}





- (void)closeAction {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)preViewTravelTogether {
    TravelTogetherDetailVC *vc = [[TravelTogetherDetailVC alloc]init];
    vc.travelTogether = self.travelTogether;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 选择照片

- (void)ChangeBackgroundImageWithEditTravelTogetherHeaderView:(EditTravelTogetherHeaderView *)view {

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
