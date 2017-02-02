//
//  XWGeoTool.h
//  Travel
//
//  Created by 晓炜 郭 on 2017/1/1.
//  Copyright © 2017年 li na. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GeoCountryRegion;
@class GeoState;
@class GeoCity;

@interface GeoCountryRegion : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSString *code;
@property (nonatomic, strong) NSMutableArray<GeoState *> *stateArr;

- (instancetype)init;

@end

@interface GeoState : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSString *code;
@property (nonatomic, strong) NSMutableArray<GeoCity *> *cityArr;

- (instancetype)init;

@end

@interface GeoCity : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSString *code;

@end

@protocol XWGeoToolDelegate <NSObject>

@optional

- (void)parserDidEndGeoList:(NSArray *)list;

@end

@interface XWGeoTool : NSObject

SINGLETON_DECLARE(XWGeoTool);

@property (nonatomic, strong) NSMutableArray<GeoCountryRegion *> *list;

@property (nonatomic, weak) id <XWGeoToolDelegate> delegate;

@end
