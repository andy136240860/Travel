//
//  CUUser CUUserManager.m
//  CollegeUnion
//
//  Created by li na on 15/2/18.
//  Copyright (c) 2015年 li na. All rights reserved.
//

#import "CUUserManager.h"
#import "CUServerAPIConstant.h"
#import "AppCore.h"
#import "CUUserParser.h"
#import "SNPlatFormManager.h"
#import "SNNetworkClient.h"
#import "JSONKit.h"
#import "Address.h"
#import "SNHTTPRequestOperationWrapper.h"
#import "TipHandler+HUD.h"

@implementation CUUserManager

SINGLETON_IMPLENTATION(CUUserManager);

- (BOOL)isLogin
{
    return (self.user.token != nil)?YES:NO;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.user = [[CUUser alloc] init];
    }
    return self;
}

- (void)load
{
    CUUser * user = [[AppCore sharedInstance].fileAccessManager loadObjectForKey:Plist_User error:nil];
    if (user != nil)
    {
        self.user = user;
    }
}

- (void)save
{
    [[AppCore sharedInstance].fileAccessManager saveObject:self.user forKey:Plist_User error:nil];
}

- (void)clear
{
    self.user.token = nil;
    self.user.codetoken = nil;
    self.user.profile = nil;
    self.user.nickName = nil;
    self.user.cellPhone = nil;
    self.user.userId = -1;
    self.user.hiddenCellPhone = nil;
    self.user.points = 0;
    self.user.gender = 0;
    self.user.age = 0;
    self.user.level = 0;
    self.user.name = nil;
    self.user.email = nil;
    [[AppCore sharedInstance].fileAccessManager removeObjectForKey:Plist_User error:nil];
}

@end

@implementation CUUserManager (Network)

// 获取手机验证码
- (void)requireVerifyCodeWithCellPhone:(NSString *)cellPhone resultBlock:(SNServerAPIResultBlock)resultBlock pageName:(NSString *)pageName
{
    // param
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObjectSafely:kPlatForm forKey:@"from"];
    [param setObjectSafely:@"0" forKey:@"token"];
    [param setObjectSafely:@"PhoneVerify" forKey:@"require"];
    [param setObjectSafely:@(10000) forKey:@"interfaceID"];
    [param setObjectSafely:@((NSInteger)[NSDate timeIntervalSince1970]) forKey:@"timestamp"];
    
    NSMutableDictionary * dataParam = [NSMutableDictionary dictionary];
    [dataParam setObjectSafely:@"user" forKey:@"appType"];
    [dataParam setObjectSafely:cellPhone forKey:@"phone"];
    [dataParam setObjectSafely:@"0" forKey:@"phoneCode"];
    [dataParam setObjectSafely:[SNPlatformManager deviceString] forKey:@"clientType"];
    [dataParam setObjectSafely:@"1.0.1" forKey:@"clientVer"];
    [dataParam setObjectSafely:[SNPlatformManager deviceId] forKey:@"device"];
    [dataParam setObjectSafely:[SNPlatformManager deviceIdAddress] forKey:@"ip"];
    
    [param setObjectSafely:[dataParam JSONString] forKey:@"data"];
    
    NSLog(@"%@",param);
    
    [[AppCore sharedInstance].apiManager POST:URL_AfterBase parameters:param callbackRunInGlobalQueue:YES parser:nil parseMethod:nil resultBlock:resultBlock forKey:URL_AfterBase forPageNameGroup:pageName];
}

// 注册
- (void)registerWithCellPhone:(NSString *)cellPhone verifyCode:(NSInteger)verifyCode resultBlock:(SNServerAPIResultBlock)resultBlock pageName:(NSString *)pageName
{
    // param
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObjectSafely:@"kPlatForm user" forKey:@"from"];
    [param setObjectSafely:@"V1.0" forKey:@"version"];
    [param setObjectSafely:[SNPlatformManager deviceId] forKey:@"deviceinfo"];
    [param setObjectSafely:@"0" forKey:@"token"];
    [param setObjectSafely:@"register" forKey:@"require"];
    [param setObjectSafely:@"0" forKey:@"lantitude"];
    [param setObjectSafely:@"0" forKey:@"lontitude"];
    [param setObjectSafely:@"true" forKey:kPlatForm];
    
    NSMutableDictionary * dataParam = [NSMutableDictionary dictionary];
    [dataParam setObjectSafely:cellPhone forKey:@"phone"];
    [dataParam setObjectSafely:@(verifyCode) forKey:@"code"];
    [dataParam setObjectSafely:self.user.codetoken forKey:@"codetoken"];
    [dataParam setObjectSafely:@"0" forKey:@"accountid"];
    
    [param setObjectSafely:[dataParam JSONString] forKey:@"data"];
    
