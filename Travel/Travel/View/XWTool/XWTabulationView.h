//
//  XWTabulationView.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/3.
//  Copyright © 2016年 li na. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XWTabulationView;

@protocol XWTabulationViewDataSource <NSObject>

@required

- (NSInteger)numberOfRowsInTabulationView:(XWTabulationView *)tabulationView;
- (NSInteger)numberOfColumnInTabulationView:(XWTabulationView *)tabulationView;
- (CGFloat)widthProportionForColumnInTabulationView:(XWTabulationView *)tabulationView column:(NSInteger)column;
- (NSString *)TabulationView:(XWTabulationView *)tabulationView stringForRow:(NSInteger)row column:(NSInteger)column;

@optional

- (NSDictionary *)TabulationView:(XWTabulationView *)tabulationView AttributesInRow:(NSInteger)row column:(NSInteger)column;

@end

@interface XWTabulationView : UIView

@property (nonatomic, assign) CGFloat preferredTabulationWidth;
@property (nonatomic, assign) CGFloat minimumRowHeight;
@property (nonatomic, assign) CGFloat intervalRowHeight;

@property (nonatomic, weak) id <XWTabulationViewDataSource> dataSource;

- (instancetype)init;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END

