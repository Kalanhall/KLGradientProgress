//
//  KLViewController.m
//  KLGradientProgress
//
//  Created by Kalanhall@163.com on 03/21/2020.
//  Copyright (c) 2020 Kalanhall@163.com. All rights reserved.
//

#import "KLViewController.h"
@import KLGradientProgress;
@import KLCategory;

@interface KLViewController ()

@property (strong, nonatomic) KLGradientProgress *progressView;

@end

@implementation KLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    KLGradientConfig *config = KLGradientConfig.alloc.init;
    config.colors = @[(id)KLColor(0x49BAFF),
                      (id)KLColor(0x9CD8FF),
                      (id)KLColor(0xBAFF9E),
                      (id)KLColor(0xF2FD3C),
                      (id)KLColor(0xFF6500),
                      (id)KLColor(0xFF5000)];
    // 进度设置
    config.locations = @[@0, @0.15, @0.3, @0.45, @0.65, @1];
    config.lineWidth = 100;
    config.startPoint = CGPointMake(0.5, 0.5);
    config.endPoint = CGPointMake(0.5, 0);
    config.endPointOffset = -1.5; // 如果尾部有空隙，调整偏移角度
    config.gradientImage = [UIImage imageNamed:@"Conic"];
    // 轨迹设置
    config.trackColors = config.colors;
    config.trackLocations = config.locations;
//    config.trackColors = @[[UIColor lightGrayColor]]; // 单色轨迹
    config.trackLineWidth = config.lineWidth;
    config.trackStartPoint = config.startPoint;
    config.trackEndPoint = config.endPoint;
    config.trackAlpha = 0.4;
//    config.shadowColor = UIColor.blackColor;
//    config.shadowOpacity = 0.3;
//    config.shadowOffset = CGSizeMake(0, 0);

    KLGradientProgress *progressView = [KLGradientProgress.alloc initWithFrame:(CGRect){20, 100, self.view.bounds.size.width - 40,self.view.bounds.size.width - 40} config:config];
    [self.view addSubview:progressView];
    self.progressView = progressView;
    

    __weak typeof(progressView) wkprogressView = progressView;
    __block CGFloat index = 0;
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        index += 0.1;
        if (index > 1) {
            [timer invalidate];
            [wkprogressView setProgress:0 animation:NO];
        } else {
            [wkprogressView setProgress:index animation:YES];
        }
    }];
}

- (IBAction)slider:(UISlider *)sender {
    [self.progressView setProgress:sender.value animation:YES];
}


@end
