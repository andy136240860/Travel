//
//  MeViewController.m
//  Travel
//
//  Created by 晓炜 郭 on 16/7/28.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "MeViewController.h"
#import "EqualSpaceFlowLayout.h"
#import "CollectionViewCellForMeVC.h"
#import "CollectionHeaderViewForMeVC.h"
#import "SubObjectHeaderViewForMeVC.h"
#import "CUViewController+Login.h"
#import "MyTravelViewController.h"

@interface MeViewController ()<EqualSpaceFlowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource,CollectionHeaderViewForMeVCDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation MeViewController

- (instancetype)initWithPageName:(NSString *)pageName{
    self = [super initWithPageName:pageName];
    if (self) {
        self.hasNavigationBar = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadContentView{
    self.contentView.backgroundColor = UIColorFromHex(Color_Hex_ImageDefault);
    EqualSpaceFlowLayout *collectionLayout = [[EqualSpaceFlowLayout alloc] init];
    collectionLayout.delegate = self;
    
    CGRect collectionFrame = CGRectMake(0, 0, kScreenWidth, self.contentView.frameHeight - kTabBarHeight);
    
    UICollectionView *collectionview = [[UICollectionView alloc] initWithFrame:collectionFrame collectionViewLayout:collectionLayout];
    collectionview.backgroundColor = [UIColor clearColor];
    collectionview.delegate = self;
    collectionview.dataSource = self;
    [self.contentView addSubview:collectionview];
    
    self.collectionView = collectionview;
    
    [self.collectionView registerClass:[CollectionViewCellForMeVC class] forCellWithReuseIdentifier:NSStringFromClass([CollectionViewCellForMeVC class])];
    
    [self.collectionView registerClass:[SubObjectHeaderViewForMeVC class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([SubObjectHeaderViewForMeVC class])];
    
    [self.collectionView registerClass:[CollectionHeaderViewForMeVC class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CollectionHeaderViewForMeVC class])];
}

#pragma mark - headerButtomsClickDelegate

- (void)clickButtonActionWithModel:(CollectionHeaderViewForMeVCClickModel)model{
    switch (model) {
        case CollectionHeaderViewModel_userAvatar:{
            NSLog(@"点击头像了， 因为未登录， 调用登陆页面");
            MyTravelViewController *vc = [[MyTravelViewController alloc]initWithPageName:NSStringFromClass([MyTravelViewController class])];
            [self pushViewControllerWithVerifyLogin:vc animated:YES];
        }
            break;
        case CollectionHeaderViewModel_userName:{
            NSLog(@"点击名字的Label了， 因为未登录， 调用登陆页面");
        }
            break;
        case CollectionHeaderViewModel_myTravel:{
            NSLog(@"我的旅程");
        }
            break;
        case CollectionHeaderViewModel_myRequest:{
            NSLog(@"我的请求");
        }
            break;
        case CollectionHeaderViewModel_myService:{
            NSLog(@"我的服务");
        }
            break;
        case CollectionHeaderViewModel_myCollection:{
            NSLog(@"我的收藏");
        }
            break;
        case CollectionHeaderViewModel_myOrder:{
            NSLog(@"我的订单");
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat sizeWidth = (kScreenWidth-21)/3.f;
    return CGSizeMake(sizeWidth,sizeWidth);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *collectionCellName = NSStringFromClass([CollectionViewCellForMeVC class]);
    CollectionViewCellForMeVC *collectionCell = (CollectionViewCellForMeVC *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellName forIndexPath:indexPath];
    collectionCell.backgroundColor = [UIColor blackColor];
    return collectionCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 0) {
            CollectionHeaderViewForMeVC *headerview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([CollectionHeaderViewForMeVC class]) forIndexPath:indexPath];
            headerview.delegate = self;
            [headerview resetData];
            return headerview;
        }
        else{
            SubObjectHeaderViewForMeVC *headerview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([SubObjectHeaderViewForMeVC class]) forIndexPath:indexPath];
            return headerview;
        }
    }
    else{
        
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(kScreenWidth, CollectionHeaderViewForMeVCHeight);
    }
    return CGSizeMake(kScreenWidth, 27);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
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
