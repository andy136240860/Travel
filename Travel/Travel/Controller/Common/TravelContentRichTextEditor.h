//
//  TravelContentRichTextEditor.h
//  Travel
//
//  Created by 晓炜 郭 on 2016/10/20.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "ZSSRichTextEditor.h"
#import "UIViewController+SNExtension.h"

@protocol TravelContentRichTextEditorDelegate <NSObject>

- (void)saveContentString:(NSString *)contentString;

@end

@interface TravelContentRichTextEditor : ZSSRichTextEditor

@property (nonatomic, weak) id <TravelContentRichTextEditorDelegate> delegate;

@property (nonatomic, strong) NSString *contentString;

@end
