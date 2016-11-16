//
//  TravelMatesView.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/3.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "TravelMatesView.h"

@interface TravelMatesView() {
    
}
@end;

@implementation TravelMatesView

- (CGSize)intrinsicContentSize {
    return CGSizeMake(kScreenWidth, [[self class] defaultHeight]);
}

- (instancetype)init {
    self = [self initWithFrame:CGRectMake(0, 0, kScreenWidth, [[self class] defaultHeight])];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
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
    
    NSString *str = [NSString stringWithFormat:@"同行人员  %ld",(long)_totalNumber];
    NSDictionary *attributes  = @{NSForegroundColorAttributeName:UIColorFromHex(0x136d57),NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGSize size = [str boundingRectWithSize:CGSizeMake(rect.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    [str drawInRect:CGRectMake(kPaddingLeft, kPaddingTop, size.width, size.height) withAttributes:attributes];
}

+ (CGFloat)defaultHeight {
    return 160;
}

- (void)initSubView {
    self.backgroundColor = [UIColor whiteColor];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ : %p>,frame = (%.2f,%.2f,%.2f,%.2f)",[self class],self,self.frameX,self.frameY,self.frameWidth,self.frameHeight];
}
@end
