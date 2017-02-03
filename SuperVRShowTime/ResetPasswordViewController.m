//
//  ResetPasswordViewController.m
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 2016/11/6.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "GCD/GCD.h"
#import "WebShowViewController.h"

#define MaxCodeTime  60

@interface ResetPasswordViewController ()<UITableViewDataSource,UITableViewDelegate>{
    int timerCount;
    GCDTimer *timer;
}

@property (weak, nonatomic) IBOutlet UITableView *myTableview;
@property (strong, nonatomic) IBOutlet UITableViewCell *phoneCell;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (strong, nonatomic) IBOutlet UITableViewCell *passCell;
@property (weak, nonatomic) IBOutlet UITextField *passField;
@property (strong, nonatomic) IBOutlet UITableViewCell *codeCell;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (strong, nonatomic) IBOutlet UIView *footView;
@property (weak, nonatomic) IBOutlet UIButton *postBtn;
@property (weak, nonatomic) IBOutlet UIButton *potocalBtn;

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (self.stly) {
        self.navigationItem.title = @"注册";
        [self.postBtn setTitle:@"注册" forState:UIControlStateNormal];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.potocalBtn.titleLabel.text];
        NSRange strRange = {0,[str length]};
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        [self.potocalBtn setAttributedTitle:str forState:UIControlStateNormal];
    }else{
        self.navigationItem.title = @"用手机重设密码";
        [self.postBtn setTitle:@"保存" forState:UIControlStateNormal];
        CGRect rect = self.footView.frame;
        rect.size.height = 60;
        self.footView.frame = rect;
    }
    
    [self.codeBtn.layer setBorderWidth:1];
    [self.codeBtn.layer setBorderColor:[UIColor colorWithRed:0 green:122.0/255.0 blue:1.0 alpha:1].CGColor];
    timerCount = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.phoneField resignFirstResponder];
    [self.passField resignFirstResponder];
    [self.codeField resignFirstResponder];
}

- (IBAction)passwordShowStly:(id)sender {
    if ([self.passField.text isEqualToString:@""]) {
        return;
    }
    if (self.passField.secureTextEntry) {
        [self.passField setSecureTextEntry:NO];
    }else{
        [self.passField setSecureTextEntry:YES];
    }
}

- (IBAction)getCode:(id)sender {
    if (!timerCount) {
        timerCount = MaxCodeTime;
        if (!timer) {
            timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
            [timer event:^{
                timerCount--;
                if (timerCount) {
                    [self.codeBtn setTitle:[NSString stringWithFormat:@"%d s",timerCount] forState:UIControlStateNormal];
                }else{
                    [self.codeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
                    [timer destroy];
                    timer = nil;
                }
            } timeInterval:NSEC_PER_SEC];
        }
        [timer start];
    }
}

- (IBAction)save:(id)sender {
    if (self.stly) {
    }else{
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)checkPotocal:(id)sender {
    WebShowViewController *webContor = [[WebShowViewController alloc] initWithNibName:@"WebShowViewController" bundle:nil];
    webContor.tittle = @"Super VR 网络协议";
    webContor.url = @"https://www.baidu.com";
    [self.navigationController pushViewController:webContor animated:YES];
}

#pragma mark-tableview代理方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [[UIView alloc] init];
    [head setBackgroundColor:[UIColor clearColor]];
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return self.footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return self.footView.frame.size.height;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return self.phoneCell;
    }else if (indexPath.row == 1){
        return self.passCell;
    }else{
        return self.codeCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
