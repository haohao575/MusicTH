//
//  playView.m
//  THMusic
//
//  Created by 童浩 on 15/8/27.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "playView.h"

@implementation playView
- (void)layoutSubviewPlayButtonTay:(NSInteger)tag{
    
    _playButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _playButton.frame = CGRectMake(self.frame.size.width / 2.0 - self.frame.size.height / 3.0 / 2.0, 10, self.frame.size.height / 3.0, self.frame.size.height / 3.0);
    _playButton.tag = tag;
    if (tag == 2000) {
        [_playButton setBackgroundImage:[UIImage imageNamed:@"player_btn_pause_normal.png"] forState:UIControlStateNormal];
    }else{
        [_playButton setBackgroundImage:[UIImage imageNamed:@"player_btn_play_highlight.png"] forState:UIControlStateNormal];
    }
    [_playButton addTarget:self action:@selector(playButtonSelector:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:_playButton];
    
    _UpButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _UpButton.frame = CGRectMake(10, _playButton.frame.origin.y, _playButton.frame.size.width, _playButton.frame.size.height);
    [_UpButton setBackgroundImage:[UIImage imageNamed:@"player_btn_pre_highlight.png"] forState:UIControlStateNormal];
    [self addSubview:_UpButton];
    
    _downButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _downButton.frame = CGRectMake(self.frame.size.width - _playButton.frame.size.width - 10, _playButton.frame.origin.y, _playButton.frame.size.width, _playButton.frame.size.height);
    [_downButton setBackgroundImage:[UIImage imageNamed:@"player_btn_next_normal.png"] forState:UIControlStateNormal];
    [self addSubview:_downButton];
    
    _playSlider = [[UISlider alloc]initWithFrame:CGRectMake(60, _playButton.frame.size.height + _playButton.frame.origin.y, self.frame.size.width - 120, _playButton.frame.size.height - 10)];
    [_playSlider setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb.png"] forState:UIControlStateNormal];
    _playSlider.thumbTintColor = [UIColor colorWithRed:38.0 / 256 green:187.0 / 256 blue:102.0 / 256 alpha:1];
    _playSlider.minimumTrackTintColor = [UIColor colorWithRed:38.0 / 256 green:187.0 / 256 blue:102.0 / 256 alpha:1];
    [self addSubview:_playSlider];
    
    _playTime = [[UILabel alloc]initWithFrame:CGRectMake(_UpButton.frame.origin.x, _playSlider.frame.origin.y, 50, _playSlider.frame.size.height)];
    _playTime.text = @"00:00";
    _playTime.font = [UIFont systemFontOfSize:14.0];
    _playTime.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_playTime];
    
    _sumTime = [[UILabel alloc]initWithFrame:CGRectMake(_downButton.frame.origin.x - 5, _playSlider.frame.origin.y, 50, _playSlider.frame.size.height)];
    _sumTime.text = @"04:00";
    _sumTime.font = [UIFont systemFontOfSize:14.0];
    _sumTime.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_sumTime];
    
    _volumeSlider = [[UISlider alloc]initWithFrame:CGRectMake(60, _playSlider.frame.size.height + _playSlider.frame.origin.y - 5, self.frame.size.width - 120, _playButton.frame.size.height)];
    [_volumeSlider setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb.png"] forState:UIControlStateNormal];
    _volumeSlider.thumbTintColor = [UIColor colorWithRed:38.0 / 256 green:187.0 / 256 blue:102.0 / 256 alpha:1];
    _volumeSlider.minimumTrackTintColor = [UIColor colorWithRed:38.0 / 256 green:187.0 / 256 blue:102.0 / 256 alpha:1];
    [self addSubview:_volumeSlider];
    
    UIImageView *littleImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"playing_volumn_slide_sound_little_icon.png"]];
    littleImageView.frame = CGRectMake(_playTime.frame.origin.x, _volumeSlider.frame.origin.y, 40, 40);
    
    [self addSubview:littleImageView];
    UIImageView *rightImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"playing_volumn_sound_icon.png"]];
    rightImageView.frame = CGRectMake(_sumTime.frame.origin.x, _volumeSlider.frame.origin.y, 40, 40);
    [self addSubview:rightImageView];
    
}
- (void)playButtonSelector:(UIButton *)button{
    
    if (button.tag == 2000) {
        button.tag = 1000;
        [button setBackgroundImage:[UIImage imageNamed:@"player_btn_play_highlight.png"] forState:UIControlStateNormal];
    }else{
        button.tag = 2000;
        [button setBackgroundImage:[UIImage imageNamed:@"player_btn_pause_normal.png"] forState:UIControlStateNormal];
    }
    
}
/*playing_volumn_slide_sound_little_icon@2x
  playing_volumn_sound_icon@2x
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
