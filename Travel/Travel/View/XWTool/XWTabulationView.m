//
//  XWTabulationView.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/3.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWTabulationView.h"


@interface XWTabulationView() {
    NSInteger _numberOfRow;
    NSInteger _numberOfColumn;
}

@end

@implementation XWTabulationView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _preferredTabulationWidth = kScreenWidth;
        _intervalRowHeight = 7;
    }
    return self;
}

-(CGSize)intrinsicContentSize{
    if ([self.dataSource respondsToSelector:@selector(numberOfRowsInTabulationView:)]) {
        _numberOfRow = [self.dataSource numberOfRowsInTabulationView:self];
    }
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnInTabulationView:)]) {
        _numberOfColumn = [self.dataSource numberOfColumnInTabulationView:self];
    }
    CGFloat intrinsicContentSizeHeight = 0;
    for (int row = 0; row < _numberOfRow; row++) {
        CGFloat rowHeight = _minimumRowHeight;
        for (int column = 0; column < _numberOfColumn; column++) {
            CGFloat columnWidth = 0;
            NSDictionary *attributes = [NSDictionary dictionary];
            if ([self.dataSource respondsToSelector:@selector(TabulationView:AttributesInRow:column:)]) {
                attributes = [self.dataSource TabulationView:self AttributesInRow:row column:column];
            }
            if ([self.dataSource respondsToSelector:@selector(widthProportionForColumnInTabulationView:column:)]) {
                columnWidth = [self.dataSource widthProportionForColumnInTabulationView:self column:column] * _preferredTabulationWidth;
            }
            NSString *str = @"";
            if ([self.dataSource respondsToSelector:@selector(TabulationView:stringForRow:column:)]) {
                str = [self.dataSource TabulationView:self stringForRow:row column:column];
            }
            CGSize size = [str boundingRectWithSize:CGSizeMake(columnWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
            rowHeight = rowHeight > size.height ? rowHeight:size.height;
        }
        intrinsicContentSizeHeight += rowHeight + _intervalRowHeight;
    }//Calculate Height For each Row
    
    CGSize contentSize = CGSizeMake(_preferredTabulationWidth, intrinsicContentSizeHeight - _intervalRowHeight);
    return contentSize;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGFloat intrinsicContentSizeHeight = 0;
    for (int row = 0; row < _numberOfRow; row++) {
        CGFloat rowHeight = _minimumRowHeight;
        CGFloat columnX = 0;
        for (int column = 0; column < _numberOfColumn; column++) {
            CGFloat columnWidth = 0;
            NSDictionary *attributes = [NSDictionary dictionary];
            if ([self.dataSource respondsToSelector:@selector(TabulationView:AttributesInRow:column:)]) {
                attributes = [self.dataSource TabulationView:self AttributesInRow:row column:column];
            }
            if ([self.dataSource respondsToSelector:@selector(widthProportionForColumnInTabulationView:column:)]) {
                columnWidth = [self.dataSource widthProportionForColumnInTabulationView:self column:column] * _preferredTabulationWidth;
            }
            NSString *str = @"";
            if ([self.dataSource respondsToSelector:@selector(TabulationView:stringForRow:column:)]) {
                str = [self.dataSource TabulationView:self stringForRow:row column:column];
            }
            CGSize size = [str boundingRectWithSize:CGSizeMake(columnWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
            [str drawInRect:CGRectMake(columnX, intrinsicContentSizeHeight, columnWidth, size.height) withAttributes:attributes];
            
            rowHeight = rowHeight > size.height ? rowHeight:size.height;
            columnX += columnWidth;
        }
        intrinsicContentSizeHeight += rowHeight + _intervalRowHeight;
    }//Calculate Height For each Row
}

- (void)reloadData {
    [self invalidateIntrinsicContentSize];
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}
@end