//    CUUserParser * parser = [[CUUserParser alloc] init];
    __block CUUserManager * blockSelf = self;
    
    [[AppCore sharedInstance].apiManager POST:URL_AfterBase parameters:param callbackRunInGlobalQueue:YES parser:nil parseMethod:nil resultBlock:^(SNHTTPRequestOperation *request, SNServerAPIResultData *result) {
        
//        if (!result.hasError && ![(NSNumber *)[result.responseObject valueForKey:@"err_code"] integerValue])
        if (!result.hasError)
        {
            // 赋值user数据
            blockSelf.user.token = [result.responseObject stringForKeySafely:@"token"];
            blockSelf.user.cellPhone = [[result.responseObject dictionaryForKeySafely:@"data"] stringForKeySafely:@"phone"];
            blockSelf.user.accountNum = [[result.responseObject dictionaryForKeySafely:@"data"] stringForKeySafely:@"accountid"];
            blockSelf.user.userId = [[result.responseObject dictionaryForKeySafely:@"data"] integerForKeySafely:@"iduser"];
            [blockSelf save];
        }
        resultBlock(request,result);
    } forKey:URL_AfterBase forPageNameGroup:pageName];
}

// 手机号+验证码登录
- (void)loginWithCellPhone:(NSString *)cellPhone code:(NSString *)code codetoken:(NSString *)codetoken resultBlock:(SNServerAPIResultBlock)resultBlock pageName:(NSString *)pageName
{
    // param
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObjectSafely:kPlatForm forKey:@"from"];
    [param setObjectSafely:@"0" forKey:@"token"];
    [param setObjectSafely:@"UserLogin" forKey:@"require"];
    [param setObjectSafely:@(13002) forKey:@"interfaceID"];
    [param setObjectSafely:@((NSInteger)[NSDate timeIntervalSince1970]) forKey:@"timestamp"];
    
    NSMutableDictionary * dataParam = [NSMutableDictionary dictionary];
    [dataParam setObjectSafely:@(0) forKey:@"accID"];
    [dataParam setObjectSafely:@([cellPhone longLongValue]) forKey:@"phone"];
    [dataParam setObjectSafely:code forKey:@"phoneCode"];
    [dataParam setObjectSafely:[SNPlatformManager deviceString] forKey:@"clientType"];
    [dataParam setObjectSafely:@"1.0.1" forKey:@"clientVer"];
    [dataParam setObjectSafely:[SNPlatformManager deviceId] forKey:@"device"];
    [dataParam setObjectSafely:[SNPlatformManager deviceIdAddress] forKey:@"ip"];
    [dataParam setObjectSafely:@"成都市" forKey:@"region"];
    [dataParam setObjectSafely:kCurrentLat forKey:@"latitude"];
    [dataParam setObjectSafely:kCurrentLng forKey:@"longtitude"];
    
    [param setObjectSafely:[dataParam JSONString] forKey:@"data"];
    
    NSLog(@"%@",param);
    
    __block CUUserManager * blockSelf = self;
    
    [[AppCore sharedInstance].apiManager POST:URL_AfterBase parameters:param callbackRunInGlobalQueue:YES parser:nil parseMethod:nil resultBlock:^(SNHTTPRequestOperation *request, SNServerAPIResultData *result) {
        if (!result.hasError)
        {
            // 赋值user数据
            NSInteger err_code = [[result.responseObject valueForKey:@"errorCode"]integerValue];
            switch (err_code) {
                case 0:{

                    
                    NSDictionary *data = [result.responseObject dictionaryForKeySafely:@"data"];
                    
                    blockSelf.user.userId = [data integerForKeySafely:@"accID"];
                    blockSelf.user.nickName = [data stringForKeySafely:@"name"];
                    blockSelf.user.icon = [data stringForKeySafely:@"icon"];
                    blockSelf.user.token =  [data stringForKeySafely:@"token"];
                    NSLog(@"cellPhone:%@",blockSelf.user.cellPhone);
                    NSLog(@"userId:%d",blockSelf.user.userId );
                    [blockSelf save];
                }
                    break;
                case -1:{
                    [TipHandler showTipOnlyTextWithNsstring:[NSString stringWithFormat:@"%@",[result.responseObject stringForKeySafely:@"data"]]];
                }
                    break;
                default:
                    break;
            }
        }else if(result.hasError){
            [TipHandler showTipOnlyTextWithNsstring:[NSString stringWithFormat:@"网络连接错误"]];
        }
        resultBlock(request,result);
    } forKey:URL_AfterBase forPageNameGroup:pageName];
}
- (void)loginWithCellPhone:(NSString *)name password:(NSString *)password resultBlock:(SNServerAPIResultBlock)resultBlock pageName:(NSString *)pageName
{
    // param
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObjectSafely:@"kPlatForm user" forKey:@"from"];
    [param setObjectSafely:@"V1.0" forKey:@"version"];
    [param setObjectSafely:[SNPlatformManager deviceId] forKey:@"deviceinfo"];
    [param setObjectSafely:@"0" forKey:@"token"];
    [param setObjectSafely:@"login_my" forKey:@"require"];
    [param setObjectSafely:@"0" forKey:@"lantitude"];
    [param setObjectSafely:@"0" forKey:@"lontitude"];
    [param setObjectSafely:@"phonecode" forKey:@"logintype"];
    [param setObjectSafely:@"true" forKey:kPlatForm];
    
    NSMutableDictionary * dataParam = [NSMutableDictionary dictionary];
    [dataParam setObjectSafely:name forKey:@"phone"];
    [dataParam setObjectSafely:password forKey:@"code"];
    [dataParam setObjectSafely:@"0" forKey:@"email"];
    [dataParam setObjectSafely:@"0" forKey:@"account"];
    [dataParam setObjectSafely:@"2" forKey:@"accountid"];
    
    [param setObjectSafely:[dataParam JSONString] forKey:@"data"];
    
    CUUserParser * parser = [[CUUserParser alloc] init];
    __block CUUserManager * blockSelf = self;
    
    [[AppCore sharedInstance].apiManager POST:URL_AfterBase parameters:param callbackRunInGlobalQueue:YES parser:parser parseMethod:@selector(parseLoginWithDict:) resultBlock:^(SNHTTPRequestOperation *request, SNServerAPIResultData *result) {
        if (!result.hasError && ![(NSNumber *)[result.responseObject valueForKey:@"err_code"] integerValue])
        {
            // 赋值user数据
//            blockSelf.user.name = name;
//            blockSelf.user.userId = ((CUUser *)result.parsedModelObject).userId;
            blockSelf.user.token = [result.responseObject stringForKeySafely:@"token"];
            NSDictionary *data = [result.responseObject dictionaryForKeySafely:@"data"];
            
            blockSelf.user.cellPhone = [data stringForKeySafely:@"phone"];
            if ((NSNumber *)[data stringForKeySafely:@"ismail"]) {
                blockSelf.user.email = [data stringForKeySafely:@"mail"];
            }
            blockSelf.user.userId = [data integerForKeySafely:@"no"];
            blockSelf.user.accountNum = [data stringForKeySafely:@"accountid"];
            [blockSelf save];
        }
        resultBlock(request,result);
    } forKey:URL_AfterBase forPageNameGroup:pageName];
}

