//
//  CUViewController.h
//  CollegeUnion
//
//  Created by li na on 15/3/4.
//  Copyright (c) 2015年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SNExtension.h"
#import "MBProgressHUD.h"

@interface CUViewController : UIViewController

@property (nonatomic,strong,readonly) UIView * contentView;
//@property (nonatomic,assign)BOOL hasTab;
@property (nonatomic,assign,readonly)CGFloat keybordHeight;
//@property (nonatomic,strong)NSString * pageName;

//- (void)setShouldHaveTab;
- (void)loadNavigationBar;
- (void)loadContentView;
- (void)removeContentView;
//- (instancetype)initWithPageName:(NSString *)pageName;

@end


@interface CUViewController (keybord)

-(void)setViewMovedUp:(CGFloat)movedUpOffSet;
-(void)setViewMovedDown:(CGFloat)movedUpOffSet;

@end
