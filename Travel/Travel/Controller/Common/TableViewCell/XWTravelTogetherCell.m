//
//  XWTravelTogetherCell.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/12/2.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWTravelTogetherCell.h"
#import "UIImageView+WebCache.h"
#import "NSDate+SNExtension.h"
#import "XWCommendManager.h"
#import "MBProgressHUD.h"

@implementation XWTravelTogetherCell
@dynamic detailView;

- (void)createDetailView {
    self.detailView = [[XWTravelTogetherDetailCellView alloc]init];
    self.detailView.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:self.detailView];
    
    __block __weak typeof(self) blockSelf = self;
    self.interactionView.commendActionBlock = ^{
        NSInteger commendNumber = blockSelf.travelTogether.commend.commendUserArr.count;
        if([XWUser currentUser]) {
            [[XWUser currentUser] isAuthenticatedWithSessionToken:[XWUser currentUser].sessionToken callback:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    if ([blockSelf.travelTogether.commend.commendUserArr containsObject:[XWUser currentUser]]) {
                        [XWCommendManager disCommendObject:blockSelf.travelTogether.commend block:^(BOOL succeeded, NSError * _Nullable error) {
                            
                        }];
                        blockSelf.interactionView.commendNumber = commendNumber - 1;
                        blockSelf.interactionView.hasCommend = NO;
                    }
                    else {
                        [XWCommendManager commendObject:blockSelf.travelTogether.commend block:^(BOOL succeeded, NSError * _Nullable error) {
                            
                        }];
                        blockSelf.interactionView.commendNumber = commendNumber + 1;
                        blockSelf.interactionView.hasCommend = YES;
                    }
                }
                else {
                    MBProgressHUD *hud = [[MBProgressHUD alloc]init];
                    hud.labelText = @"请先登录";
                    hud.mode = MBProgressHUDModeText;
                    [hud show:YES];
                }
            }];

        }
        else {
            MBProgressHUD *hud = [[MBProgressHUD alloc]init];
            hud.labelText = @"请先登录";
            hud.mode = MBProgressHUDModeText;
            [hud show:YES];
        }
    };
}

- (void)setTravelTogether:(TravelTogether *)travelTogether {
    _travelTogether = travelTogether;
    self.typeImage.image = [UIImage imageNamed:@"together"];
    self.typeLabel.text = @"一起旅行";
    self.detailView.travelTogether = _travelTogether;
    
    self.interactionView.commendNumber = self.travelTogether.commend.commendUserArr.count;
    self.interactionView.commentNumber = self.travelTogether.commentNumber;
    self.interactionView.hasCommend = [self.travelTogether.commend.commendUserArr containsObject:[XWUser currentUser]];
}

@end