// 登出
- (void)logoutWithUser:(CUUser *)user resultBlock:(SNServerAPIResultBlock)resultBlock pageName:(NSString *)pageName
{
    // param
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObjectSafely:user.token forKey:Key_Token];
    
    CUUserParser * parser = [[CUUserParser alloc] init];
    __block CUUserManager * blockSelf = self;
    
    [[AppCore sharedInstance].apiManager GET:URL_AfterBase parameters:param callbackRunInGlobalQueue:YES parser:parser parseMethod:@selector(parseLogoutWithDict:) resultBlock:^(SNHTTPRequestOperation *request, SNServerAPIResultData *result) {
        if (!result.hasError)
        {
            // 赋值user数据
            [blockSelf clear];
            [blockSelf save];
        }
        resultBlock(request,result);
    }  forKey:URL_AfterBase forPageNameGroup:pageName];
}

// 获取用户信息
- (void)getUserInfo:(NSString *)token resultBlock:(SNServerAPIResultBlock)resultBlock// pageName:(NSString *)pageName
{
    // param
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObjectSafely:@"kPlatForm user" forKey:@"from"];
    [param setObjectSafely:@"V1.0" forKey:@"version"];
    [param setObjectSafely:[SNPlatformManager deviceId] forKey:@"deviceinfo"];
    [param setObjectSafely:token forKey:@"token"];
    [param setObjectSafely:@"myspace" forKey:@"require"];
    [param setObjectSafely:@"0" forKey:@"lantitude"];
    [param setObjectSafely:@"0" forKey:@"lontitude"];
    [param setObjectSafely:@"true" forKey:kPlatForm];
    
    NSMutableDictionary * dataParam = [NSMutableDictionary dictionary];
    [dataParam setObjectSafely:[CUUserManager sharedInstance].user.cellPhone forKey:@"phone"];
    [dataParam setObjectSafely:( [[CUUserManager sharedInstance] isLogin] ? [CUUserManager sharedInstance].user.accountNum : @"0" ) forKey:@"accountid"];
    
    [param setObjectSafely:[dataParam JSONString] forKey:@"data"];
    
    __block CUUserManager * blockSelf = self;
    [[AppCore sharedInstance].apiManager POST:URL_AfterBase parameters:param callbackRunInGlobalQueue:YES parser:nil parseMethod:nil resultBlock:^(SNHTTPRequestOperation *request, SNServerAPIResultData *result) {
        if (!result.hasError && ![(NSNumber *)[result.responseObject valueForKey:@"err_code"] integerValue])
        {
            // 赋值user数据
            NSDictionary *data = [result.responseObject dictionaryForKeySafely:@"data"];
            NSArray *expressAddressList = [data valueForKey:@"list_express_address"];
            [expressAddressList enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop){
                
                Address *addressItem = [[Address alloc] init];
                addressItem.cellPhone = [obj valueForKey:@"phone"];
                // TODO: Address数据结构与服务器返回不统一，且服务器返回明显有误
                
            }];
            [blockSelf save];
        }
        resultBlock(request,result);
    }   forKey:@"myspace"];
}

