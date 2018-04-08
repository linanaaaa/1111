//
//  SortsModel.h
//  吾家超市
//
//  Created by iMac15 on 2016/12/5.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SortsModel : NSObject
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *order;
@property (copy,   nonatomic) NSString *name;
@property (copy,   nonatomic) NSString *treePath;
@property (copy,   nonatomic) NSString *grade;

@property (strong, nonatomic) NSArray *children;
@end


@interface SortsChildren : NSObject
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *order;
@property (copy,   nonatomic) NSString *name;
@property (copy,   nonatomic) NSString *treePath;
@property (copy,   nonatomic) NSString *grade;

@property (strong, nonatomic) NSArray *children;
@end


@interface SortsData : NSObject
@property (copy,   nonatomic) NSString *id;
@property (copy,   nonatomic) NSString *createDate;
@property (copy,   nonatomic) NSString *modifyDate;
@property (copy,   nonatomic) NSString *order;
@property (copy,   nonatomic) NSString *name;
@property (copy,   nonatomic) NSString *treePath;
@property (copy,   nonatomic) NSString *grade;

@property (strong, nonatomic) NSArray *children;

@end

@interface SortsModelResult : WJBaseRequestResult
@property (strong, nonatomic) NSArray *t;
@end

//搜索结果
@interface SearchListTypeParam : NSObject
@property (copy,   nonatomic) NSString *keyword;
@property (copy,   nonatomic) NSString *orderType;
@property (copy,   nonatomic) NSString *pageNumber;
@property (copy,   nonatomic) NSString *pageSize;
@end

