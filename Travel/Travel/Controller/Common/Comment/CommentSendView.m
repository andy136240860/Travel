//
//  CommentSendView.m
//  Bueaty
//
//  Created by zhouzhenhua on 16/4/10.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "CommentSendView.h"

#define kCommentBannerHeight      50.0

#define kCommentTextDefaultHeight 33.0
#define kCommentTextSingleHeight  17  // 14的字号，单行高度17

#define kCommentMaskAlpha         0.5

#define kNumberMaxLength          2000

@implementation CommentSendView
{
    UIButton    *maskButton;
    UIImageView *commentBanner;
    UITextView  *commentTextView;
    UIImageView *commentTextBg;
    UIButton    *sendButton;
    UILabel     *numberLabel;
    UILabel     *placeholderLabel;
    
    BOOL         _keyboardShowing;
    int          lastContentHeight;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init
{
    self = [super init];
    
    if (self) {
        [self initSubviews];
        
        [self addNotifications];
    }
    
    return self;
}

- (void)addNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)initSubviews
{
    maskButton = [UIButton buttonWithType:UIButtonTypeCustom];
    maskButton.frame = self.bounds;
    maskButton.alpha = 0;
    maskButton.adjustsImageWhenHighlighted = NO;
    //maskButton.backgroundColor = [UIColor blackColor];
    maskButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [maskButton addTarget:self action:@selector(backgroundPress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:maskButton];
    
    commentBanner = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kCommentBannerHeight)];
    //commentBanner.image = [[UIImage imageNamed:@"comment_banner_bg"] stretchableImageByCenter];
    commentBanner.backgroundColor = [UIColor whiteColor];
    commentBanner.userInteractionEnabled = YES;
    [self addSubview:commentBanner];
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, commentBanner.frameWidth, kDefaultLineHeight)];
    topLine.backgroundColor = kLightLineColor;
    [commentBanner addSubview:topLine];
    
    CGFloat leftPadding = 10.0;
    CGFloat rightPadding = 10.0;
    CGFloat textBgHeight = 30.0;
    CGFloat topPadding = 10.0;
    
    CGFloat btnWidth = 60.0;
    CGFloat btnHeight = 30.0;
    sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(CGRectGetWidth(commentBanner.bounds) - rightPadding - btnWidth, topPadding, btnWidth, btnHeight);
    [sendButton setBackgroundImage:[UIImage imageNamed:@"content_comment_buttom_selected"] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sendButtonPress) forControlEvents:UIControlEventTouchUpInside];
    sendButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [commentBanner addSubview:sendButton];
    
    CGFloat textBgWidth = CGRectGetMinX(sendButton.frame) - 10 - leftPadding;
    commentTextBg = [[UIImageView alloc] initWithFrame:CGRectMake(leftPadding, topPadding, textBgWidth, textBgHeight)];
    commentTextBg.image = [[UIImage imageNamed:@"content_comment_bg"] stretchableImageByCenter];
    commentTextBg.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [commentBanner addSubview:commentTextBg];
    
    CGFloat numberWidth = 30.0;
    numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(sendButton.frame) - 4 - numberWidth, topPadding, numberWidth, textBgHeight)];
    numberLabel.backgroundColor = [UIColor clearColor];
    numberLabel.font = [UIFont systemFontOfSize:14];
    numberLabel.adjustsFontSizeToFitWidth = YES;
    numberLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [commentBanner addSubview:numberLabel];
    numberLabel.hidden = YES;
    
    commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(leftPadding, topPadding, textBgWidth, textBgHeight)];
    commentTextView.frame = CGRectInset(commentTextView.frame, 10, 0);
    commentTextView.backgroundColor = [UIColor clearColor];
    commentTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    commentTextView.font = [UIFont systemFontOfSize:14];
    commentTextView.delegate = (id)self;
    //commentTextView.returnKeyType = UIReturnKeySend;
    [commentBanner addSubview:commentTextView];
    
    placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding + 15, topPadding + 1, textBgWidth - 20, textBgHeight)];
    placeholderLabel.backgroundColor = [UIColor clearColor];
    placeholderLabel.font = [UIFont systemFontOfSize:14];
    placeholderLabel.textColor = kDarkGrayColor;
    [commentBanner addSubview:placeholderLabel];
}

- (void)resetView
{
    commentTextView.text = nil;
    [self resizeBanner];
}

