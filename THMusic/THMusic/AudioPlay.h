//
//  AudioPlay.h
//  THMusic
//
//  Created by 童浩 on 15/8/28.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "MusicModel.h"
@interface AudioPlay : NSObject

@property (nonatomic, strong)AVPlayer *avPlayer;

@property (nonatomic, copy)void (^block)();

@property (nonatomic, copy)void (^blockss)();

@property (nonatomic, copy)void (^timerBlock)(CGFloat);

@property (nonatomic, copy)void (^timerSSBlock)(CGFloat);

@property (nonatomic, assign)BOOL isPlay;

@property (nonatomic, assign)MusicModel *playMusic;


+ (instancetype)solitaireAudioPlay;

- (void)planMP3URLString:(NSString *)MP3URLString;

- (void)play;   //播放
- (void)pause; //暂停
- (void)seekToTime:(float)time; //从指定时间播放

@end
