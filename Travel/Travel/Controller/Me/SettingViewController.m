//
//  SettingViewController.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/13.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "SettingViewController.h"
#import "XWUser.h"
#import "UIImageView+WebCache.h"
#import "CircularImageViewTableViewCell.h"
#import "PersonalInformationSettingVC.h"

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.2 animations:^{
        [self.contentTableView reloadData];
    }];
}

- (void)loadContentView {
    _contentTableView = [[UITableView alloc]initWithFrame:self.contentView.bounds style:UITableViewStyleGrouped];
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    _contentTableView.tableFooterView = [UIView new];
    _contentTableView.backgroundColor = kTableViewGrayColor;
    [self.contentView addSubview:_contentTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableViewDelegate & dataSource

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    UITableViewCell * cell = [self.contentTableView dequeueReusableCellWithIdentifier:@"userImageViewCell"];
    if (cell) {
        cell.imageView.layer.cornerRadius = cell.imageView.frameHeight/2.f;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([[XWUser currentUser] isAuthenticated]) {
        return 4;
    }
    else {
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[XWUser currentUser] isAuthenticated]) {
        switch (section) {
            case 0:
                return 1;
                break;
            case 1:
                return 4;
                break;
            case 2:
                return 3;
                break;
            case 3:
                return 1;
                break;
                
            default:
                return 0;
                break;
        }
    }
    else {
        switch (section) {
            case 0:
                return 2;
                break;
            case 1:
                return 3;
                break;
                
            default:
                return 0;
                break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && [[XWUser currentUser] isAuthenticated]) {
        return 88;
    }
    else return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"defaultCell";
    static NSString * userImageViewCell = @"userImageViewCell";
    static NSString * logoutCell = @"logoutCell";
    if (indexPath.section == 0 && [[XWUser currentUser] isAuthenticated]) {
        CircularImageViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:userImageViewCell];
        if (!cell) {
            cell = [[CircularImageViewTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:userImageViewCell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        XWUser *myuser = [XWUser currentUser];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:myuser.avatarURL] placeholderImage:[UIImage imageNamed:@"CollectionHeaderViewForMeVC_userAvatarDefaultImage"]];
        cell.detailTextLabel.text = myuser.nickName.length == 0? myuser.username:myuser.nickName;
        return cell;
    }
    if (indexPath.section == 3 && [[XWUser currentUser] isAuthenticated]) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:logoutCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:logoutCell];
        }
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.centerX = cell.centerX;
        return cell;
    }
    else {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if ([[XWUser currentUser] isAuthenticated]) {
            if (indexPath.section == 1) {
                switch (indexPath.row) {
                    case 0:
                        cell.textLabel.text = @"身份验证";
                        cell.detailTextLabel.text = @"未验证";
                        break;
                    case 1:
                        cell.textLabel.text = @"修改账户密码";
                        cell.detailTextLabel.text = nil;
                        break;
                    case 2:
                        cell.textLabel.text = @"推送通知设置";
                        cell.detailTextLabel.text = nil;
                        break;
                    case 3:
                        cell.textLabel.text = @"隐私设置";
                        cell.detailTextLabel.text = nil;
                        break;
                    default:
                        break;
                }
            }
            if (indexPath.section == 2) {
                switch (indexPath.row) {
                    case 0:
                        cell.textLabel.text = @"关于我们";
                        cell.detailTextLabel.text = nil;
                        break;
                    case 1:
                        cell.textLabel.text = @"意见反馈";
                        cell.detailTextLabel.text = nil;
                        break;
                    case 2:
                        cell.textLabel.text = @"给我们点个赞吧";
                        cell.detailTextLabel.text = nil;
                        break;
                    default:
                        break;
                }
            }
        }
        else {
            cell.textLabel.text = @"未登录";
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && [[XWUser currentUser] isAuthenticated]) {
        PersonalInformationSettingVC *vc = [[PersonalInformationSettingVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        //更改头像以及昵称等详细个人信息
    }
    if (indexPath.section == 3 && [[XWUser currentUser] isAuthenticated]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"退出后不会删除任何历史数据，下次登录依然可以使用本账号" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [XWUser logOut];
            [self backAction];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:archiveAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}



@end
