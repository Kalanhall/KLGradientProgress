//
//  KLGradientConfig.h
//  KLGradientProgress
//
//  Created by Logic on 2020/3/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLGradientConfig : NSObject

/// 渐变色集合，必填
@property (strong, nonatomic) NSArray *colors;
/// 渐变色比例集合
@property (strong, nonatomic) NSArray *locations;
/// 每次执行进度的动画时间，默认 1s
@property (assign, nonatomic) CGFloat duration;
/// 线宽
@property (assign, nonatomic) CGFloat lineWidth;
/// 渐变起点
@property (assign, nonatomic) CGPoint startPoint;
/// 渐变终点
@property (assign, nonatomic) CGPoint endPoint;
/// 终点偏移角度，左偏移 < 0，右偏移 > 0，默认 = -1.5度
@property (assign, nonatomic) CGFloat endPointOffset;
/// 锥形渐变背景图，iOS12以下需要提供此图片
@property (strong, nonatomic) UIImage *gradientImage API_DEPRECATED("iOS 12 以下需要使用渐变背景图，其他由代码生成", ios(6.0, 11.0));
/// 头部阴影
@property (assign, nonatomic) BOOL hasTopShadow;
/// 整体阴影
@property (strong, nonatomic) UIColor *shadowColor;
/// 整体阴影
@property (assign, nonatomic) CGFloat shadowOpacity;
/// 整体阴影
@property (assign, nonatomic) CGSize shadowOffset;
/// 轨迹背景图
@property (strong, nonatomic) UIImage *trackImage;
/// 轨迹背景色
@property (strong, nonatomic) NSArray *trackColors;
/// 轨迹渐变色比例集合
@property (strong, nonatomic) NSArray *trackLocations;
/// 轨迹线宽
@property (assign, nonatomic) CGFloat trackLineWidth;
/// 渐变起点
@property (assign, nonatomic) CGPoint trackStartPoint;
/// 渐变终点
@property (assign, nonatomic) CGPoint trackEndPoint;
/// 轨迹线宽
@property (assign, nonatomic) CGFloat trackAlpha;

@end

NS_ASSUME_NONNULL_END