// 修改用户信息
- (void)updateUserInfo:(CUUser *)user resultBlock:(SNServerAPIResultBlock)resultBlock pageName:(NSString *)pageName
{
    // param
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObjectSafely:user.token forKey:Key_Token];
    [param setObjectSafely:user.nickName forKey:@"nickname"];
    
    NSString *baseURL = [NSString stringWithFormat:@"%@/",URL_ImageBase];
    NSString *profile = [user.profile stringByReplacingOccurrencesOfString:baseURL withString:@""];
    if (profile.length) {
        [param setObjectSafely:profile forKey:@"avatar"];
    }
    
    CUUserParser * parser = [[CUUserParser alloc] init];
    __block CUUserManager * blockSelf = self;
    [[AppCore sharedInstance].apiManager GET:URL_AfterBase parameters:param callbackRunInGlobalQueue:YES parser:parser parseMethod:@selector(parseUpdateUserInfoWithDict:) resultBlock:^(SNHTTPRequestOperation *request, SNServerAPIResultData *result) {
        if (!result.hasError)
        {
            // 赋值user数据
            NSString * profile = user.profile;
            NSString * nickName = user.nickName;
            
            if (profile != nil)
            {
                blockSelf.user.profile = profile;
            }
            if (nickName != nil)
            {
                blockSelf.user.nickName = nickName;
            }
            [blockSelf save];
        }
        resultBlock(request,result);
    } forKey:URL_AfterBase forPageNameGroup:pageName];
}

