//
//  SortsLevelCell.m
//  吾家超市
//
//  Created by iMac15 on 2017/1/13.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "SortsLevelCell.h"

@interface SortsLevelCell()
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *centerBtn;
@property (strong, nonatomic) UIButton *rightBtn;
@property (strong, nonatomic) NSMutableArray *tagArray;
@property (strong, nonatomic) NSString *tagStrId;
@property (strong, nonatomic) NSString *tagSStrId;
@property (strong, nonatomic) NSString *tagStr;

@property (strong, nonatomic) UIView *topLin;
@property (strong, nonatomic) UIView *centerLin;
@property (strong, nonatomic) UIImageView *leftImage;
@end

@implementation SortsLevelCell

+ (instancetype)sortsLevelCellWithTableView:(UITableView *)tableView
{
    NSString *indentifier = @"SortsLevelCell";
    SortsLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[SortsLevelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        self.topLin = [UIView new];
        self.topLin.backgroundColor = kColor(245.0f, 246.0f, 247.0f);
        [self addSubview:self.topLin];
        
        self.leftImage = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:[UIColor redColor]]];
        [self addSubview:self.leftImage];
        
        self.name = [[UILabel alloc] init];
        self.name.font = [UIFont boldSystemFontOfSize:16];
        self.name.textColor = [UIColor blackColor];
        self.name.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.name];
        
        self.centerLin = [UIView line];
        [self addSubview:self.centerLin];
        
        self.tagsView = [[HXTagsView alloc] init];
        self.tagsView.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        [self addSubview:self.tagsView];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.topLin.frame = CGRectMake(0, 0, kScreenW, 10);
    self.leftImage.frame = CGRectMake(0, CGRectGetMaxY(self.topLin.frame) + 5, 5, 25);
    self.name.frame = CGRectMake(CGRectGetMaxX(self.leftImage.frame) + 10, CGRectGetMaxY(self.topLin.frame) + 5, kScreenW - 25, 25);
    self.centerLin.frame = CGRectMake(0, CGRectGetMaxY(self.leftImage.frame) + 5, kScreenW, kSplitLineHeight);
    
    CGFloat height = [HXTagsView getHeightWithTags:self.tagsView.tags layout:self.tagsView.layout tagAttribute:self.tagsView.tagAttribute width:kScreenW];
    self.tagsView.frame = CGRectMake(0, CGRectGetMaxY(self.centerLin.frame), kScreenW, height);    
}

- (NSMutableArray *)tagArray
{
    if (!_tagArray) {
        _tagArray = [NSMutableArray array];
    }
    return _tagArray;
}

- (void)setFrameModel:(SortsLevelFrame *)frameModel
{
    _frameModel = frameModel;
    
    self.tagSStrId = frameModel.dataModel.id;
    self.name.text = frameModel.dataModel.name;

    kWeakSelf
    
    if (self.tagsView.tags == nil) {
        
        [self.tagArray removeAllObjects];
        
        for (int i = 0; i<frameModel.dataModel.children.count; i++)
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObject: [frameModel.dataModel.children objectAtIndex:i]];
            
            for (SortsLevelData *dataTag in array)
            {
                if ([dataTag.isPullOff isEqualToString:@"0"]) {
                    [self.tagArray addObject:dataTag.name];
                }
            }
        }
        
        self.tagsView.tags = self.tagArray;
    }
    
    self.tagsView.completion = ^(NSArray *selectTags,NSInteger currentIndex)
    {
        WJLog(@"%@",selectTags);
        
        weakSelf.tagStr = [selectTags objectAtIndex:0];
        
        for (int i = 0; i<frameModel.dataModel.children.count; i++)
        {
            NSMutableArray *array2 = [NSMutableArray array];
            [array2 addObject: [frameModel.dataModel.children objectAtIndex:i]];
            
            for (SortsLevelData *dataTag in array2) {
                
                if ([weakSelf.tagStr isEqualToString:dataTag.name]) {
                    weakSelf.tagStrId = dataTag.id;
                }
            }
        }
        
        if (weakSelf.leftSBtnClick) {
            weakSelf.leftSBtnClick(weakSelf.tagStrId, weakSelf.tagSStrId, weakSelf.tagStr);
        }
    };
}

@end
