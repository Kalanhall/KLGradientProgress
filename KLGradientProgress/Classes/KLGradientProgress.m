//
//  KLGradientProgress.m
//  KLGradientProgress
//
//  Created by Logic on 2020/3/21.
//

#import "KLGradientProgress.h"

@interface KLGradientProgress ()

// 轨迹视图
@property (strong, nonatomic) UIImageView *trackView;
@property (strong, nonatomic) CAShapeLayer *trackPathLayer;
@property (strong, nonatomic) UIBezierPath *trackPath;

// 进度视图
@property (strong, nonatomic) UIImageView *progressView;
@property (strong, nonatomic) CAShapeLayer *progressPathLayer;
@property (strong, nonatomic) UIBezierPath *progressPath;

// 起点视图
@property (strong, nonatomic) UIImageView *startLayer;
@property (strong, nonatomic) CAShapeLayer *startPathLayer;
@property (strong, nonatomic) UIBezierPath *startPath;

// 终点视图
@property (strong, nonatomic) UIImageView *endLayer;
@property (strong, nonatomic) CAShapeLayer *endPathLayer;
@property (strong, nonatomic) UIBezierPath *endPath;

// 绘图配置
@property (strong, nonatomic) KLGradientConfig *config;

// 当前角度
@property (assign, nonatomic) CGFloat angle;
// 当前进度
@property (assign, nonatomic) CGFloat progress;

@end

@implementation KLGradientProgress

- (instancetype)initWithFrame:(CGRect)frame config:(KLGradientConfig *)config
{
    self = [super initWithFrame:frame];
    if (self) {
        self.config = config;
        
        self.progressView = UIImageView.new;
        self.progressView.contentMode = UIViewContentModeScaleAspectFill;
        self.progressView.frame = self.bounds;
        [self addSubview:self.progressView];
        
        self.trackView = UIImageView.new;
        self.trackView.contentMode = UIViewContentModeScaleAspectFill;
        self.trackView.frame = self.bounds;
        self.trackView.alpha = config.trackAlpha;
        [self insertSubview:self.trackView belowSubview:self.progressView];
        
        // TODO: 锥形渐变视图搭建
        // 进度轨迹
        if (UIDevice.currentDevice.systemVersion.floatValue >= 12.0 && config.gradientImage == nil) {
            [self.progressView.layer addSublayer:[self gradientLayerWithConfig:config]];
        } else {
            self.progressView.image = config.gradientImage;
        }

        CGPoint center = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5);
        CGFloat radius = frame.size.width * 0.5 - config.lineWidth * 0.5;
        self.progressPath = [UIBezierPath bezierPathWithArcCenter:center
                                                           radius:radius
                                                       startAngle:- M_PI_2
                                                         endAngle:M_PI_2 * 3
                                                        clockwise:YES];
        
        self.progressPathLayer = [CAShapeLayer layer];
        self.progressPathLayer.fillColor = [UIColor clearColor].CGColor;
        self.progressPathLayer.strokeColor = UIColor.redColor.CGColor;
        self.progressPathLayer.lineWidth = config.lineWidth;
        self.progressPathLayer.frame = self.bounds;
        self.progressPathLayer.path = self.progressPath.CGPath;
        self.progressView.layer.mask = self.progressPathLayer;
        self.progressPathLayer.strokeEnd = 0;
        
        // 背景轨迹
        if (UIDevice.currentDevice.systemVersion.floatValue >= 12.0 && config.trackColors.count > 1) {
            [self.trackView.layer addSublayer:[self gradientTrackLayerWithConfig:config]];
        } else {
            self.trackView.image = config.trackImage;
            self.trackView.backgroundColor = config.trackColors.firstObject;
        }
        
        radius = config.trackLineWidth > 0 ? frame.size.width * 0.5 - config.trackLineWidth * 0.5 : frame.size.width * 0.5 - config.lineWidth * 0.5;
        self.trackPath = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:- M_PI_2
                                                      endAngle:M_PI_2 * 3
                                                     clockwise:YES];
        
        self.trackPathLayer = [CAShapeLayer layer];
        self.trackPathLayer.fillColor = [UIColor clearColor].CGColor;
        self.trackPathLayer.strokeColor = UIColor.redColor.CGColor;
        self.trackPathLayer.lineWidth = config.trackLineWidth;
        self.trackPathLayer.frame = self.bounds;
        self.trackPathLayer.path = self.trackPath.CGPath;
        self.trackView.layer.mask = self.trackPathLayer;
        self.trackPathLayer.strokeEnd = 1;

        self.startLayer = UIImageView.alloc.init;
        self.startLayer.frame = self.bounds;
        self.startLayer.contentMode = UIViewContentModeScaleAspectFill;
        self.startLayer.backgroundColor = config.colors.firstObject;
        [self insertSubview:self.startLayer belowSubview:self.progressView];

        center = CGPointMake(frame.size.width * 0.5, config.lineWidth * 0.5);
        radius = config.lineWidth * 0.5;
        self.startPath = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:-M_PI_2
                                                      endAngle:M_PI_2
                                                     clockwise:NO];

        self.startPathLayer = [CAShapeLayer layer];
        self.startPathLayer.strokeColor = UIColor.clearColor.CGColor;
        self.startPathLayer.fillColor = [UIColor redColor].CGColor;
        self.startPathLayer.frame = self.bounds;
        self.startPathLayer.path = self.startPath.CGPath;
        self.startLayer.layer.mask = self.startPathLayer;

        self.endLayer = UIImageView.alloc.init;
        self.endLayer.frame = self.bounds;
        self.endLayer.contentMode = UIViewContentModeScaleAspectFill;
        self.endLayer.backgroundColor = config.colors.lastObject;
        [self addSubview:self.endLayer];

        if (UIDevice.currentDevice.systemVersion.floatValue >= 12.0 && config.gradientImage == nil) {
            [self.endLayer.layer addSublayer:[self gradientLayerWithConfig:config]];
        } else {
            self.endLayer.image = config.gradientImage;
        }

        self.endPath = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:-M_PI_2
                                                      endAngle:M_PI_2
                                                     clockwise:YES];

        self.endPathLayer = [CAShapeLayer layer];
        self.endPathLayer.strokeColor = UIColor.clearColor.CGColor;
        self.endPathLayer.fillColor = [UIColor redColor].CGColor;
        self.endPathLayer.frame = self.bounds;
        self.endPathLayer.path = self.endPath.CGPath;
        self.endLayer.layer.mask = self.endPathLayer;

        if (config.shadowColor) {
            self.layer.shadowColor = config.shadowColor.CGColor;
            self.layer.shadowOpacity = config.shadowOpacity;
            self.layer.shadowOffset = config.shadowOffset;
        }

    }
    return self;
}

