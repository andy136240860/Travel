//
//  XWCommentManager.m
//  Travel
//
//  Created by 晓炜 郭 on 2016/11/25.
//  Copyright © 2016年 li na. All rights reserved.
//

#import "XWCommentManager.h"
#import "AVQuery.h"
#import "XWBaseListModel.h"

@implementation XWCommentManager

// 发表评论或者回复
+ (void)sendCommentWithObject:(AVObject *)object toComment:(XWComment *)comment content:(NSString *)contentText block:(XWServerAPIBlock)block {
    XWUser *user = [XWUser currentUser];
    [user isAuthenticatedWithSessionToken:user.sessionToken callback:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            if (comment == nil) {
                XWComment *newComment = [XWComment objectWithClassName:NSStringFromClass([XWComment class])];
                newComment.user = user;
                newComment.context = contentText;
                newComment.superData = object;
                newComment.baseComment = YES;
                [newComment saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    newComment.infoId = newComment.objectId;
                    [newComment saveInBackground];
                    SNServerAPIResultData *resultData = [[SNServerAPIResultData alloc]init];
                    resultData.hasError = !succeeded;
                    resultData.error = error;
                    if (succeeded) {
                        resultData.parsedModelObject = newComment;
                    }
                    block(nil, resultData);
                }];
            }
            else {
                XWComment *newComment = [XWComment objectWithClassName:NSStringFromClass([XWComment class])];
                newComment.user = user;
                newComment.toComment = comment;
                newComment.toUser = comment.user;
                newComment.context = contentText;
                newComment.superData = object;
                newComment.infoId = comment.infoId;
                newComment.baseComment = NO;
                [newComment saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    if (succeeded) {
                        XWComment *baseComment = [XWComment objectWithClassName:NSStringFromClass([XWComment class]) objectId:comment.infoId];
                        NSArray *array = @[newComment];
                        [AVObject saveAllInBackground:array block:^(BOOL succeeded, NSError * _Nullable error) {
                            if (succeeded) {
                                [baseComment addObjectsFromArray:array forKey:commendUserArr];
                                [baseComment saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                                    SNServerAPIResultData *resultData = [[SNServerAPIResultData alloc]init];
                                    resultData.hasError = !succeeded;
                                    resultData.error = error;
                                    if (succeeded) {
                                        resultData.parsedModelObject = newComment;
                                    }
                                    block(nil, resultData);
                                }];
                            }
                            else {
                                SNServerAPIResultData *resultData = [[SNServerAPIResultData alloc]init];
                                resultData.hasError = !succeeded;
                                resultData.error = error;
                                if (succeeded) {
                                    resultData.parsedModelObject = newComment;
                                }
                                block(nil, resultData);
                            }
                            
                        }];
                    }
                    else {
                        SNServerAPIResultData *resultData = [[SNServerAPIResultData alloc]init];
                        resultData.hasError = YES;
                        resultData.error = error;
                        block(nil, resultData);
                    }
                }];
            }
        }
        else {
            SNServerAPIResultData *resultData = [[SNServerAPIResultData alloc]init];
            resultData.hasError = YES;
            resultData.error = error;
            block(nil, resultData);
        }
    }];
}

// 获取评论列表
+ (void)getCommentListWithObject:(AVObject *)object page:(NSInteger)page pageSize:(NSInteger)pageSize block:(XWServerAPIBlock)block pageName:(NSString *)pageName {
    AVQuery *commentQuery = [AVQuery queryWithClassName:NSStringFromClass([XWComment class])];
    [commentQuery orderByDescending:@"createdAt"];
    commentQuery.limit = pageSize;
    commentQuery.skip = page*pageSize;
    [commentQuery whereKey:@"baseComment" equalTo:@(YES)];
    [commentQuery includeKey:@"relayArr"];// 关键代码，用 includeKey 告知云端需要返回的关联属性对应的对象的详细信息，而不仅仅是 objectId
    [commentQuery findObjectsInBackgroundWithBlock:^(NSArray *comments, NSError *error) {
        SNServerAPIResultData *resultData = [[SNServerAPIResultData alloc]init];
        resultData.hasError = error;
        resultData.error = error;
        if (!error) {
            XWBaseListModel *listModel = [[XWBaseListModel alloc]init];
            listModel.items = [NSMutableArray arrayWithArray:comments];
            resultData.parsedModelObject = listModel;
            block(nil, resultData);
        }
        block(nil, resultData);
        
    }];
}

@end