- (void)uploadAvatar:(UIImage *)image resultBlock:(SNServerAPIResultBlock)resultBlock pageName:(NSString *)pageName
{
    CUUserParser * parser = [[CUUserParser alloc] init];
    
    SNNetworkClient *httpClient = [[SNNetworkClient alloc] initWithBaseURL:[NSURL URLWithString:URL_Base]];
    
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:@"/Api/V1/upload" parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:@"file" fileName:@"upload.png" mimeType:@"image/png"];
    }];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    __weak CUUserManager * blockSelf = self;

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [string objectFromJSONString];
        
        SNServerAPIResultData * result = [[SNServerAPIResultData alloc] init];
        
        result.parsedModelObject = [parser performSelector:@selector(parseUploadAvatarWithDict:) withObject:dic];
        
        result.hasError = parser.hasError;
        
        if (!result.hasError && result.parsedModelObject) {
            blockSelf.user.profile = result.parsedModelObject;
            
            [blockSelf updateUserInfo:blockSelf.user resultBlock:^(SNHTTPRequestOperation * request,SNServerAPIResultData * result) {
                
            } pageName:@"ESJ_UpdateUserInfo"];
        }
        
        resultBlock(nil, result);
        
        NSLog(@"传图片成功 %@",dic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"传图片失败 %@",error);
    }];
    [operation start];
    
//    [[AppCore sharedInstance].apiManager GET:URL_ImageUpload parameters:nil callbackRunInGlobalQueue:YES parser:parser parseMethod:@selector(parseUploadAvatarWithDict:) resultBlock:resultBlock forKey:URL_ImageUpload forPageNameGroup:pageName];
}

- (void)uploadImageArray:(NSMutableArray *)imageArray resultBlock:(SNServerAPIResultBlock)resultBlock pageName:(NSString *)pageName progressBlock:(SNServerAPIProgressBlock)progressBlock
{
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObjectSafely:[NSString stringWithFormat:@"%ld",(long)[CUUserManager sharedInstance].user.userId] forKey:@"imgofwho"];
    [param setObjectSafely:@"pud" forKey:@"imgtype"];
    [param setObjectSafely:[CUUserManager sharedInstance].user.cellPhone forKey:@"phone"];
    
    SNNetworkClient *httpClient = [[SNNetworkClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://123.56.251.146:8080"]];
    
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:URL_ImageUpload parameters:param constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        for (int i = 0; i < imageArray.count; ++i) {
            UIImage *image = (UIImage *)[imageArray objectAtIndex:i];
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.3) name:@"file" fileName:[NSString stringWithFormat:@"DiseaseImage%d.png",i] mimeType:@"image/png"];
        }
    }];
    
    SNHTTPRequestOperationWrapper *wrapper = [[SNHTTPRequestOperationWrapper alloc] initWithRequest:request successBlock:^(SNHTTPRequestOperationWrapper *operationWrapper, id responseObject) {
        
    }
       failureBlock:^(SNHTTPRequestOperationWrapper *operationWrapper, NSError *error) {
       
    }];
    wrapper.uploadProgressBlock = ^(double progress, long long totalBytes, long long uploadedBytes){
        NSLog(@"%0.1f", progress);
        if (progressBlock) {
            progressBlock(progress);
        }
    };
    
    AFHTTPRequestOperation *operation = [[SNNetworkClient alloc] HTTPRequestOperationWithRequest:request wrapper:wrapper];
    
    //    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    //    __ weak CurrentTreatmentDetailsManager * blockSelf = self;
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [string objectFromJSONString];
        
        SNServerAPIResultData * result = [[SNServerAPIResultData alloc] init];
        
        result.responseObject = dic;
        result.hasError = NO;
        resultBlock(nil, result);
        
        NSLog(@"传图片成功 %@",dic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"传图片失败 %@",error);
    }];
    [operation start];
    
    //    [[AppCore sharedInstance].apiManager POST:URL_ImageUpload parameters:nil callbackRunInGlobalQueue:YES parser:parser parseMethod:@selector(parseUploadAvatarWithDict:) resultBlock:resultBlock forKey:URL_ImageUpload forPageNameGroup:pageName];
}

- (void)updateUser:(CUUser *)user oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword resultBlock:(SNServerAPIResultBlock)resultBlock pageName:(NSString *)pageName
{
    // param
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObjectSafely:user.token forKey:Key_Token];
    [param setObjectSafely:oldPassword forKey:@"password"];
    [param setObjectSafely:newPassword forKey:@"password"];
    
    CUUserParser * parser = [[CUUserParser alloc] init];
    __block CUUserManager * blockSelf = self;
    [[AppCore sharedInstance].apiManager GET:URL_AfterBase parameters:param callbackRunInGlobalQueue:YES parser:parser parseMethod:@selector(parseUpdateUserInfoWithDict:) resultBlock:^(SNHTTPRequestOperation *request, SNServerAPIResultData *result) {
        if (!result.hasError)
        {
            
        }
        resultBlock(request,result);
    } forKey:URL_AfterBase forPageNameGroup:pageName];
}