- (void)show
{
    if (self.superview == nil) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        self.frame = self.superview.bounds;
    }
    
    commentTextView.text = self.currentText;
    sendButton.enabled = self.currentText.length ? YES : NO;
    [self updateNumberLabel];
    [self resizeBanner];
    
    [commentTextView becomeFirstResponder];
}

- (void)hide
{
    [commentTextView resignFirstResponder];
}

- (void)showTextView:(NSNotification *)note
{
    NSDictionary *keyBoardInfo = [note userInfo];
    CGRect keyboardFrame = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat bottom = CGRectGetMinY(keyboardFrame);
    
    if (_keyboardShowing == NO) {
        UIViewAnimationCurve animationCurve = [keyBoardInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
        CGFloat duration = [keyBoardInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        [UIView animateWithDuration:duration delay:0.0 options:(animationCurve << 16) animations:^{
            [self setBannerBottom:bottom];
            maskButton.alpha = kCommentMaskAlpha;
        } completion:^(BOOL isFinished) {}];
        
        _keyboardShowing = YES;
        
        if ([self.delegate respondsToSelector:@selector(commentSendViewDidShow:position:)]) {
            [self.delegate commentSendViewDidShow:self position:commentBanner.frame.origin.y];
        }
    }
    else {
        [self setBannerBottom:bottom];
    }
}

- (void)hideTextView:(NSNotification *)note
{
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self setBannerTop:kScreenHeight];
        maskButton.alpha = 0;
    } completion:^(BOOL isFinished) {
        _keyboardShowing = NO;
        
        [commentTextView resignFirstResponder];
        [self removeFromSuperview];
    }];
}

- (void)resizeBanner
{
    int contentHeight = (int)[commentTextView contentSize].height;
    
    if (contentHeight < kCommentTextDefaultHeight) {
        contentHeight = kCommentTextDefaultHeight;
    }
    
    // 中文输入时删字母也会导致content height变化，估计是字母高度不同导致，故需判断height变化是单行高度的整数倍
    BOOL contentChange = (lastContentHeight != contentHeight && abs(contentHeight - lastContentHeight) % kCommentTextSingleHeight == 0);
    if (lastContentHeight == 0 || contentChange) {
        CGFloat textPadding = CGRectGetMinY(commentTextView.frame);
        CGFloat totalHeight = contentHeight + textPadding * 2;
        
        CGRect bannerFrame = commentBanner.frame;
        bannerFrame.origin.y = CGRectGetMaxY(bannerFrame) - totalHeight;
        bannerFrame.size.height = totalHeight;
        commentBanner.frame = bannerFrame;
        
        lastContentHeight = contentHeight;
    }
}

- (void)updateNumberLabel
{
    numberLabel.text = [NSString stringWithFormat:@"%@", @(kNumberMaxLength - (int)self.currentText.length)];
    
    if (self.currentText.length <= kNumberMaxLength) {
        numberLabel.textColor = kBlackColor;
    }
    else {
        numberLabel.textColor = kAppStyleColor;
    }
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    placeholderLabel.text = placeholder;
    placeholderLabel.hidden = NO;
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    // 不处理换行？
//    if ([text isEqualToString:@"\n"]) {
//        [self sendButtonPress];
//        
//        return NO;
//    }
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (commentBanner.frame.origin.y < kScreenHeight) {
        [self hideTextView:nil];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    sendButton.enabled = (textView.text.length > 0);
    placeholderLabel.hidden = sendButton.enabled;
    
    self.currentText = textView.text;
    
    [self updateNumberLabel];
    
    [self resizeBanner];
}

#pragma mark Keyboard Notification

- (void)keyboardWillShow:(NSNotification *)note
{
    // 避免其他输入通知的干扰
    if(commentTextView.isFirstResponder) {
        [self showTextView:note];
    }
}

- (void)keyboardWillHide:(NSNotification *)note
{
    
}

- (void)keyboardDidHide:(NSNotification *)note
{
    
}

- (void)setBannerTop:(CGFloat)top
{
    CGRect frame = commentBanner.frame;
    frame.origin.y = top;
    commentBanner.frame = frame;
}

- (void)setBannerBottom:(CGFloat)bottom
{
    CGRect frame = commentBanner.frame;
    frame.origin.y = bottom - CGRectGetHeight(frame);
    commentBanner.frame = frame;
}

- (void)sendButtonPress
{
    if (self.sendAction) {
        self.sendAction(self.currentText);
    }
}

- (void)backgroundPress
{
    if (self.cancelAction) {
        self.cancelAction();
    }
    
    [self hide];
}

@end

