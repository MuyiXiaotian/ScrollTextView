//
//  ViewController.m
//  ScrollTextView
//
//  Created by 木易 on 2018/3/14.
//  Copyright © 2018年 XXXX. All rights reserved.
//

#import "ViewController.h"
#import "YTSCRTextView.h"


#define SCREEN_WIDTH  [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height

@interface ViewController ()<YTSCRTextViewDelegate>

@property (nonatomic, strong) YTSCRTextView *scrollTextView;

@end

@implementation ViewController{
    NSInteger _touchedCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _touchedCount = 0;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, SCREEN_WIDTH - 40, 44)];
    [btn setTitle:@"滚？|| 不滚？" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    btn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(stopScroll) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.scrollTextView.scrollTextContent = @"🎈每一次旅行，只需要几张照片就可以自动生成无数视频，😜一旦使用上就会抛弃那些繁杂的视频制作APP。😀";
    
}

- (void)stopScroll{
    if (0 == _touchedCount%2) {
        [self.scrollTextView stopTextScroll];
    }else{
        [self.scrollTextView restartTextScroll];
    }
    
    _touchedCount ++;
}

//跑马灯被点击的代理
- (void)yt_scrollViewTouched:(NSInteger)idex{
    NSLog(@"那啥啥点击了   %ld",idex);
}

- (void)dealloc{
    NSLog(@"擦，老子的跑马灯被释放了");
}

#pragma mark -
- (YTSCRTextView *)scrollTextView{
    if (!_scrollTextView) {
        _scrollTextView = [[YTSCRTextView alloc]initWithFrame:CGRectMake(40, 300, SCREEN_WIDTH - 80., 30) textFont:[UIFont systemFontOfSize:17] textColor:[UIColor colorWithRed:222 green:222 blue:222 alpha:1] scrollTextContent:nil animationFireScroll:YES];
        _scrollTextView.backgroundColor = [UIColor clearColor];
        _scrollTextView.delegate = self;
        _scrollTextView.canTouch = YES;
        [self.view addSubview:_scrollTextView];
    }
    return _scrollTextView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
