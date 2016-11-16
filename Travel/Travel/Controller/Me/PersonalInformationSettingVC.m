//
//  PersonalInformationSettingVC.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/13.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "PersonalInformationSettingVC.h"
#import "XWUser.h"
#import "CircularImageViewTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NSDate+SNExtension.h"
#import "AVOSCloud.h"

@interface PersonalInformationSettingVC ()<UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView *contentTableView;

@end

@implementation PersonalInformationSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    // Do any additional setup after loading the view.
}


- (void)loadContentView {
    _contentTableView = [[UITableView alloc]initWithFrame:self.contentView.bounds style:UITableViewStyleGrouped];
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    _contentTableView.tableFooterView = [UIView new];
    _contentTableView.backgroundColor = kTableViewGrayColor;
    [self.contentView addSubview:_contentTableView];
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 5;
            break;
        case 3:
            return 2;
            break;
        case 4:
            return 3;
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 88;
    }
    else return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"defaultCell";
    static NSString * userImageViewCell = @"userImageViewCell";
    if (indexPath.section == 0 && indexPath.row == 0) {
        CircularImageViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:userImageViewCell];
        if (!cell) {
            cell = [[CircularImageViewTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:userImageViewCell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        XWUser *myuser = [XWUser currentUser];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:myuser.avatarURL] placeholderImage:[UIImage imageNamed:@"CollectionHeaderViewForMeVC_userAvatarDefaultImage"]];
        cell.detailTextLabel.text = @"更改头像";
        return cell;
    }
    else {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 1:
                    cell.textLabel.text = @"用户名";
                    cell.detailTextLabel.text = [XWUser currentUser].username;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                case 2:
                    cell.textLabel.text = @"用户昵称";
                    cell.detailTextLabel.text = [XWUser currentUser].nickName.length > 0 ? [XWUser currentUser].nickName : @"未设置" ;
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                default:
                    break;
            }
        }
        if (indexPath.section == 1) {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"手机号码";
                    cell.detailTextLabel.text = [XWUser currentUser].mobilePhoneNumber;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                case 1:
                    cell.textLabel.text = @"邮箱";
                    cell.detailTextLabel.text = [XWUser currentUser].email.length > 0 ? [XWUser currentUser].email : @"未设置";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                default:
                    break;
            }
        }
        if (indexPath.section == 2) {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"真实姓名";
                    cell.detailTextLabel.text = [XWUser currentUser].realName.length > 0 ? [XWUser currentUser].realName : @"未设置";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                case 1:
                    cell.textLabel.text = @"地区";
                    cell.detailTextLabel.text = [XWUser currentUser].locationString.length > 0 ? [XWUser currentUser].locationString : @"未设置";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                case 2:
                    cell.textLabel.text = @"性别";
                    cell.detailTextLabel.text = [XWUser currentUser].gender == 0 ? @"男" : @"女";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                case 3:
                    cell.textLabel.text = @"生日";
                    cell.detailTextLabel.text = [XWUser currentUser].birthday == 0 ? [[NSDate dateWithTimeIntervalSince1970:[XWUser currentUser].birthday] stringWithDateFormat:@"yyyy-MM-dd"] : @"未设置";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                case 4:
                    cell.textLabel.text = @"职业";
                    cell.detailTextLabel.text = [XWUser currentUser].profession.length > 0 ? [XWUser currentUser].locationString : @"未设置";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                default:
                    break;
            }
        }
        if (indexPath.section == 3) {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"自我介绍";
                    cell.detailTextLabel.text = [XWUser currentUser].selfIntroduction.length > 0 ? [XWUser currentUser].selfIntroduction : @"未设置";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                case 1:
                    cell.textLabel.text = @"个性签名";
                    cell.detailTextLabel.text = [XWUser currentUser].signature.length > 0 ? [XWUser currentUser].signature : @"未设置";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                default:
                    break;
            }
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self openMenu];
                break;
                
            default:
                break;
        }
    }
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
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
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
            [XWUser currentUser].avatarURL = file.url;
            [[XWUser currentUser] saveInBackground];
            [blockSelf.contentTableView reloadData];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
