//
//  ShowImage.m
//  XinBaDiary
//
//  Created by XiaoweiYang on 16/3/29.
//
//

#import "ShowImage.h"
#import "AppDelegate.h"


@interface ShowImage()
{
    //photo scale
    float width_orgin;
    CGAffineTransform orginTransform;
    CGPoint showCenterPoint;
    
    UIView *m_showImagView;
    UIImageView *m_ImageV;
}

@end


@implementation ShowImage

+ (ShowImage *)sharedInstance {
    
    static ShowImage *oprationer = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        oprationer = [[ShowImage alloc] init];
    });
    
    return oprationer;
}

-(void)showImage:(UIImage *)showImage{
    if (showImage) {
        [self.m_showImagView removeFromSuperview];
        self.m_showImagView.backgroundColor = [UIColor clearColor];
        CGRect r1 = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.m_showImagView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);
        [[AppDelegate getMainAppDelegate].window addSubview:self.m_showImagView];
        
        self.m_ImageV.image = showImage;
        self.m_ImageV.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        width_orgin = self.m_ImageV.frame.size.width;
        orginTransform = self.m_ImageV.transform;
        
        [UIView animateWithDuration:0.4 animations:^
         {
             self.m_showImagView.frame = r1;
             self.m_showImagView.backgroundColor = [UIColor blackColor];
         }
                         completion:^(BOOL finished)
         {
             
         }
         ];
    }
}

#pragma mark - showimage

-(UIImageView *)m_ImageV
{
    if (!m_ImageV) {
        m_ImageV = [[UIImageView alloc] init];
        m_ImageV.backgroundColor = [UIColor clearColor];
        [m_ImageV setUserInteractionEnabled:YES];
        [m_ImageV setContentMode:UIViewContentModeScaleAspectFit];
    }
    
    return m_ImageV;
}

-(UIView *)m_showImagView
{
    if (!m_showImagView)
    {
        m_showImagView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [m_showImagView addSubview:self.m_ImageV];
        
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPhoto_tap:)];
        tap2.numberOfTapsRequired = 1;
        tap2.numberOfTouchesRequired = 1;
        [m_showImagView addGestureRecognizer:tap2];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(showPhoto_tapDouble:)];
        doubleTap.numberOfTapsRequired = 2;
        doubleTap.numberOfTouchesRequired = 1;
        [self.m_ImageV addGestureRecognizer:doubleTap];
        
        [tap2 requireGestureRecognizerToFail:doubleTap];
        
        UIPinchGestureRecognizer *pinchGestureRecongnizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(showPhoto_pinch:)];
        [self.m_ImageV addGestureRecognizer:pinchGestureRecongnizer];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(showPhoto_pan:)];
        [self.m_ImageV addGestureRecognizer:panGesture];
    }
    
    return m_showImagView;
}



-(void)showPhoto_tap:(UITapGestureRecognizer *)tap
{
    if ([tap isKindOfClass:[UITapGestureRecognizer class]])
    {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        CGRect r1 = self.m_showImagView.frame;
        
        [UIView animateWithDuration:0.4 animations:^
         {
             self.m_showImagView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.m_showImagView.frame.size.width, self.m_showImagView.frame.size.height);
             
             self.m_showImagView.backgroundColor = [UIColor clearColor];
             self.m_ImageV.transform = orginTransform;
             
         }
                         completion:^(BOOL finished)
         {
             self.m_showImagView.frame = r1;
             [self.m_showImagView removeFromSuperview];
         }
         ];
    }
}

-(void)showPhoto_tapDouble:(UITapGestureRecognizer *)tapDouble
{
    if ([tapDouble isKindOfClass:[UITapGestureRecognizer class]])
    {
        int isReset;
        CGAffineTransform lastTransform;
        if (tapDouble.view.frame.size.width >= 2*width_orgin)
        {
            lastTransform = CGAffineTransformScale(orginTransform, 1, 1);
            isReset = 1;
        }
        else if (tapDouble.view.frame.size.width < 2*width_orgin)
        {
            lastTransform = CGAffineTransformScale(orginTransform, 2, 2);
            isReset = 1;
        }
        else
        {
            isReset = 0;
        }
        
        [UIView animateWithDuration:0.2 animations:^
         {
             if (isReset == 1)
             {
                 tapDouble.view.transform = lastTransform;
             }
             tapDouble.view.center = self.m_showImagView.center;
         }
                         completion:^(BOOL finished)
         {
             
         }
         ];
    }
}

