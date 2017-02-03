//
//  HelpCell.m
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 2016/11/7.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "HelpCell.h"

@interface HelpCell()

@property (weak, nonatomic) IBOutlet UIImageView *showImagV;
@property (weak, nonatomic) IBOutlet UILabel *tittleLble;
@property (weak, nonatomic) IBOutlet UILabel *bodyLbel;

@end

@implementation HelpCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initDataWith:(HelpData *)data{
    self.tittleLble.text = data.tittle;
    self.bodyLbel.text = data.body;
    self.tittleLble.frame = data.titleFrame;
    self.showImagV.frame = data.imageFrame;
    self.bodyLbel.frame = data.bodyFrame;
    if (!data.stly) {
        self.showImagV.transform = CGAffineTransformMakeRotation(0);
    }else{
        self.showImagV.transform = CGAffineTransformMakeRotation(90 *M_PI / 180.0);
    }
}


@end