- (void)setProgress:(CGFloat)progress animation:(BOOL)animation
{
    if (progress >= 1) {
        progress = 1;
    }
    
    // 实时移动弧度
    CGFloat angle = M_PI * 2 * progress;
    // 偏移弧度
    CGFloat offset = (self.config.endPointOffset) / 180.0 * M_PI;
    // 真实移动弧度
    CGFloat realAngle = angle + offset > 0 ? angle + offset : 0;
    
    // 进入最后一个色值，切换画布
    NSAssert(self.config.locations.count > 2, @"请设置渐变比例集合locations!");
    CGFloat temp = [self.config.locations[self.config.locations.count - 2] floatValue];
    BOOL result = progress > 0.5 + 0.5 *temp;
    
    // 隐藏渐变图层
    // 关闭隐式动画，否则快速滑动时末端会有闪烁
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    if (UIDevice.currentDevice.systemVersion.floatValue >= 12.0 && self.config.gradientImage == nil) {
        self.endLayer.layer.sublayers.lastObject.hidden = result;
    } else {
        if (result) {
            self.endLayer.image = nil;
        } else {
            self.endLayer.image = self.config.gradientImage;
        }
    }
    
    [CATransaction commit];

    if (animation) {
        CABasicAnimation *transform = CABasicAnimation.animation;
        transform.keyPath = @"transform.rotation.z";
        transform.duration = self.config.duration;
        transform.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        transform.fromValue = @(self.angle);
        transform.toValue = @(realAngle);
        transform.fillMode = kCAFillModeForwards;
        transform.removedOnCompletion = NO;
        [self.endPathLayer  addAnimation:transform forKey:nil];
        
        
        CABasicAnimation *strokeEnd = CABasicAnimation.animation;
        strokeEnd.keyPath = @"strokeEnd";
        strokeEnd.duration = self.config.duration;
        strokeEnd.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        strokeEnd.fromValue = @(self.progress);
        strokeEnd.toValue = @(progress);
        strokeEnd.fillMode = kCAFillModeForwards;
        strokeEnd.removedOnCompletion = NO;
        [self.progressPathLayer addAnimation:strokeEnd forKey:nil];
    } else {
        [self.endPathLayer removeAllAnimations];
        [self.progressPathLayer removeAllAnimations];
        self.endPathLayer.transform = CATransform3DMakeRotation(realAngle, 0, 0, 1);
        self.progressPathLayer.strokeEnd = progress;
    }
    
    _angle = realAngle;
    _progress = progress;
}

// MARK: 生成渐变背景图层
- (CAGradientLayer *)gradientLayerWithConfig:(KLGradientConfig *)config
{
    CAGradientLayer *gradient = CAGradientLayer.layer;
    gradient.colors = @[];
    [config.colors enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        gradient.colors = [gradient.colors arrayByAddingObject:(id)[obj CGColor]];
    }];
    gradient.locations = config.locations;
    gradient.startPoint = config.startPoint;
    gradient.endPoint = config.endPoint;
    gradient.frame = self.bounds;
    if (@available(iOS 12.0, *)) {
        gradient.type = kCAGradientLayerConic;
        gradient.endPoint = CGPointMake(config.endPoint.x - 0.005, config.endPoint.y); // 画布调整
    }
    return gradient;
}

// MARK: 生成渐变轨迹背景图层
- (CAGradientLayer *)gradientTrackLayerWithConfig:(KLGradientConfig *)config
{
    CAGradientLayer *gradient = CAGradientLayer.layer;
    gradient.colors = @[];
    [config.trackColors enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        gradient.colors = [gradient.colors arrayByAddingObject:(id)[obj CGColor]];
    }];
    gradient.locations = config.trackLocations;
    gradient.startPoint = config.trackStartPoint;
    gradient.endPoint = config.trackEndPoint;
    gradient.frame = self.bounds;
    if (@available(iOS 12.0, *)) {
        gradient.type = kCAGradientLayerConic;
    }
    return gradient;
}

@end
