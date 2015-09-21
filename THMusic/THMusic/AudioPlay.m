//
//  AudioPlay.m
//  THMusic
//
//  Created by 童浩 on 15/8/28.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "AudioPlay.h"
@interface AudioPlay()

@property (nonatomic, strong)NSTimer *timer;

@property (nonatomic, strong)NSTimer *timer1;

@end

@implementation AudioPlay
+ (instancetype)solitaireAudioPlay{
    static AudioPlay *defaultManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultManager = [[AudioPlay alloc] init];
    });
    return defaultManager;
}
- (instancetype)init{
    if (self = [super init]) {
        // 注册通知，当音乐播放完成的时候，执行方法
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timeEndAction:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}

- (void)timeEndAction:(id)sender{
    if ([AudioPlay solitaireAudioPlay].block) {
        [AudioPlay solitaireAudioPlay].block();
        return;
    }
    if (self.blockss) {
        self.blockss();
    }
}
- (void)planMP3URLString:(NSString *)MP3URLString{
 
    if (!MP3URLString) {
        return;
    }
    if (self.avPlayer.currentItem) {
        [self.avPlayer.currentItem removeObserver:self forKeyPath:@"status"];
    }
    AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:MP3URLString]];
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_avPlayer replaceCurrentItemWithPlayerItem:playerItem];
}
#pragma mark - 内部方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        // 获取当前状态
        AVPlayerItemStatus status = [change[@"new"] integerValue];
        switch (status) {
            case AVPlayerItemStatusReadyToPlay: { // 准备好了，可以播放，直接播放
                [self play];
                break;
            }
            case AVPlayerItemStatusFailed: {
                NSLog(@"错误");
                break;
            }
            case AVPlayerItemStatusUnknown: {
                NSLog(@"未知");
                break;
            }
            default:
                break;
        }
    }
}
- (void)play{
    [AudioPlay solitaireAudioPlay].isPlay = YES;
    [self.avPlayer play];
    if (self.timer) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    if (self.timer1) {
        return;
    }
    self.timer1 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playTimerass:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer1 forMode:NSRunLoopCommonModes];
    
}
- (void)playTimerass:(NSTimer *)timer{
    CGFloat timerFloat = 1.0 * self.avPlayer.currentTime.value / self.avPlayer.currentTime.timescale;
    if (self.timerSSBlock) {
        self.timerSSBlock(timerFloat);
    }
}
- (void)playTimer:(NSTimer *)timer{
    CGFloat timerFloat = 1.0 * self.avPlayer.currentTime.value / self.avPlayer.currentTime.timescale;
    if (self.timerBlock) {
        self.timerBlock(timerFloat);
    }
}
- (void)pause{
    [AudioPlay solitaireAudioPlay].isPlay = NO;
    [self.avPlayer pause];
    if (self.timer) {
        [self.timer invalidate];        // 取消定时器
        self.timer = nil;
    }
    if (self.timer1) {
        [self.timer1 invalidate];        // 取消定时器
        self.timer1 = nil;
    }
}
- (void)seekToTime:(float)time
{
    [self.avPlayer seekToTime:CMTimeMakeWithSeconds(time, self.avPlayer.currentTime.timescale) completionHandler:^(BOOL finished) {
        if (finished) {
            if ([AudioPlay solitaireAudioPlay].isPlay == YES) {
                [self play];
            }else{
                [self pause];
            }
        }
    }];
}

- (AVPlayer *)avPlayer{
    if (!_avPlayer) {
        self.avPlayer = [AVPlayer new];
        self.avPlayer.volume = 1.0;
    }
    return _avPlayer;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:AVPlayerItemDidPlayToEndTimeNotification];
}
@end