- (void)updateUser:(CUUser *)user password:(NSString *)password verifyCode:(NSString *)code resultBlock:(SNServerAPIResultBlock)resultBlock pageName:(NSString *)pageName
{
    // param
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObjectSafely:user.token forKey:Key_Token];
    [param setObjectSafely:password forKey:@"password"];
    [param setObjectSafely:code forKey:@"code"];
    
    CUUserParser * parser = [[CUUserParser alloc] init];
    __block CUUserManager * blockSelf = self;
    [[AppCore sharedInstance].apiManager GET:URL_AfterBase parameters:param callbackRunInGlobalQueue:YES parser:parser parseMethod:@selector(parseUpdateUserInfoWithDict:) resultBlock:^(SNHTTPRequestOperation *request, SNServerAPIResultData *result) {
        if (!result.hasError)
        {
            
        }
        resultBlock(request,result);
    } forKey:URL_AfterBase forPageNameGroup:pageName];
}

- (void)updateUser:(CUUser *)user password:(NSString *)password resultBlock:(SNServerAPIResultBlock)resultBlock pageName:(NSString *)pageName
{
    // param
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObjectSafely:@"kPlatForm user" forKey:@"from"];
    [param setObjectSafely:@"V1.0" forKey:@"version"];
    [param setObjectSafely:[SNPlatformManager deviceId] forKey:@"deviceinfo"];
//    [param setObjectSafely:@"this-token-for-debug" forKey:Key_Token];
    [param setObjectSafely:user.token forKey:Key_Token];
    [param setObjectSafely:@"first_set_password" forKey:@"require"];
    [param setObjectSafely:@"0" forKey:@"lantitude"];
    [param setObjectSafely:@"0" forKey:@"lontitude"];
    [param setObjectSafely:@"true" forKey:kPlatForm];
    
    NSMutableDictionary * dataParam = [NSMutableDictionary dictionary];
//    [dataParam setObjectSafely:@"15008441755" forKey:@"phone"];
    [dataParam setObjectSafely:user.cellPhone forKey:@"phone"];
    [dataParam setObjectSafely:password forKey:@"code"];
    [dataParam setObjectSafely:user.codetoken forKey:@"codetoken"];
    [dataParam setObjectSafely:user.accountNum forKey:@"accountid"];
    
    [param setObjectSafely:[dataParam JSONString] forKey:@"data"];
    
//    __block __weak CUUserManager *blockSelf = self;
    [[AppCore sharedInstance].apiManager POST:URL_AfterBase parameters:param callbackRunInGlobalQueue:YES parser:nil parseMethod:nil resultBlock:resultBlock forKey:@"first_set_password" forPageNameGroup:pageName];
}

- (void)updateUser:(CUUser *)user emailAddress:(NSString *)emailAddress resultBlock:(SNServerAPIResultBlock)resultBlock pageName:(NSString *)pageName
{
    // param
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObjectSafely:kPlatForm forKey:@"from"];
    [param setObjectSafely:@"V1.0" forKey:@"version"];
    [param setObjectSafely:[SNPlatformManager deviceId] forKey:@"deviceinfo"];
    [param setObjectSafely:user.token forKey:Key_Token];
    [param setObjectSafely:@"account_mail" forKey:@"require"];
    [param setObjectSafely:kCurrentLat forKey:@"lantitude"];
    [param setObjectSafely:kCurrentLng forKey:@"lontitude"];
    [param setObjectSafely:@"true" forKey:kPlatForm];
    
    NSMutableDictionary * dataParam = [NSMutableDictionary dictionary];
    [dataParam setObjectSafely:user.cellPhone forKey:@"phone"];
    [dataParam setObjectSafely:user.codetoken forKey:@"codetoken"];
    [dataParam setObjectSafely:emailAddress forKey:@"newemail"];
    [dataParam setObjectSafely:user.accountNum forKey:@"accountid"];
    
    [param setObjectSafely:[dataParam JSONString] forKey:@"data"];
    
    //    __block __weak CUUserManager *blockSelf = self;
    [[AppCore sharedInstance].apiManager POST:URL_AfterBase parameters:param callbackRunInGlobalQueue:YES parser:nil parseMethod:nil resultBlock:resultBlock forKey:@"account_mail" forPageNameGroup:pageName];
}

