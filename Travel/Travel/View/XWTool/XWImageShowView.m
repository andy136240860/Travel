//
//  XWImageShowView.m
//  Travel
//
//  Created by 晓炜 郭 on 16/7/18.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWImageShowView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

static const CGFloat imageViewInterval = 2;

@interface XWImageShowView(){

}

@end

@implementation XWImageShowView

- (instancetype)init{
    self = [super init];
    if (self) {

    }
    return self;
}

-(void)setImageURLArray:(NSArray *)imageURLArray{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _imageURLArray = imageURLArray;
    if (_imageURLArray.count) {
        for (int i = 0 ; i < _imageURLArray.count ; i++){
            UIImageView *iv = [UIImageView new];
            iv.contentMode = 2;
            iv.clipsToBounds = YES;
            if ([imageURLArray[i] isKindOfClass:[UIImage class]]) {
                iv.image = imageURLArray[i];
            }else if ([_imageURLArray[i] isKindOfClass:[NSString class]]){
                [iv sd_setImageWithURL:[NSURL URLWithString:_imageURLArray[i]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            }else if ([imageURLArray[i] isKindOfClass:[NSURL class]]){
                [iv sd_setImageWithURL:_imageURLArray[i] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            }
            iv.userInteractionEnabled = YES;
            iv.tag = i;
            [self addSubview:iv];
            
            CGFloat  Direction_X = ([self imageWidthandHeight:_imageURLArray.count] + imageViewInterval)*(i%3);
            CGFloat  Direction_Y  = (floorf(i/3.0)*([self imageWidthandHeight:_imageURLArray.count]+imageViewInterval));
            
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.mas_left).offset(Direction_X);
                make.top.mas_equalTo(self.mas_top).offset(Direction_Y);
                make.size.mas_equalTo(CGSizeMake([self imageWidthandHeight:_imageURLArray.count], [self imageWidthandHeight:_imageURLArray.count]));
            }];
        }
    }
}

- (CGFloat)imageWidthandHeight:(NSInteger)num{
    num = num > 3 ? 3:num;
    if (num > 0 && num <= 3) {
        return (kScreenWidth - (num-1)*imageViewInterval)/num;
    }
    else{
        return 0;
    }
}

+ (CGFloat)XWImageShowViewHeightWithImageNumber:(NSInteger)num{
    if (num > 0 && num <= 3) {
        return (kScreenWidth - (num-1)*imageViewInterval)/num;
    }
    if (num > 3 && num <= 6) {
        return (kScreenWidth - 2*imageViewInterval)/3*2 + imageViewInterval;
    }
    if (num > 6) {
        return (kScreenWidth - 2*imageViewInterval)/3*2 + imageViewInterval*2;
    }
    else{
        return 0;
    }
}

+ (CGFloat)XWImageShowViewWidth{
    return kScreenWidth;
}

@end
