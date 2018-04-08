//
//  CreateNewAddressVC.m
//  吾家网
//
//  Created by iMac15 on 2017/6/17.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#import "CreateNewAddressVC.h"

@interface CreateNewAddressVC ()<UITextFieldDelegate>
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) WJInputTextField *usrname;
@property (strong, nonatomic) WJInputTextField *phone;
@property (strong, nonatomic) WJInputTextField *contory;
@property (strong, nonatomic) WJInputTextField *address;
@property (strong, nonatomic) WJInputTextField *zipCode;
@property (strong, nonatomic) UIView *bootomView;
@property (strong, nonatomic) UIButton *selectBtn;

@property (nonatomic, strong) LHCustomModalTransition *transition;
@property (strong, nonatomic) NSMutableArray *addressList;

@property (strong, nonatomic) NSString *proCode;
@property (strong, nonatomic) NSString *cityCode;
@property (strong, nonatomic) NSString *areaCode;
@property (strong, nonatomic) NSString *isDefaultStr;
@property (strong, nonatomic) NSString *urlStr;
@property (strong, nonatomic) NSString *reciveid;
@end


@implementation CreateNewAddressVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self editAddress];
}

#pragma mark -设为默认
- (void)selectBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
}

#pragma mark -编辑地址-加载地址信息
- (void)editAddress
{
    [self.view endEditing:YES];

    if (!kObjectIsEmpty(self.editAddressModel)) {
        self.usrname.text = self.editAddressModel.consignee;
        self.phone.text = self.editAddressModel.phone;
        self.contory.text = self.editAddressModel.areaName;
        self.address.text = self.editAddressModel.address;
        self.zipCode.text = self.editAddressModel.zipCode;
        self.areaCode = self.editAddressModel.areaId;
        self.reciveid = self.editAddressModel.id;
        self.urlStr = kUpdateAdrressUrl;
        
        if (self.editAddressModel.isDefault) {
            self.selectBtn.selected = YES;
        }
        else{
            self.selectBtn.selected = NO;
        }
    }
    else{
        self.urlStr = kGreatAddressUrl;
        self.reciveid = @"";
    }
}

