//
//  playView.h
//  THMusic
//
//  Created by 童浩 on 15/8/27.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface playView : UIView

@property (nonatomic, strong)UILabel *playTime;//播放时间

@property (nonatomic, strong)UILabel *sumTime; //总时间

@property (nonatomic, strong)UIButton *playButton; //播放/暂停

@property (nonatomic, strong)UIButton *UpButton; //上一首

@property (nonatomic, strong)UIButton *downButton; //下一首

@property (nonatomic, strong)UISlider *volumeSlider;//音量

@property (nonatomic, strong)UISlider *playSlider; //播放进度条

- (void)layoutSubviewPlayButtonTay:(NSInteger)tag;

@end
