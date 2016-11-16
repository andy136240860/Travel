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
#import "UIViewController+Login.h"
#import "MyTravelViewController.h"
#import "MyTravelDetailViewController.h"
#import "SettingViewController.h"
#import "AVOSCloud.h"
#import "XWUser.h"

@interface MeViewController ()<EqualSpaceFlowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource,CollectionHeaderViewForMeVCDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic)CollectionHeaderViewForMeVC *collectionHeaderview;

@end

@implementation MeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    if (_collectionHeaderview) {
        [_collectionHeaderview resetData];
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)loadContentView{
    self.view.backgroundColor = [UIColor whiteColor];
    EqualSpaceFlowLayout *collectionLayout = [[EqualSpaceFlowLayout alloc] init];
//    UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
    collectionLayout.delegate = self;
    
    CGRect collectionFrame = CGRectMake(0, 0 , kScreenWidth, self.view.frameHeight - kTabBarHeight);
    
    UICollectionView *collectionview = [[UICollectionView alloc] initWithFrame:collectionFrame collectionViewLayout:collectionLayout];
    collectionview.backgroundColor = [UIColor clearColor];
    collectionview.delegate = self;
    collectionview.dataSource = self;
    [self.view addSubview:collectionview];
    
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
            vc.hidesBottomBarWhenPushed = YES;
            [self pushViewControllerWithVerifyLogin:vc animated:YES];
        }
            break;
        case CollectionHeaderViewModel_userName:{
            NSLog(@"点击名字的Label了， 因为未登录， 调用登陆页面");
        }
            break;
        case CollectionHeaderViewModel_myTravel:{
            NSLog(@"我的旅程");
            MyTravelDetailViewController *vc = [[MyTravelDetailViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
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
        case CollectionHeaderViewModel_myCollectionHeaderViewBackgrondImage:{
            NSLog(@"更改header背景图");
            [self openMenu];
        }
            break;
        case CollectionHeaderViewModel_setting:{
            NSLog(@"设置");
            SettingViewController *vc = [[SettingViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case CollectionHeaderViewModel_inbox:{
            NSLog(@"inbox");
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
            _collectionHeaderview = headerview;
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
    return CGSizeMake(kScreenWidth, 0);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 弹出选择照片
-(void)openMenu
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择背景图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    UIAlertAction *localPhotoAction = [UIAlertAction actionWithTitle:@"从手机相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self LocalPhoto];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:takePhotoAction];
    [alertController addAction:localPhotoAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = NO;
    [self presentViewController:picker animated:YES completion:nil];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"])
    {
        UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        [picker removeFromParentViewController];
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
        [self didSelectImage:image];
    }
    
}

- (void)didSelectImage:(UIImage *)image {
    [self showProgressView];
    NSData *data = [NSData dataWithData:UIImagePNGRepresentation(image)];
    AVFile *file = [AVFile fileWithName:@"1.png" data:data];
    __weak __block typeof(self) blockSelf = self;
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [blockSelf hideProgressView];
        if (!error) {
            [XWUser currentUser].mySpaceBackgroundImageURL = file.url;
            [[XWUser currentUser] saveInBackground];
            [_collectionHeaderview resetData];
        }
        else {
            [self showWarningWithTitle:@"网络错误，请重试"];
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
