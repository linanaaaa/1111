//
//  AddressListCellFrameModel.h
//  吾家超市
//
//  Created by iMac15 on 2016/11/16.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressModel.h"

@interface AddressListCellFrameModel : NSObject

@property (strong, nonatomic) AddressModel *dataModel;

+ (NSArray *)frameModelArrayWithDataArray:(NSArray *)dataArray;


@property (assign, nonatomic) CGRect nameFrame;
@property (assign, nonatomic) CGRect phoneFrame;
@property (assign, nonatomic) CGRect addressFrame;
@property (assign, nonatomic) CGRect centerLineFrame;
@property (assign, nonatomic) CGRect isDefaultBtnFrame;
@property (assign, nonatomic) CGRect editBtnFrame;
@property (assign, nonatomic) CGRect delegetBtnFrame;

@property (assign, nonatomic) CGFloat height;
@end