#pragma mark -新建地址  //true是 false否
- (void)doneClick
{
    kWeakSelf
    [self.view endEditing:YES];
    
    if (kStringIsEmpty(self.areaCode)) {
        self.areaCode = self.cityCode;
    }
    
    if (kStringIsEmpty(self.usrname.text)) {
        [MBProgressHUD showTextMessage:@"姓名不能为空"];
        return;
    }
    else if (kStringIsEmpty(self.phone.text)){
        [MBProgressHUD showTextMessage:@"手机号不能为空"];
        return;
    }
    else if (kStringIsEmpty(self.areaCode)){
        [MBProgressHUD showTextMessage:@"所在区域不能为空"];
        return;
    }
    else if (kStringIsEmpty(self.address.text)){
        [MBProgressHUD showTextMessage:@"详细地址不能为空"];
        return;
    }
    else if (kStringIsEmpty(self.zipCode.text)){
        [MBProgressHUD showTextMessage:@"邮编不能为空"];
        return;
    }
    else if (self.zipCode.text.length < 6){
        [MBProgressHUD showTextMessage:@"邮编不能小余6位"];
        return;
    }
    
    
    if (self.selectBtn.selected) {
        self.isDefaultStr = @"true";    //1
    }
    else{
        self.isDefaultStr = @"false";   //0
    }
    
    NSDictionary *param = @{
                            @"consignee":self.usrname.text,
                            @"phone":self.phone.text,
                            @"address":self.address.text,
                            @"areaId":self.areaCode,
                            @"isDefault":self.isDefaultStr,
                            @"zipCode":self.zipCode.text,
                            @"id":self.reciveid,
                            @"areaName":self.contory.text
                            };
    
    [WJRequestTool post:self.urlStr param:param resultClass:[CreateAddressResult class] successBlock:^(CreateAddressResult *result)
     {
         if ([weakSelf.createAddressType isEqualToString:@"1"]) {
             
             NSArray *vcArray = self.navigationController.viewControllers;
             
             for(UIViewController *vc in vcArray)
             {
                 if ([vc isKindOfClass:[CreateOrederVC class]])
                 {
                     if (weakSelf.creatAddress) {
                         weakSelf.creatAddress(result.t);
                     }
                     
                     [weakSelf.navigationController popToViewController:vc animated:YES];
                 }
             }
         }
         else{
             [weakSelf.navigationController popViewControllerAnimated:YES];
         }
         
     } failure:^(NSError *error) {
         
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加收货地址";
    self.view.backgroundColor = kGlobalBackgroundColor;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
    
    self.backView = [[UIView alloc] init];
    self.backView.frame = CGRectMake(0, 10, kScreenW, 200);
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.backView addTopSplitLine];
    [self.backView addBottomSplitLine];
    [self.view addSubview:self.backView];
    
    self.usrname = [WJInputTextField inputTextFieldWithTitle:@"收  货  人: " andPlaceholderText:@"请输入收货人姓名" delegate:self];
    self.usrname.frame = CGRectMake(10, 0, kScreenW - 20, 40);
    self.usrname.delegate = self;
    [self.backView addSubview:self.usrname];
    
    [self.backView addSplitLineWithFrame:CGRectMake(0, CGRectGetMaxY(self.usrname.frame), kScreenW, kSplitLineHeight)];
    
    self.phone = [WJInputTextField inputTextFieldWithTitle:@"手机号码: " andPlaceholderText:@"请输入手机号码" delegate:self];
    self.phone.frame = CGRectMake(10, CGRectGetMaxY(self.usrname.frame), kScreenW - 20, 40);
    self.phone.delegate = self;
    self.phone.keyboardType = UIKeyboardTypeNumberPad;
    [self.backView addSubview:self.phone];
    
    [self.backView addSplitLineWithFrame:CGRectMake(0, CGRectGetMaxY(self.phone.frame), kScreenW, kSplitLineHeight)];
    
    self.contory = [WJInputTextField inputTextFieldWithTitle:@"所在地区: " andPlaceholderText:@"请选择所在地区" delegate:self];
    self.contory.frame = CGRectMake(10, CGRectGetMaxY(self.phone.frame), kScreenW - 20, 40);
    self.contory.delegate = self;
    [self.backView addSubview:self.contory];
    
    UIButton *touchBtn = [self.contory addButtonWithTitle:@"" target:self action:@selector(showComboxPickView)];
    touchBtn.frame = CGRectMake(10, CGRectGetMaxY(self.phone.frame), kScreenW - 20, 40);
    [self.backView addSubview:touchBtn];
    
    [self.backView addSplitLineWithFrame:CGRectMake(0, CGRectGetMaxY(self.contory.frame), kScreenW, kSplitLineHeight)];
    
    self.address = [WJInputTextField inputTextFieldWithTitle:@"详细地址: " andPlaceholderText:@"请输入详细地址" delegate:self];
    self.address.frame = CGRectMake(10, CGRectGetMaxY(self.contory.frame), kScreenW - 20, 40);
    self.address.delegate = self;
    [self.backView addSubview:self.address];
    
    [self.backView addSplitLineWithFrame:CGRectMake(0, CGRectGetMaxY(self.address.frame), kScreenW, kSplitLineHeight)];
    
    self.zipCode = [WJInputTextField inputTextFieldWithTitle:@"邮政编码: " andPlaceholderText:@"请输入邮编" delegate:self];
    self.zipCode.frame = CGRectMake(10, CGRectGetMaxY(self.address.frame), kScreenW - 20, 40);
    self.zipCode.delegate = self;
    [self.backView addSubview:self.zipCode];
    
    self.bootomView = [[UIView alloc] init];
    self.bootomView.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame) + 10, kScreenW, 40);
    self.bootomView.backgroundColor = [UIColor whiteColor];
    [self.bootomView addTopSplitLine];
    [self.bootomView addBottomSplitLine];
    [self.view addSubview:self.bootomView];
    
    UILabel *lab = [self.bootomView addLabelWithText:@"设为默认地址"];
    lab.frame = CGRectMake(10, 0, 100, 40);
    
    self.selectBtn = [self.bootomView addButtonSelectedSetImage:@"agree" selected:@"agreeS" target:self action:@selector(selectBtnClick:)];
    self.selectBtn.frame = CGRectMake(kScreenW - 30, 10, 20, 20);
}

- (NSMutableArray *)addressList
{
    if (!_addressList) {
        _addressList = [NSMutableArray array];
    }
    return _addressList;
}

- (void)showComboxPickView
{
    [self popAddressView];
}

- (void)popAddressView
{
    [self.view endEditing:YES];

    ChooseAddressVC *modalVC = [ChooseAddressVC new];
    
    //---必须强引用，否则会被释放，自定义dismiss的转场无效
    self.transition = [[LHCustomModalTransition alloc]initWithModalViewController:modalVC];
    
    self.transition.dragable = NO;//---是否可下拉收起
    self.transition.transitionStyle = LHCustomScaleTransitionStyle;
    
    modalVC.transitioningDelegate = self.transition;
    //---必须添加这句.自定义转场动画
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:modalVC animated:YES completion:nil];
    
    kWeakSelf
    
    modalVC.chooseEditAdd = ^(NSString *address, NSString *code)
    {
        weakSelf.contory.text = [NSString stringWithFormat:@"%@",address];
        weakSelf.areaCode = code;
        [weakSelf.view endEditing:YES];
    };
}


@end

