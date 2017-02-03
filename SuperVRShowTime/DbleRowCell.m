//
//  DbleRowCell.m
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 16/9/13.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "DbleRowCell.h"
#import "ToolOprationer.h"
#import "ShowVRController.h"
#import "AppDelegate.h"

@interface DbleRowCell()
{
    
}

@property (weak, nonatomic) IBOutlet UIButton *Btn1;
@property (weak, nonatomic) IBOutlet UILabel *Lbel1;
@property (weak, nonatomic) IBOutlet UIView *View2;
@property (weak, nonatomic) IBOutlet UIButton *Btn2;
@property (weak, nonatomic) IBOutlet UILabel *Lbel2;
@property (strong, nonatomic) DbleRowData *leftData;
@property (strong, nonatomic) DbleRowData *rightData;

@end


@implementation DbleRowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initWithData_Left:(DbleRowData*)leftData right:(DbleRowData*)rightData{
    //TODO: 目前图片展示  视频都是 本地加载
    self.leftData = leftData;
    self.rightData = rightData;
    
    self.Lbel1.text = leftData.tittle;
    [self.Btn1 setImage:[UIImage imageNamed:leftData.imageUrl] forState:UIControlStateNormal];
    
    if (rightData) {
        [self.View2 setAlpha:1];
        self.Lbel2.text = rightData.tittle;
        [self.Btn2 setImage:[UIImage imageNamed:rightData.imageUrl] forState:UIControlStateNormal];
    }else{
        [self.View2 setAlpha:0];
    }
}

- (IBAction)doBtnAction:(UIButton *)sender {
    NSString *path;
    UVPlayerItemType type;
    if (sender.tag == 0) {
        path = self.leftData.videoUrl;
        type = self.leftData.urlType.integerValue;
    }else{
        path = self.rightData.videoUrl;
        type = self.rightData.urlType.integerValue;
    }
//    [[ToolOprationer sharedInstance] showVRviewToWindow:@[path] type:type];
    
    ShowVRController *showVR = [[ShowVRController alloc] init];
    showVR.path = path;
    [[AppDelegate getMainAppDelegate].window addSubview:showVR.view];
}

@end
