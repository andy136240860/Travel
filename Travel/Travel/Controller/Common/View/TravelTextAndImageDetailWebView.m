//
//  TravelTextAndImageDetailWebView.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/10.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "TravelTextAndImageDetailWebView.h"
#import "Masonry.h"
#import "FBKVOController.h"
@interface TravelTextAndImageDetailWebView()

@property (nonatomic, strong) FBKVOController *KVOController;

@end

@implementation TravelTextAndImageDetailWebView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initSubView];
        [self initAutoLayout];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef lineTop = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(lineTop, kDefaultLineHeight);
    CGContextSetStrokeColorWithColor(lineTop, UIColorFromHex(0xe5e5e5).CGColor);
    CGContextMoveToPoint(lineTop, 0, kDefaultLineHeight/2.f);
    CGContextAddLineToPoint(lineTop, rect.size.width, kDefaultLineHeight/2.f);
    CGContextStrokePath(lineTop);
    
    CGContextRef lineBottom = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(lineBottom, kDefaultLineHeight);
    CGContextSetStrokeColorWithColor(lineBottom, UIColorFromHex(0xe5e5e5).CGColor);
    CGContextMoveToPoint(lineBottom, 0, rect.size.height - kDefaultLineHeight/2.f);
    CGContextAddLineToPoint(lineBottom, rect.size.width, rect.size.height - kDefaultLineHeight/2.f);
    CGContextStrokePath(lineBottom);
    
    NSString *str = [NSString stringWithFormat:@"旅程详情"];
    NSDictionary *attributes  = @{NSForegroundColorAttributeName:UIColorFromHex(0x136d57),NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGSize size = [str boundingRectWithSize:CGSizeMake(rect.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    [str drawInRect:CGRectMake(kPaddingLeft, kPaddingTop, size.width, size.height) withAttributes:attributes];
}

- (void)initSubView {
    _webView = [[UIWebView alloc]init];
    _webView.delegate = self;
    [self addSubview:_webView];
    
    self.KVOController = [[FBKVOController alloc]initWithObserver:self];
    [self.KVOController observe:self.webView.scrollView keyPath:@"contentSize" options:NSKeyValueObservingOptionNew action:@selector(changeContentSizeAction)];
}

- (void)initAutoLayout {
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(kPaddingTop*4);
        make.left.mas_equalTo(self.mas_left).mas_offset(kPaddingLeft);
        make.right.mas_equalTo(self.mas_right).mas_offset(-kPaddingLeft);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-kPaddingTop*2);
        make.height.mas_equalTo(10);
    }];
}

- (void)setHTMLString:(NSString *)HTMLString {
    _HTMLString = HTMLString;
    [_webView loadHTMLString:_HTMLString baseURL:nil];
    [_webView reload];
}

- (void)changeContentSizeAction {
    CGFloat webHeight = self.webView.scrollView.contentSize.height;
    [_webView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(kPaddingTop*4);
        make.left.mas_equalTo(self.mas_left).mas_offset(0);
        make.right.mas_equalTo(self.mas_right).mas_offset(9);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-kPaddingTop*2);
        make.height.mas_equalTo(webHeight);
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_TableHeaderViewFrameChange object:nil];
//    [self invalidateIntrinsicContentSize];
    [self layoutIfNeeded];
    [self setNeedsDisplay];
//    [self.superview layoutIfNeeded];
//    [self.superview setNeedsDisplay];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_webView sizeToFit];
}


@end
