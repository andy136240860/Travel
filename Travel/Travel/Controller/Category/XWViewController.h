//
//  XWViewController.h
//  Travel
//
//  Created by 晓炜 郭 on 16/8/17.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+NavBarTool.h"
#import "UIViewController+SNExtension.h"
#import "UIViewController+TSMessageHandler.h"
//#import "UIViewController+TitleView.h"

@interface XWViewController : UIViewController

@property (nonatomic,strong,readonly) UIView * contentView;

- (void)loadContentView;

+ (UIViewController*)currentViewController;
@end
