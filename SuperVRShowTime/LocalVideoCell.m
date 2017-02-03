//
//  LocalVideoCell.m
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 16/10/8.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import "LocalVideoCell.h"

@interface LocalVideoCell()

@property (weak, nonatomic) IBOutlet UIImageView *showImagV;
@property (weak, nonatomic) IBOutlet UILabel *nameLble;
@property (weak, nonatomic) IBOutlet UILabel *timeLbel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLbel;

@end

@implementation LocalVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initDataWith:(LocalVideoData *)data{
    self.showImagV.image = data.image;
    self.nameLble.text = data.name;
    self.timeLbel.text = data.time;
    self.sizeLbel.text = data.size;
}


@end
