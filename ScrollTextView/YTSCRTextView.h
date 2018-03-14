//
//  YTSCRTextView.h
//  AnyTest
//
//  Created by 木易 on 2018/3/3.
//  Copyright © 2018年 晓天. All rights reserved.
//
//  递归方式实现  文字的无缝左滚
//
//

#import <UIKit/UIKit.h>



//暂时只实现了从左往右，还没什么意义

///** 动画效果类型 */
//typedef enum : NSUInteger {
//    NoticeScrollType_RightToLeft,
//    NoticeScrollType_LeftToRight,
//    NoticeScrollType_BottomToTop
//} NoticeScrollType;


/** 可以点击的时候的代理 */
@protocol YTSCRTextViewDelegate <NSObject>

@optional
/** 可以点击的时候通过此方法回调 */
- (void)yt_scrollViewTouched:(NSInteger)idex;

@end


@interface YTSCRTextView : UIView

/** 要滚动的内容 */
@property (strong, nonatomic) NSString *scrollTextContent;
/** 可否点击
 *  可以点击的时候会通过代理回调点击位置
 */
@property (assign, nonatomic) BOOL canTouch;
/** 字体 */
@property (nonatomic, strong) UIFont *textFont;
/** 字体颜色 */
@property (nonatomic, strong) UIColor *textColor;

/** 不需要点击的时候可以不遵循 */
@property (nonatomic, weak) id <YTSCRTextViewDelegate> delegate;


/**
 * 初始化往左无缝滚动的View    字体大小 字体颜色 滚动的文本内容 是否立即开始滚动
 */
- (instancetype)initWithFrame:(CGRect)frame textFont:(UIFont *)font textColor:(UIColor *)color scrollTextContent:(NSString *)text animationFireScroll:(BOOL)isFire;

/** 开始滚动 */
- (void)startScroll;
/** 退出递归滚动 */
- (void)stopTextScroll;
/** 恢复滚动 */
- (void)restartTextScroll;

@end
