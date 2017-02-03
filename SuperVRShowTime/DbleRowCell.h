//
//  DbleRowCell.h
//  SuperVRShowTime
//
//  Created by XiaoweiYang on 16/9/13.
//  Copyright © 2016年 XiaoweiYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonClass.h"


@interface DbleRowCell : UITableViewCell

-(void)initWithData_Left:(DbleRowData*)leftData right:(DbleRowData*)rightData;

@end
