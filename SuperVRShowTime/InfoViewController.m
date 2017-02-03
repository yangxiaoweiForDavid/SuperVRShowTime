//
//  InfoViewController.m
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 2016/11/6.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "InfoViewController.h"
#import "ShowImage.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "NameViewController.h"

@interface InfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
}
@property (nonatomic,strong) UIImage *headImage;

@property (weak, nonatomic) IBOutlet UITableView *myTableview;
@property (strong, nonatomic) IBOutlet UITableViewCell *headCell;
@property (weak, nonatomic) IBOutlet UIImageView *headImagV;
@property (strong, nonatomic) IBOutlet UITableViewCell *nameCell;
@property (weak, nonatomic) IBOutlet UILabel *nameLbel;
@property (strong, nonatomic) IBOutlet UITableViewCell *phoneCell;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbel;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController setNavigationBarHidden:NO];
    
    self.navigationItem.title = @"我的资料";
    
    self.headCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.nameCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    _headImage = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return self.headCell;
    }else if (indexPath.row == 1){
        return self.nameCell;
    }else{
        return self.phoneCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self getPhoto];
    }else if (indexPath.row == 1){
        NameViewController *nameContor = [[NameViewController alloc] initWithNibName:@"NameViewController" bundle:nil];
        [self.navigationController pushViewController:nameContor animated:YES];
    }
}

-(void)getPhoto{
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *show =[UIAlertAction actionWithTitle:@"查看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[ShowImage sharedInstance] showImage:self.headImage];
    }];
    UIAlertAction *photo =[UIAlertAction actionWithTitle:@"从相册中选取图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            UIImagePickerController *pickImage =[[UIImagePickerController alloc]init];
            pickImage.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
            
            pickImage.delegate = self;
            pickImage.allowsEditing = YES;
            [self presentViewController:pickImage animated:YES completion:nil];
            
        }else{
            [WrongMsgViewController showMsg:@"相机不可用!"];
        }
    }];
    UIAlertAction *takePhoto =[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            UIImagePickerController *camera =[[UIImagePickerController alloc]init];
            camera.delegate =self;
            camera.allowsEditing =YES;
            camera.sourceType =UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:camera animated:NO completion:nil];
            
        }else{
            [WrongMsgViewController showMsg:@"相机不可用!"];
        }
    }];
    
    if (self.headImage) {
        [alert addAction:show];
    }
    [alert addAction:photo];
    [alert addAction:takePhoto];
    [alert addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark－调用相机的代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        self.headImage = image;
        self.headImagV.image = self.headImage;
    }
}


@end