- (void)getMyDiagnosisRecordsWithUser:(CUUser *)user resultBlock:(SNServerAPIResultBlock)resultBlock pageName:(NSString *)pageName{
    // param
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObjectSafely:kPlatForm forKey:@"from"];
    [param setObjectSafely:( [[CUUserManager sharedInstance] isLogin] ? [CUUserManager sharedInstance].user.token : @"0" ) forKey:@"token"];
    [param setObjectSafely:@"MyDiagnosisRecords" forKey:@"require"];
    [param setObjectSafely:@(13103) forKey:@"interfaceID"];
    [param setObjectSafely:@((NSInteger)[NSDate timeIntervalSince1970]) forKey:@"timestamp"];
    
    NSMutableDictionary * dataParam = [NSMutableDictionary dictionary];
    [dataParam setObjectSafely:@( [[CUUserManager sharedInstance] isLogin] ? [CUUserManager sharedInstance].user.userId : 0 ) forKey:@"accID"];
    
    [param setObjectSafely:[dataParam JSONString] forKey:@"data"];
    
    NSLog(@"%@",param);
    
    [[AppCore sharedInstance].apiManager POST:URL_AfterBase parameters:param callbackRunInGlobalQueue:YES parser:nil parseMethod:nil resultBlock:^(SNHTTPRequestOperation *request, SNServerAPIResultData *result) {
        if (!result.hasError)
        {
            // 赋值user数据
            NSInteger err_code = [[result.responseObject valueForKey:@"errorCode"]integerValue];
            switch (err_code) {
                case 0:{
                    
                    
                    NSDictionary *data = [result.responseObject dictionaryForKeySafely:@"data"];

                }
                    break;
                    
                default:
                    break;
            }
        }
        resultBlock(request,result);
    } forKey:URL_AfterBase forPageNameGroup:pageName];
}

//11501接口 添加新约诊人
- (void)AddDiagnosisMemberWithDiagnosisID:(long long)diagnosisID name:(NSString *)name sex:(NSInteger)sex age:(NSInteger)age phone:(long long)phone resultBlock:(SNServerAPIResultBlock)resultBlock pageName:(NSString *)pageName{
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObjectSafely:kPlatForm forKey:@"from"];
    [param setObjectSafely:( [[CUUserManager sharedInstance] isLogin] ? [CUUserManager sharedInstance].user.token : @"0" ) forKey:@"token"];
    [param setObjectSafely:@"AddDiagnosisMember" forKey:@"require"];
    [param setObjectSafely:@(11501) forKey:@"interfaceID"];
    [param setObjectSafely:@((NSInteger)[NSDate timeIntervalSince1970]) forKey:@"timestamp"];
    
    NSMutableDictionary * dataParam = [NSMutableDictionary dictionary];
    [dataParam setObjectSafely:@( [[CUUserManager sharedInstance] isLogin] ? [CUUserManager sharedInstance].user.userId : 0 ) forKey:@"accID"];
    [dataParam setObjectSafely:@(diagnosisID) forKey:@"diagnosisID"];
    [dataParam setObjectSafely:name forKey:@"name"];
    [dataParam setObjectSafely:@(age) forKey:@"age"];
    [dataParam setObjectSafely:@(sex) forKey:@"sex"];
    [dataParam setObjectSafely:@(phone) forKey:@"phone"];
    
    [param setObjectSafely:[dataParam JSONString] forKey:@"data"];
    
    NSLog(@"%@",param);
    
    [[AppCore sharedInstance].apiManager POST:URL_AfterBase parameters:param callbackRunInGlobalQueue:YES parser:nil parseMethod:nil resultBlock:^(SNHTTPRequestOperation *request, SNServerAPIResultData *result) {
        if (!result.hasError)
        {
            // 赋值user数据
            NSInteger err_code = [[result.responseObject valueForKey:@"errorCode"]integerValue];
            switch (err_code) {
                case 0:{
                    NSString *string = [[result.responseObject dictionaryForKeySafely:@"data"] valueForKey:@"userID"];
                    result.parsedModelObject = string;
                }
                    break;
                    
                default:
                    break;
            }
        }
        resultBlock(request,result);
    } forKey:URL_AfterBase forPageNameGroup:pageName];
}
@end
