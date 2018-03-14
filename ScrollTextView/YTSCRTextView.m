//
//  YTSCRTextView.m
//  AnyTest
//
//  Created by 木易 on 2018/3/3.
//  Copyright © 2018年 晓天. All rights reserved.
//

#import "YTSCRTextView.h"

/** 滚动速度  像素/s */
#define default_Animation_Speed 90.

@interface YTSCRTextView ()

@property (nonatomic, strong) UIScrollView *mainScrollV;

@property (nonatomic, strong) UILabel *noticeL;//显示要滚动的文字
@property (nonatomic, strong) UILabel *twoNoticeL;//无缝循环所需   追加在前一个的屁股后边

@property (nonatomic, strong) UIButton *topLayerBtn;

@end

@implementation YTSCRTextView{
//    NSInteger _currentIndex;//待扩展
    
    CGFloat _labelWidth;
    /** 一个合适的动画运行时间 */
    CGFloat _currentAnimationDuration;
    /** 是否需要立即开始滚动 */
    BOOL _haveFireScroll;
    BOOL _stop;
}

- (instancetype)initWithFrame:(CGRect)frame textFont:(UIFont *)font textColor:(UIColor *)color scrollTextContent:(NSString *)text animationFireScroll:(BOOL)isFire{
    self = [super initWithFrame:frame];
    if (self) {
        _labelWidth = frame.size.width;
        _haveFireScroll = isFire;
        [self setTextColor:color];
        [self setTextFont:font];
        [self setScrollTextContent:text];
    }
    return self;
}

- (void)removeFromSuperview{
    _stop = YES;
    [super removeFromSuperview];
}

- (void)stopTextScroll{
    _stop = YES;
}

- (void)restartTextScroll{
    _stop = NO;
    [self performSelector:@selector(startScroll) withObject:nil afterDelay:1.5];
}

// 关键代码 其他的都是垃圾
- (void)startScroll{
    __weak typeof(self) ws = self;

    [UIView transitionWithView:self.mainScrollV
                      duration:_currentAnimationDuration
                       options:UIViewAnimationOptionCurveLinear
                    animations:^{
                        ws.mainScrollV.contentOffset = CGPointMake(_labelWidth * 2, 0);
                        
                    } completion:^(BOOL finished) {
                        if (!_stop) {
                            [ws startScroll];
                        }else{
                            NSLog(@"该停下了！！！");
                        }
    }];
    [self setScrollViewContentOffsetCenter];
    
}


- (void)setScrollViewContentOffsetCenter {
    self.mainScrollV.contentOffset = CGPointMake(MAX(self.frame.size.width, _labelWidth), 0);
}

#pragma mark -

- (void)setScrollTextContent:(NSString *)scrollTextContent{
    _scrollTextContent = scrollTextContent;
    _labelWidth = [scrollTextContent sizeWithFont:self.textFont constrainedToSize:CGSizeMake(2000, 30) lineBreakMode:(NSLineBreakMode)NSLineBreakByWordWrapping].width;
    _currentAnimationDuration =  _labelWidth / default_Animation_Speed;
    
    self.noticeL.text = scrollTextContent;
    self.twoNoticeL.text = scrollTextContent;
    CGFloat labelWidth = MAX(self.frame.size.width, _labelWidth);
    self.noticeL.frame = CGRectMake(0, 0, labelWidth, self.bounds.size.height);
    self.twoNoticeL.frame = CGRectMake(self.noticeL.frame.origin.x + self.noticeL.frame.size.width, 0, labelWidth, self.bounds.size.height);
    
    self.mainScrollV.contentSize = CGSizeMake(MAX(self.frame.size.width, _labelWidth) * 2., 0);
    _mainScrollV.contentOffset = CGPointMake(MAX(self.frame.size.width, _labelWidth), 0);
    

    if (_labelWidth <= self.frame.size.width) {
        _stop = YES;
        _haveFireScroll = NO;
    }else{
        _stop = NO;
        _haveFireScroll = YES;
        [self startScroll];
    }
    NSLog(@"%f",_labelWidth);
}

- (void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
    if (textFont) {
        self.noticeL.font = textFont;
        self.twoNoticeL.font = textFont;
    }else{
        _textFont = [UIFont systemFontOfSize:14];
    }
}

- (void)setTextColor:(UIColor *)textColor{
    if (textColor) {
        self.noticeL.textColor = textColor;
        self.twoNoticeL.textColor = textColor;
    }
}


- (void)setCanTouch:(BOOL)canTouch{
    _canTouch = canTouch;
    
    self.topLayerBtn.hidden = !canTouch;
    self.topLayerBtn.userInteractionEnabled = canTouch;
}

- (void)topLayerBtn_action:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(yt_scrollViewTouched:)]) {
        int idx = self.mainScrollV.contentOffset.x / ((int)self.bounds.size.width);
        [self.delegate yt_scrollViewTouched:idx];
    }
}




#pragma mark -

- (UIScrollView *)mainScrollV{
    if (!_mainScrollV) {
        _mainScrollV = [[UIScrollView alloc]initWithFrame:self.bounds];
        _mainScrollV.contentSize = CGSizeMake(_labelWidth * 2., 0);
        _mainScrollV.contentOffset = CGPointMake(_labelWidth, 0);
        
        _mainScrollV.backgroundColor = [UIColor orangeColor];
//        _mainScrollV.delegate = self;
        [self addSubview:_mainScrollV];
    }
    return _mainScrollV;
}

- (UILabel *)noticeL{
    if (!_noticeL) {
        _noticeL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _noticeL.textColor = [UIColor blackColor];
        _noticeL.font = [UIFont systemFontOfSize:14];
        [self.mainScrollV addSubview:_noticeL];
    }
    return _noticeL;
}

- (UILabel *)twoNoticeL{
    if (!_twoNoticeL) {
        _twoNoticeL = [[UILabel alloc]initWithFrame:CGRectMake(self.noticeL.frame.origin.x + self.noticeL.frame.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
        _twoNoticeL.textColor = [UIColor blackColor];
        _twoNoticeL.font = [UIFont systemFontOfSize:14];
        [self.mainScrollV addSubview:_twoNoticeL];
    }
    return _twoNoticeL;
}

- (UIButton *)topLayerBtn{
    if (!_topLayerBtn) {
        _topLayerBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _topLayerBtn.frame = self.bounds;
        _topLayerBtn.backgroundColor = [UIColor clearColor];
        _topLayerBtn.hidden = YES;
        _topLayerBtn.userInteractionEnabled = NO;
        [_topLayerBtn addTarget:self action:@selector(topLayerBtn_action:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_topLayerBtn];
        [self bringSubviewToFront:_topLayerBtn];
    }
    return _topLayerBtn;
}
@end
