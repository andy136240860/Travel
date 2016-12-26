//
//  SRListVC.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/22.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "SRListVC.h"
//#import "XWHomeModel.h"
//#import "XWHomeCell.h"
#import "Travel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "XWTravelTogetherCell.h"
#import "UIImageView+WebCache.h"

static NSString *travelTogetherCellIdentifier = @"TravelTogetherCell";

@interface SRListVC ()

@end

@implementation SRListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"S&R";
    self.navigationController.navigationBar.barTintColor = kAppStyleColor;
    self.navigationController.navigationBar.translucent = NO;
    
    self.contentTableView.backgroundColor = kTableViewGrayColor;
    
    [self.contentTableView registerClass:[XWTravelTogetherCell class] forCellReuseIdentifier:travelTogetherCellIdentifier];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listModel.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id data = [self.listModel.items objectAtIndexSafely:indexPath.row];
    AVObject *object = (AVObject *)data;
    TravelDataType travelDataType = [[object objectForKey:@"TravelDataType"] integerValue];
    if (travelDataType == TravelDataTravelTogether) {
        XWTravelTogetherCell *cell = [tableView dequeueReusableCellWithIdentifier:travelTogetherCellIdentifier];
        [self setupModelOfTravelTogetherCell:cell atIndexPath:indexPath];
        return cell;
    }
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id data = [self.listModel.items objectAtIndexSafely:indexPath.row];
    AVObject *object = (AVObject *)data;
    TravelDataType travelDataType = [[object objectForKey:@"TravelDataType"] integerValue];
    if (travelDataType == TravelDataTravelTogether) {
        return [self.contentTableView fd_heightForCellWithIdentifier:travelTogetherCellIdentifier cacheByIndexPath:indexPath configuration:^(XWTravelTogetherCell *cell) {
            [self setupModelOfTravelTogetherCell:cell atIndexPath:indexPath];
        }];
    }
    return 0;
}

- (void) setupModelOfTravelTogetherCell:(XWTravelTogetherCell *) cell atIndexPath:(NSIndexPath *) indexPath {
    id data = [self.listModel.items objectAtIndexSafely:indexPath.row];
    AVObject *object = (AVObject *)data;
    TravelTogether *travelTogether = [object objectForKey:dataSourceTravelTogether];
    XWUser *user = [object objectForKey:source];
    cell.fd_enforceFrameLayout = NO;
    cell.indexPath = indexPath;
    cell.travelTogether = travelTogether;
    [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:user.avatarURL] placeholderImage:nil];
    cell.userLabel.text = user.nickName.length >0 ? user.nickName:user.username;
    cell.timeLabel.text = [NSDate convertDateIntervalToStringWith:[NSString stringWithFormat:@"%f",[travelTogether.createdAt timeIntervalSince1970]]];
    cell.titleLabel.text = [object objectForKey:contentText];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
