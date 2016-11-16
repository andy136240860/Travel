//
//  TravelTextAndImageDetailWebView.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/10.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelTextAndImageDetailWebView : UIView<UIWebViewDelegate>

- (instancetype)init;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, copy  ) NSString  *HTMLString;

@end
