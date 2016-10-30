//
//  TravelContentRichTextEditor.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/20.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "TravelContentRichTextEditor.h"
#import "UIViewController+TSMessageHandler.h"
#import "AVOSCloud.h"

@interface TravelContentRichTextEditor ()<UIAlertViewDelegate>

//@property (nonatomic, strong) NSString *tempContentString;

@end

@implementation TravelContentRichTextEditor

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setPlaceholder:@"点此编辑详情"];
    [self addLeftBackButtonItemWithImage];
    [self addRightItemWithTitle:@"保存" target:self action:@selector(save)];

//    NSString *html = @"<!-- This is an HTML comment -->"
//    "<p>This is a test of the <strong>ZSSRichTextEditor</strong> by <a title=\"Zed Said\" href=\"http://www.zedsaid.com\">Zed Said Studio</a></p>";

    // Set the base URL if you would like to use relative links, such as to images.
    self.baseURL = [NSURL URLWithString:@"http://www.zedsaid.com"];
    
    // If you want to pretty print HTML within the source view.
    self.formatHTML = YES;
    
    self.shouldShowKeyboard = !self.contentString.length;
    
//    self.tempContentString = @"";
//    if(self.contentString.length > 0) {
//        self.tempContentString = [self.contentString copy];
//    }
    [self setHTML:self.contentString == nil ? (@""):(self.contentString)];

    
    // set the initial HTML for the editor
//    [self setHTML:html];
    // Do any additional setup after loading the view.
}

- (void)didSelectImage:(UIImage *)image {
    [self showProgressView];
    NSData *data = [NSData dataWithData:UIImagePNGRepresentation(image)];
    AVFile *file = [AVFile fileWithName:@"1.png" data:data];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self hideProgressView];
        if (!error) {
            [self insertImage:file.url alt:nil];
        }
        else {
            [self showWarningWithTitle:@"网络错误，请重试"];
        }
    }];
}

- (void)backAction {
    NSString *html = [self getHTML];
    if ([self.contentString isEqualToString:html] || (self.contentString.length == 0 && html.length == 0)) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"还没有保存，是否保存更改？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"不保存",@"保存", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (buttonIndex == 2) {
        [self save];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)save {
    self.contentString = [self getHTML];
    if ([self.delegate respondsToSelector:@selector(saveContentString:)]) {
        [self.delegate saveContentString:[self.contentString copy]];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
