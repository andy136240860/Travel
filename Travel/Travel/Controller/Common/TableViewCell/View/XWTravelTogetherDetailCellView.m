//
//  XWTravelTogetherDetailCellView.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/12/2.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWTravelTogetherDetailCellView.h"
#import "UIImageView+WebCache.h"
#import "AVGeoPoint+CLLocationHelper.h"

@interface XWTravelTogetherDetailCellView()

@property (nonatomic, strong) UIImageView *backgroudImageView;

@property (nonatomic, strong) UILabel       *destinationLabel;

@property (nonatomic, strong) UILabel       *label1; //时长
@property (nonatomic, strong) UILabel       *label2; //人数
@property (nonatomic, strong) UILabel       *label3; //语言
@property (nonatomic, strong) UILabel       *label4; //交通

@end

@implementation XWTravelTogetherDetailCellView

- (CGSize)intrinsicContentSize {
    return CGSizeMake(kScreenWidth, kScreenWidth * 9 / 16 + 50);
}

- (instancetype)init {
    self = [super init];
    if(self) {
        [self initSubView];
    }
    return self;
}

- (void)initSubView {
    CGFloat paddingLeft = 10;
    CGFloat paddingImageTop = 15;
    CGFloat paddingLabelTop = 18;
    CGFloat imageWidth = 20;
    CGFloat imageLabelIntervalX = 7;
    CGFloat labelWidth = (kScreenWidth - 5*paddingLeft - 4*imageWidth - 4*imageLabelIntervalX)/4.f;
    CGFloat labelHeight = 15;
    
    self.backgroudImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 9 / 16)];
    [self addSubview:self.backgroudImageView];
    
    UIImageView *destinationIconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(paddingLeft, self.backgroudImageView.frameHeight - 16 - paddingImageTop, 16, 16)];
    destinationIconImageView.layer.contents = (id)[UIImage imageNamed:@"location"].CGImage;
    [self.backgroudImageView addSubview:destinationIconImageView];
    
    _destinationLabel = [[UILabel alloc]initWithFrame:CGRectMake(destinationIconImageView.maxX + imageLabelIntervalX, self.backgroudImageView.frameHeight - paddingImageTop - 15 , kScreenWidth, 15)];
    _destinationLabel.font = [UIFont systemFontOfSize:12];
    [self.backgroudImageView addSubview:_destinationLabel]; 
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.backgroudImageView.maxY, kScreenWidth, 50)];
    view.backgroundColor = UIColorFromHex(0xf7f8f9);
    [self addSubview:view];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(paddingLeft, paddingImageTop, imageWidth,imageWidth)];
    imageView1.layer.contents = (id)[UIImage imageNamed:@"time"].CGImage;
    [view addSubview:imageView1];
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(imageView1.maxX + imageLabelIntervalX, paddingLabelTop, labelWidth, labelHeight)];
    _label1.font = [UIFont systemFontOfSize:12];
    _label1.textColor = UIColorFromHex(0x666666);
    [view addSubview:_label1];
    
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(paddingLeft + (imageWidth + imageLabelIntervalX + labelWidth + paddingLeft), paddingImageTop, imageWidth,imageWidth)];
    imageView2.layer.contents = (id)[UIImage imageNamed:@"member"].CGImage;
    [view addSubview:imageView2];
    
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(imageView2.maxX + imageLabelIntervalX, paddingLabelTop, labelWidth, labelHeight)];
    _label2.font = [UIFont systemFontOfSize:12];
    _label2.textColor = UIColorFromHex(0x666666);
    [view addSubview:_label2];
    
    UIImageView *imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(paddingLeft + (imageWidth + imageLabelIntervalX + labelWidth + paddingLeft)*2, paddingImageTop, imageWidth,imageWidth)];
    imageView3.layer.contents = (id)[UIImage imageNamed:@"translate"].CGImage;
    [view addSubview:imageView3];
    
    _label3 = [[UILabel alloc]initWithFrame:CGRectMake(imageView3.maxX + imageLabelIntervalX, paddingLabelTop, labelWidth, labelHeight)];
    _label3.font = [UIFont systemFontOfSize:12];
    _label3.textColor = UIColorFromHex(0x666666);
    [view addSubview:_label3];
    
    UIImageView *imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(paddingLeft + (imageWidth + imageLabelIntervalX + labelWidth + paddingLeft)*3, paddingImageTop, imageWidth,imageWidth)];
    imageView4.layer.contents = (id)[UIImage imageNamed:@"traffic"].CGImage;
    [view addSubview:imageView4];
    
    _label4 = [[UILabel alloc]initWithFrame:CGRectMake(imageView4.maxX + imageLabelIntervalX, paddingLabelTop, labelWidth, labelHeight)];
    _label4.font = [UIFont systemFontOfSize:12];
    _label4.textColor = UIColorFromHex(0x666666);
    [view addSubview:_label4];
}

- (void)setTravelTogether:(TravelTogether *)travelTogether {
    _travelTogether = travelTogether;
    [self.backgroudImageView sd_setImageWithURL:[NSURL URLWithString:_travelTogether.coverImageURL] placeholderImage:nil];
    
    _label1.text = [NSString stringWithFormat:@"%ld d",(_travelTogether.endTime - _travelTogether.startTime)/3600/24 + 1];
    _label2.text = [NSString stringWithFormat:@"%ld / %ld",_travelTogether.joinedPeopleNumber,_travelTogether.peopleNumber];
    _label3.text = _travelTogether.traffic ? @"Yes":@"No";
    _label4.text = _travelTogether.language ? @"Yes":@"No";

    __weak UILabel *weakDestinationLabel = self.destinationLabel;
    [_travelTogether.destination getCityNameWithBlock:^(NSString *cityName) {
        weakDestinationLabel.text = cityName;
    }];
}

@end
