//
//  BackUpAndRestoreViewController.h
//  BabyWatch
//
//  Created by SL02 on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Http.h"

@interface BackUpAndRestoreViewController : UIViewController<HttpDelegate>
{
	Http*			http;
	UILabel *		displayUrlLabel;
    
}
@property (nonatomic, strong) IBOutlet UILabel *	displayUrlLabel;
@property (nonatomic, strong) Http*					http;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *showActivity;
@property (nonatomic, strong) IBOutlet UIView *m_view;

@property (nonatomic, strong) IBOutlet UILabel *backUp1Lbel;
@property (nonatomic, strong) IBOutlet UILabel *tip1Lbel;
@property (nonatomic, strong) IBOutlet UILabel *tip2Lbel;
@property (nonatomic, strong) IBOutlet UILabel *tip3Lbel;
@property (nonatomic, strong) IBOutlet UILabel *tip4Lbel;


@end
