//
//  RegisterAddDetailsVC.m
//  Travel
//
//  Created by 晓炜 郭 on 16/8/9.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "RegisterAddDetailsVC.h"
#import "LoginTextFeildView.h"
#import "AVOSCloud.h"

@interface RegisterAddDetailsVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>{
    UIImageView *_avatarImageView;
    LoginTextFeildView *userTextFeildView;
    LoginTextFeildView *passwordTextFeildView;
    LoginTextFeildView *nameTextFeild;
}
@property (strong,nonatomic)UIActionSheet   * myActionSheet;

@end

@implementation RegisterAddDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.contents = (id)[UIImage imageNamed:@"LoginOrRegisterVC_background"].CGImage;
    [self useTranslucentBackgroundImage];
    // Do any additional setup after loading the view.
}

- (void)loadContentView{
    CGFloat imageViewHeight = 120;
    _avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - imageViewHeight)/2, 20 , imageViewHeight, imageViewHeight)];
    _avatarImageView.clipsToBounds = YES;
    _avatarImageView.layer.cornerRadius = imageViewHeight/2.f;
    _avatarImageView.layer.borderWidth = 2.f;
    _avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _avatarImageView.image = [UIImage imageNamed:@"CollectionHeaderViewForMeVC_userAvatarDefaultImage@2x"];
    _avatarImageView.userInteractionEnabled = YES;
    _avatarImageView.contentMode = 2;
    [self.view addSubview:_avatarImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openMenuAction)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [_avatarImageView addGestureRecognizer:tap];
    
    int intervalY = 30;
    int textFeildWidth = 280 , textFeildHeight = 30;
    
    userTextFeildView = [[LoginTextFeildView alloc]initWithFrame:CGRectMake((kScreenWidth - textFeildWidth)/2,  CGRectGetMaxY(_avatarImageView.frame) + intervalY, textFeildWidth, textFeildHeight) image:[UIImage imageNamed:@"login_icon_phone"]];
    userTextFeildView.contentTextField.placeholder = @"用户名";
    userTextFeildView.contentTextField.textAlignment = NSTextAlignmentRight;
    userTextFeildView.contentTextField.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:userTextFeildView];
    
    passwordTextFeildView = [[LoginTextFeildView alloc]initWithFrame:CGRectMake((kScreenWidth - textFeildWidth)/2, CGRectGetMaxY(userTextFeildView.frame) + intervalY, textFeildWidth, textFeildHeight) image:[UIImage imageNamed:@"login_icon_code"]];
    passwordTextFeildView.contentTextField.placeholder = @"密码";
    passwordTextFeildView.contentTextField.keyboardType = UIKeyboardTypeDefault;
    passwordTextFeildView.contentTextField.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:passwordTextFeildView];
    
    nameTextFeild = [[LoginTextFeildView alloc]initWithFrame:CGRectMake((kScreenWidth - textFeildWidth)/2, CGRectGetMaxY(passwordTextFeildView.frame) + intervalY, textFeildWidth, textFeildHeight) image:[UIImage imageNamed:@"login_icon_code"]];
    nameTextFeild.contentTextField.placeholder = @"姓名(可选)";
    nameTextFeild.contentTextField.keyboardType = UIKeyboardTypeDefault;
    nameTextFeild.contentTextField.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:nameTextFeild];
    
    UIButton *nextButton = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth - textFeildWidth)/2, CGRectGetMaxY(nameTextFeild.frame) + intervalY, textFeildWidth, 42)];
    nextButton.layer.backgroundColor = [UIColor clearColor].CGColor;
    nextButton.layer.cornerRadius = 21.f;
    nextButton.layer.borderColor = [UIColor whiteColor].CGColor;
    nextButton.layer.borderWidth = 1.f;
    [nextButton setTitle:@"下   一   步" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];

}

- (void)nextButtonAction{
    if ([userTextFeildView.contentTextField.text isEmpty]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入用户名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if ([passwordTextFeildView.contentTextField.text isEmpty]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    self.user.username = userTextFeildView.contentTextField.text;
    self.user.password = passwordTextFeildView.contentTextField.text;
    
    __weak __block typeof(self) blockSelf = self;
    [self.user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"注册成功");
            [blockSelf dismissAction];
        } else {
            // 失败的原因可能有多种，常见的是用户名已经存在。
        }
    }];
}

- (void)dismissAction{
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//打开本地相册
-(void)LocalPhoto:(UIActionSheet *)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString * type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
        NSData * data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 0.3);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        [picker removeFromParentViewController];
        
        UIImage * compressedImage = [UIImage imageWithData:data];
        _avatarImageView.image = image;
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Action

- (void)openMenuAction{
    //在这里呼出下方菜单按钮项
    //    NSLog(@"sender.tag = %d",sender.tag);
    self.myActionSheet = [[UIActionSheet alloc]
                          initWithTitle:nil
                          delegate:self
                          cancelButtonTitle:@"取消"
                          destructiveButtonTitle:nil
                          otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    //    myActionSheet.tag = sender.tag;
    
    [self.myActionSheet showInView:self.view];
}

#pragma mark - Request

//上传图片到图片服务器
- (void)requestUploadImage:(UIImage *)image{

}

- (void)loadNavigationBar{
    [self addLeftBackButtonItemWithImage];
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
