//
//  TravelTiTleAndDetailView.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/1.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "TravelTiTleAndDetailView.h"
#import "Masonry.h"
#import "XWTabulationView.h"
@interface TravelTiTleAndDetailView() <XWTabulationViewDataSource>{
    UILabel *_titleLabel;
    UILabel *_timeLabel;
    UILabel *_priceLabel;
    XWTabulationView *_tabulationView;
}

@end

@implementation TravelTiTleAndDetailView

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
}

- (void)initSubView {
//    _topLine = [[UIView alloc]init];
//    _topLine.backgroundColor = UIColorFromHex(0xe5e5e5);
//    [self addSubview:_topLine];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:17];
    _titleLabel.textColor = kGreenColor;
    _titleLabel.numberOfLines = 0;
    _titleLabel.preferredMaxLayoutWidth = kScreenWidth - 2*kPaddingLeft;
    [self addSubview:_titleLabel];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.font = [UIFont systemFontOfSize:11];
    _timeLabel.textColor = UIColorFromHex(0x999999);
    _timeLabel.numberOfLines = 1;
    _timeLabel.preferredMaxLayoutWidth = (kScreenWidth - 2*kPaddingLeft)/2.f;
    [self addSubview:_timeLabel];
    
    _priceLabel = [[UILabel alloc]init];
    _priceLabel.textColor = kGreenColor;
    _priceLabel.numberOfLines = 1;
    _priceLabel.preferredMaxLayoutWidth = (kScreenWidth - 2*kPaddingLeft)/2.f;
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_priceLabel];
    
    _tabulationView = [[XWTabulationView alloc]init];
    _tabulationView.dataSource = self;
    _tabulationView.preferredTabulationWidth = kScreenWidth - 2*kPaddingLeft;
    _tabulationView.intervalRowHeight = 7;
    [self addSubview:_tabulationView];
    
//    _bottomLine = [[UIView alloc]init];
//    _bottomLine.backgroundColor = UIColorFromHex(0xe5e5e5);
//    [self addSubview:_bottomLine];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = _title;
}

- (void)setTime:(NSString *)time {
    _time = time;
    _timeLabel.text = _time;
}

- (void)setPrice:(NSString *)price {
    _price = price;
    NSDictionary *attributesNum = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:UIColorFromHex(0xff3300)};
    NSDictionary *attributesUnit = @{NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:UIColorFromHex(0x999999)};
    
    _priceLabel.attributedText = [self attributedText:@[_price, @" 元"] attributeAttay:@[attributesNum,attributesUnit]];
}

- (NSAttributedString *)attributedText:(NSArray*)stringArray attributeAttay:(NSArray *)attributeAttay{
    NSString * string = [stringArray componentsJoinedByString:@""];
    NSMutableAttributedString * result = [[NSMutableAttributedString alloc] initWithString:string];
    for(NSInteger i = 0; i < stringArray.count; i++){
        [result setAttributes:attributeAttay[i] range:[string rangeOfString:stringArray[i]]];
    }
    // 返回已经设置好了的带有样式的文字
    return [[NSAttributedString alloc] initWithAttributedString:result];
}

- (void)initAutoLayout {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.mas_offset(kPaddingTop*2);
        make.left.mas_equalTo(self.mas_left).with.mas_offset(kPaddingLeft);
        make.right.mas_equalTo(self.mas_right).with.mas_offset(-kPaddingLeft);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).with.mas_offset(kPaddingTop);
        make.left.mas_equalTo(self.mas_left).with.mas_offset(kPaddingLeft);
        make.width.mas_equalTo(_priceLabel);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_timeLabel.mas_bottom);
        make.left.mas_equalTo(_timeLabel.mas_right);
        make.right.mas_equalTo(self.mas_right).with.mas_offset(-kPaddingLeft);
        make.width.mas_equalTo(_timeLabel);
    }];
    [_tabulationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.mas_offset(kPaddingLeft);
        make.right.mas_equalTo(self.mas_right).with.mas_offset(-kPaddingLeft);
        make.top.mas_equalTo(_timeLabel.mas_bottom).with.mas_offset(kPaddingTop + 2);
        make.bottom.mas_equalTo(self.mas_bottom).with.mas_offset(-kPaddingTop*2);
    }];
}

#pragma mark XWTabulationViewDataSource

- (NSInteger)numberOfRowsInTabulationView:(XWTabulationView *)tabulationView {
    return 7;
}

- (NSInteger)numberOfColumnInTabulationView:(XWTabulationView *)tabulationView {
    return 3;
}

- (CGFloat)widthProportionForColumnInTabulationView:(XWTabulationView *)tabulationView column:(NSInteger)column{
    switch (column) {
        case 0:
            return 0.3;
            break;
        case 1:
            return 0.6;
            break;
        case 2:
            return 0.1;
            break;
        default:
            break;
    }
    return 0;
}

- (NSString *)TabulationView:(XWTabulationView *)tabulationView stringForRow:(NSInteger)row column:(NSInteger)column {
    NSArray *column1 = @[@"目的地:",@"成都",@""];
    NSArray *column2 = @[@"时间:",@"7月12日 - 7月21日",@""];
    NSArray *column3 = @[@"时长:",@"10天",@"大约"];
    NSArray *column4 = @[@"人数:",@"已有2人，预计6人",@"大约"];
    NSArray *column5 = @[@"旅行费用预算:",@"2000元",@""];
    NSArray *column6 = @[@"交通状况:",@"有车",@""];
    NSArray *column7 = @[@"语言:",@"中文",@""];
    NSArray *arr = @[column1,column2,column3,column4,column5,column6,column7];
    return arr[row][column];
}

- (NSDictionary *)TabulationView:(XWTabulationView *)tabulationView AttributesInRow:(NSInteger)row column:(NSInteger)column {
    switch (column) {
        case 0:
            return @{NSForegroundColorAttributeName:UIColorFromHex(0x707070),NSFontAttributeName:[UIFont systemFontOfSize:11]};
            break;
        case 1:
            return @{NSForegroundColorAttributeName:UIColorFromHex(0x333333),NSFontAttributeName:[UIFont systemFontOfSize:11]};
            break;
        case 2:
            return @{NSForegroundColorAttributeName:UIColorFromHex(0x999999),NSFontAttributeName:[UIFont systemFontOfSize:11]};
            break;
        default:
            return nil;
            break;
    }
}

@end
