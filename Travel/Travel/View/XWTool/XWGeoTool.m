//
//  XWGeoTool.m
//  Travel
//
//  Created by 晓炜 郭 on 2017/1/1.
//  Copyright © 2017年 li na. All rights reserved.
//

#import "XWGeoTool.h"

@implementation GeoCountryRegion

- (instancetype)init {
    self = [super init];
    if(self) {
        self.stateArr = [NSMutableArray arrayWithCapacity:5];
    }
    return self;
}

@end

@implementation GeoState

- (instancetype)init {
    self = [super init];
    if(self) {
        self.cityArr = [NSMutableArray arrayWithCapacity:5];
    }
    return self;
}


@end

@implementation GeoCity

@end

@interface XWGeoTool()<NSXMLParserDelegate>

@property (nonatomic, strong) NSXMLParser *par;

@property (nonatomic, strong) NSMutableArray<GeoCountryRegion *> *list;

@property (nonatomic, copy) NSString *currentElement;

@end

@implementation XWGeoTool

- (instancetype)init{
    self = [super init];
    if (self) {
        //获取事先准备好的XML文件
        NSBundle *b = [NSBundle mainBundle];
        NSString *path = [b pathForResource:@"LocList" ofType:@".xml"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        self.par = [[NSXMLParser alloc]initWithData:data];
        //添加代理
        self.par.delegate = self;
        //初始化数组，存放解析后的数据
        self.list = [NSMutableArray arrayWithCapacity:5];
    }
    return self;
}


//几个代理方法的实现，是按逻辑上的顺序排列的，但实际调用过程中中间三个可能因为循环等问题乱掉顺序
//开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"parserDidStartDocument...");
}
//准备节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    
    self.currentElement = elementName;
    
    if ([elementName isEqualToString:@"CountryRegion"]){
        GeoCountryRegion *geoCountryRegion = [[GeoCountryRegion alloc]init];
        geoCountryRegion.name = [attributeDict objectForKey:@"Name"];
        geoCountryRegion.code = [[attributeDict objectForKey:@"Code"] integerValue];
        [self.list addObject:geoCountryRegion];
    }
    if ([elementName isEqualToString:@"State"]) {
        if (self.list.lastObject) {
            GeoState *state = [[GeoState alloc]init];
            state.name = [attributeDict objectForKey:@"Name"];
            state.code = [[attributeDict objectForKey:@"Code"] integerValue];
            [self.list.lastObject.stateArr addObject:state];
        }
    }
    if ([elementName isEqualToString:@"City"]) {
        if (self.list.lastObject) {
            if (self.list.lastObject.stateArr.lastObject) {
                GeoCity *city = [[GeoCity alloc]init];
                city.name = [attributeDict objectForKey:@"Name"];
                city.code = [[attributeDict objectForKey:@"Code"] integerValue];
                [self.list.lastObject.stateArr.lastObject.cityArr addObject:city];
            }
        }
    }
    
}

//解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"parserDidEndDocument...");
}

//外部调用接口
-(void)parse{
    [self.par parse];
    
}




@end