-(void)showPhoto_pinch:(UIPinchGestureRecognizer *)pinch
{
    if ([pinch isKindOfClass:[UIPinchGestureRecognizer class]])
    {
        pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale, pinch.scale);
        pinch.scale = 1;
        
        if (pinch.state == UIGestureRecognizerStateEnded || pinch.state == UIGestureRecognizerStateCancelled)
        {
            int isReset;
            CGAffineTransform lastTransform;
            if (pinch.view.frame.size.width > 3*width_orgin)
            {
                lastTransform = CGAffineTransformScale(orginTransform, 3, 3);
                isReset = 1;
            }
            else if (pinch.view.frame.size.width < width_orgin)
            {
                lastTransform = CGAffineTransformScale(orginTransform, 1, 1);
                isReset = 1;
            }
            else
            {
                isReset = 0;
            }
            
            [UIView animateWithDuration:0.2 animations:^
             {
                 if (isReset == 1)
                 {
                     pinch.view.transform = lastTransform;
                 }
                 pinch.view.center = self.m_showImagView.center;
             }
                             completion:^(BOOL finished)
             {
                 
             }
             ];
        }
    }
}

-(void)showPhoto_pan:(UIPanGestureRecognizer *)pan
{
    if ([pan isKindOfClass:[UIPanGestureRecognizer class]])
    {
        CGPoint currentTouchPoint = [pan locationInView:self.m_showImagView];
        CGPoint velocity = [pan velocityInView:self.m_showImagView];
        
        if (pan.state == UIGestureRecognizerStateBegan)
        {
            showCenterPoint = currentTouchPoint;
        }
        else if (pan.state == UIGestureRecognizerStateChanged)
        {
            pan.view.center = CGPointMake(pan.view.center.x-showCenterPoint.x+currentTouchPoint.x,  pan.view.center.y-showCenterPoint.y+currentTouchPoint.y);
            showCenterPoint = currentTouchPoint;
        }
        else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled)
        {
            CGPoint lastPoint = pan.view.center;
            int isShow = 0;
            if (velocity.x > 0)
            {
                if (pan.view.frame.origin.x > 0 && (pan.view.frame.origin.x+pan.view.frame.size.width) > self.m_showImagView.frame.size.width)
                {
                    if (pan.view.frame.size.width < self.m_showImagView.frame.size.width)
                    {
                        lastPoint.x = self.m_showImagView.center.x;
                    }
                    else
                    {
                        lastPoint.x = pan.view.frame.size.width/2;
                    }
                    isShow = 1;
                }
                else if (pan.view.frame.origin.x < 0 && (pan.view.frame.origin.x+pan.view.frame.size.width) < self.m_showImagView.frame.size.width && pan.view.frame.size.width <= self.m_showImagView.frame.size.width)
                {
                    lastPoint.x = self.m_showImagView.center.x;
                    isShow = 1;
                }
                else if (pan.view.frame.origin.x < 0 && (pan.view.frame.origin.x+pan.view.frame.size.width) < self.m_showImagView.frame.size.width && pan.view.frame.size.width > self.m_showImagView.frame.size.width)
                {
                    lastPoint.x = pan.view.frame.size.width/2;
                    isShow = 1;
                }
            }
            else
            {
                if ((pan.view.frame.size.width+pan.view.frame.origin.x) < self.m_showImagView.frame.size.width && pan.view.frame.origin.x < 0)
                {
                    if (pan.view.frame.size.width < self.m_showImagView.frame.size.width)
                    {
                        lastPoint.x = self.m_showImagView.center.x;
                    }
                    else
                    {
                        lastPoint.x = self.m_showImagView.frame.size.width - pan.view.frame.size.width/2;
                    }
                    isShow = 1;
                }
                else if ((pan.view.frame.size.width+pan.view.frame.origin.x) > self.m_showImagView.frame.size.width && pan.view.frame.origin.x > 0 && pan.view.frame.size.width <= self.m_showImagView.frame.size.width)
                {
                    lastPoint.x = self.m_showImagView.center.x;
                    isShow = 1;
                }
                else if ((pan.view.frame.size.width+pan.view.frame.origin.x) > self.m_showImagView.frame.size.width && pan.view.frame.origin.x > 0 && pan.view.frame.size.width > self.m_showImagView.frame.size.width)
                {
                    lastPoint.x = self.m_showImagView.frame.size.width - pan.view.frame.size.width/2;
                    isShow = 1;
                }
            }
            
            if (velocity.y > 0)
            {
                if (pan.view.frame.origin.y > 0 && (pan.view.frame.origin.y+pan.view.frame.size.height) > self.m_showImagView.frame.size.height)
                {
                    if (pan.view.frame.size.height < self.m_showImagView.frame.size.height)
                    {
                        lastPoint.y = self.m_showImagView.center.y;
                    }
                    else
                    {
                        lastPoint.y = pan.view.frame.size.height/2;
                    }
                    isShow = 1;
                }
                else if (pan.view.frame.origin.y < 0 && (pan.view.frame.origin.y+pan.view.frame.size.height) < self.m_showImagView.frame.size.height && pan.view.frame.size.height <= self.m_showImagView.frame.size.height)
                {
                    lastPoint.y = self.m_showImagView.center.y;
                    isShow = 1;
                }
                else if (pan.view.frame.origin.y < 0 && (pan.view.frame.origin.y+pan.view.frame.size.height) < self.m_showImagView.frame.size.height && pan.view.frame.size.height > self.m_showImagView.frame.size.height)
                {
                    lastPoint.y = pan.view.frame.size.height/2;
                    isShow = 1;
                }
            }
            else
            {
                if (pan.view.frame.size.height+pan.view.frame.origin.y < self.m_showImagView.frame.size.height && pan.view.frame.origin.y < 0)
                {
                    if (pan.view.frame.size.height < self.m_showImagView.frame.size.height)
                    {
                        lastPoint.y = self.m_showImagView.center.y;
                    }
                    else
                    {
                        lastPoint.y = self.m_showImagView.frame.size.height - pan.view.frame.size.height/2;
                    }
                    isShow = 1;
                }
                else if ((pan.view.frame.size.height+pan.view.frame.origin.y) > self.m_showImagView.frame.size.height && pan.view.frame.origin.y > 0 && pan.view.frame.size.height <= self.m_showImagView.frame.size.height)
                {
                    lastPoint.y = self.m_showImagView.center.y;
                    isShow = 1;
                }
                else if ((pan.view.frame.size.height+pan.view.frame.origin.y) > self.m_showImagView.frame.size.height && pan.view.frame.origin.y > 0 && pan.view.frame.size.height > self.m_showImagView.frame.size.height)
                {
                    lastPoint.y = self.m_showImagView.frame.size.height - pan.view.frame.size.height/2;
                    isShow = 1;
                }
            }
            
            if (pan.view.frame.origin.x > 0 && (pan.view.frame.origin.x+pan.view.frame.size.width) < self.m_showImagView.frame.size.width)
            {
                lastPoint.x = self.m_showImagView.center.x;
                isShow = 1;
            }
            
            if (pan.view.frame.origin.y > 0 && (pan.view.frame.origin.y+pan.view.frame.size.height) < self.m_showImagView.frame.size.height)
            {
                lastPoint.y = self.m_showImagView.center.y;
                isShow = 1;
            }
            
            if (isShow == 1)
            {
                [UIView animateWithDuration:0.2 animations:^
                 {
                     pan.view.center = lastPoint;
                 }
                                 completion:^(BOOL finished)
                 {
                     
                 }
                 ];
            }
        }
    }
}



@end
