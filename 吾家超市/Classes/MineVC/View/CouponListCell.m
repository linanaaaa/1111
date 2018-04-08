//
//  CouponListCell.m
//  吾家超市
//
//  Created by iMac15 on 2017/1/23.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "CouponListCell.h"

@interface CouponListCell ()
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *introduction;
@property (strong, nonatomic) UILabel *data;
@property (strong, nonatomic) UILabel *minimumPrice;
@property (strong, nonatomic) UILabel *minimumQuantity;
@property (strong, nonatomic) UIView *bottomLine;
@property (strong, nonatomic) UILabel *userLabel;
@property (strong, nonatomic) UIImageView *picImage;
@end

@implementation CouponListCell

+ (instancetype)couponListCellWithTalbeView:(UITableView *)tableView
{
    NSString *indentifier = @"CouponListCell";
    CouponListCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[CouponListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSplitLineWithFrame:CGRectMake(0, 0, kScreenW, 10)];
        
        self.name = [self addLabelWithText:@""];
        self.name.textAlignment = NSTextAlignmentCenter;
        self.name.textColor = [UIColor redColor];
        self.name.font = [UIFont systemFontOfSize:30];
        
        self.bottomLine = [UIView line];
        [self addSubview:self.bottomLine];
        
        self.introduction = [self addLabelWithText:@""];
        self.introduction.textColor = [UIColor blackColor];
        
        self.minimumPrice = [self addLabelWithText:@""];
        self.minimumPrice.textColor = [UIColor blackColor];
        
        self.minimumQuantity = [self addLabelWithText:@""];
        self.minimumQuantity.textColor = [UIColor blackColor];
        
        self.data = [self addLabelWithText:@""];
        self.data.textColor = [UIColor blackColor];
        
        self.userLabel = [self addLabelWithText:@"优惠券所适用的商品 >"];
        self.userLabel.textColor = [UIColor grayColor];
        
        self.picImage = [[UIImageView alloc] init];
        self.picImage.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.picImage];
    }
    return self;
}

- (void)setFrameModel:(CouponCellFrame *)frameModel
{
    _frameModel = frameModel;
    self.name.frame = frameModel.nameF;
    self.picImage.frame = frameModel.picImageF;
    self.introduction.frame = frameModel.introductionF;
    self.minimumPrice.frame = frameModel.minimumPriceF;
    self.minimumQuantity.frame = frameModel.minimumQuantityF;
    self.userLabel.frame = frameModel.userLabelF;
    self.data.frame = frameModel.dataF;
    self.bottomLine.frame = frameModel.bottomLineF;
    
    self.name.text = frameModel.dataModel.name;
    self.introduction.text = frameModel.dataModel.introduction;
    self.minimumPrice.text = [NSString stringWithFormat:@"满%@元可用",frameModel.dataModel.minimumPrice];
    self.minimumQuantity.text = [NSString stringWithFormat:@"满%@件可用",frameModel.dataModel.minimumQuantity];
    self.data.text = [NSString stringWithFormat:@"%@-%@",[self timeWithTimeIntervalString:frameModel.dataModel.beginDate], [self timeWithTimeIntervalString:frameModel.dataModel.endDate]];;
    
    if ([frameModel.dataModel.isUsed isEqualToString:@"0"] && [frameModel.dataModel.hasExpired isEqualToString:@"0"]) {
        self.picImage.image = [UIImage imageNamed:@"weishiyong"];
    }
    else if ([frameModel.dataModel.isUsed isEqualToString:@"1"]){
        self.picImage.image = [UIImage imageNamed:@"yishiyong"];
    }
    else if ([frameModel.dataModel.isUsed isEqualToString:@"0"] && [frameModel.dataModel.hasExpired isEqualToString:@"1"]){
        self.picImage.image = [UIImage imageNamed:@"yiguoqi"];
    }
    
    //0 =  @"false";  1 = @"true";
}

- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
@end
