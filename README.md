# ScrollTextView
类似Android跑马灯功能。可自定义能否点击、字体、颜色、滚动速度等。
并且会会根据contentsize与自身frame判断需不需要滚动。

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

