//
//  KLGradientConfig.m
//  KLGradientProgress
//
//  Created by Logic on 2020/3/21.
//

#import "KLGradientConfig.h"

@implementation KLGradientConfig

- (CGFloat)endPointOffset
{
    if (_endPointOffset == 0) {
        _endPointOffset = -1.5;
    }
    return _endPointOffset;
}

- (CGFloat)trackAlpha
{
    if (_trackAlpha == 0) {
        _trackAlpha = 1;
    }
    return _trackAlpha;
}

- (CGFloat)duration
{
    if (_duration == 0) {
        _duration = 1;
    }
    return _duration;
}

@end
