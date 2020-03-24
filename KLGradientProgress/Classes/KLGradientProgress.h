//
//  KLGradientProgress.h
//  KLGradientProgress
//
//  Created by Logic on 2020/3/21.
//

#import <UIKit/UIKit.h>
#import "KLGradientConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface KLGradientProgress : UIView

@property (assign, nonatomic, readonly) CGFloat progress;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame config:(KLGradientConfig *)config;
- (void)setProgress:(CGFloat)progress animation:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
