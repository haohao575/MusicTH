//
//  musicViewController.m
//  THMusic
//
//  Created by 童浩 on 15/8/27.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "musicViewController.h"
#import "MusicModel.h"
#import "playView.h"
#import "TH_URLRequest.h"
#import "musicLyricsTableViewCell.h"
#import "AudioPlay.h"

@interface musicViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)playView *playView;

@property (nonatomic, strong)UIImageView *imageView;

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *lyricsArray;

@property (nonatomic, strong)NSMutableArray *timeArray;

@property (nonatomic, strong)UILabel *labelName;

@property (nonatomic,assign)BOOL playSlie;

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, strong)UIButton *buttons;

@end

@implementation musicViewController
- (void)sideBar:(UIBarButtonItem *)barButton{
    self.block([AudioPlay solitaireAudioPlay].avPlayer.volume,_music,[AudioPlay solitaireAudioPlay].isPlay,self.playfashion,_MusicArray);
    [AudioPlay solitaireAudioPlay].block = nil;
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)sideBarss:(UIButton *)button{
    if (button.tag == 3000) {
        self.playfashion = 1;
        [_buttons setBackgroundImage:[UIImage imageNamed:@"iconfont-xunhuanbofang"] forState:UIControlStateNormal];
        button.tag = 4000;
    }else if(button.tag == 4000){
        self.playfashion = 2;
        [_buttons setBackgroundImage:[UIImage imageNamed:@"iconfont-suijibofang"] forState:UIControlStateNormal];
        button.tag = 5000;
    }else{
        [_buttons setBackgroundImage:[UIImage imageNamed:@"iconfont-danquxunhuan"] forState:UIControlStateNormal];
        self.playfashion = 0;
        button.tag = 3000;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self action:@selector(sideBar:) forControlEvents:UIControlEventTouchDown];
    [button setBackgroundImage:[UIImage imageNamed:@"miniplayer_btn_playlist_highlight.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = menuButton;
    
    _buttons = [UIButton buttonWithType:UIButtonTypeSystem];
    [_buttons addTarget:self action:@selector(sideBarss:) forControlEvents:UIControlEventTouchDown];
    switch (self.playfashion) {
        case circulate:
        {
            [_buttons setBackgroundImage:[UIImage imageNamed:@"iconfont-danquxunhuan"] forState:UIControlStateNormal];
            _buttons.tag = 3000;
            
        }
            break;
        case order:
        {
            [_buttons setBackgroundImage:[UIImage imageNamed:@"iconfont-xunhuanbofang"] forState:UIControlStateNormal];
            _buttons.tag = 4000;
        }
            break;
        case randoms:
        {
           [_buttons setBackgroundImage:[UIImage imageNamed:@"iconfont-suijibofang"] forState:UIControlStateNormal];
            _buttons.tag = 5000;
            
        }
            break;
        default:
            break;
    }
    
    _buttons.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *menuButtons = [[UIBarButtonItem alloc] initWithCustomView:_buttons];
    self.navigationItem.rightBarButtonItem = menuButtons;
    self.title = @"Music";
    _index = 0;
    [self NameMusic];
    [self playViews];
    [self ScrollViews];
    if (_music) {
        [self dataSelector];
    }
    [self musicPlay];
    __block musicViewController *men = self;
    [AudioPlay solitaireAudioPlay].block = ^(){
        switch (men.playfashion) {
            case circulate:{
                [men musicPlaycirculate];
            }
                break;
            case order:{
                [men downButtonSelector:nil];
            }
                break;
            case randoms:{
                NSUInteger inte = men.MusicArray.count;
                NSUInteger integer = arc4random() % inte;
                if (integer == [men.MusicArray indexOfObject:men.music]) {
                    if (integer == (men.MusicArray.count - 1)) {
                        integer = 0;
                    }else{
                        integer++;
                    }
                }
                men.music = men.MusicArray[integer];
                men.labelName.text = men.music.name;
                [TH_URLRequest TH_ImageView:men.imageView OccupyingImageName:@"iconfont-yinyue" ImageURLString:men.music.picUrl];
                men.playView.sumTime.text = [men timeStrFromTime:(men.music.duration / 1000)];
                [men dataSelector];
                [men musicPlay];
            }
                break;
            default:{
            
            }
                break;
        }
    };
    
}
- (void)NameMusic{
    self.view.backgroundColor = [UIColor whiteColor];
    _labelName = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, self.view.frame.size.width - 10, 40)];
    _labelName.text = _music.name;
    _labelName.textColor = [UIColor colorWithRed:38.0 / 256 green:187.0 / 256 blue:102.0 / 256 alpha:1];
    _labelName.font = [UIFont systemFontOfSize:15.0];
    _labelName.numberOfLines = 0;
    _labelName.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_labelName];
}
- (void)musicPlaycirculate{
    _playView.playSlider.maximumValue = self.music.duration / 1000;
    [AudioPlay solitaireAudioPlay].playMusic = _music;
    [[AudioPlay solitaireAudioPlay] planMP3URLString:_music.mp3Url];
}
- (void)musicPlay{
    if ([_music isEqual:[AudioPlay solitaireAudioPlay].playMusic]) {
        if ([AudioPlay solitaireAudioPlay].isPlay == YES) {
            _playView.playButton.tag = 2000;
            [_playView.playButton setBackgroundImage:[UIImage imageNamed:@"player_btn_pause_normal.png"] forState:UIControlStateNormal];
        }else{
            _playView.playButton.tag = 1000;
            [_playView.playButton setBackgroundImage:[UIImage imageNamed:@"player_btn_play_highlight.png"] forState:UIControlStateNormal];
        }
        return;
    }
    [self musicPlaycirculate];
}
- (void)dataSelector{
    _lyricsArray = [NSMutableArray array];
    _timeArray = [NSMutableArray array];
    if (_lyricsArray.count != 0) {
        [_lyricsArray removeAllObjects];
    }
    if (_timeArray.count != 0) {
        [_timeArray removeAllObjects];
    }
    NSArray *array = [_music.lyric componentsSeparatedByString:@"\n"];
    for (NSString *str in array) {
        NSArray *ayyays = [str componentsSeparatedByString:@"]"];
        NSString *string = ayyays[0];
        NSArray *array1 = [string componentsSeparatedByString:@"["];
        if (array1.count > 1) {
            [_timeArray addObject: array1[1]];
        }
        if (ayyays.count <= 1) {
            [_lyricsArray addObject:@" "];
        }else{
            [_lyricsArray addObject:ayyays[1]];
        }
    }
    NSString *str = _lyricsArray[_lyricsArray.count - 1];
    if ([str isEqualToString:@" "]) {
        [_lyricsArray removeObjectAtIndex:_lyricsArray.count - 1];
    }
    [_tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _lyricsArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellString = @"musicLyricsTableViewCell";
    musicLyricsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (!cell) {
        cell = [[musicLyricsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lyricsLabel.text = _lyricsArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *view = [[UILabel alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    view.font = [UIFont systemFontOfSize:13];
    view.textAlignment = NSTextAlignmentCenter;
    view.textColor = [UIColor colorWithRed:38.0 / 256 green:187.0 / 256 blue:102.0 / 256 alpha:1];
    view.text = @"Lyrics";
    return view;
}
//UIScrollView
- (void)ScrollViews{
    _imageView = [[UIImageView alloc]init];
    [TH_URLRequest TH_ImageView:_imageView OccupyingImageName:@"iconfont-yinyue" ImageURLString:_music.picUrl];
    CGFloat height = 0;
    _imageView.frame = CGRectMake(0, 0, self.view.frame.size.width - 10,  self.view.frame.size.width - 10);
    _imageView.layer.masksToBounds=YES;
    _imageView.layer.cornerRadius = (self.view.frame.size.width - 10) / 2.0;
    if (kBounds.size.height > 480 && kBounds.size.height <= 570) {
        height = 14;
    }else if(kBounds.size.height > 570 && kBounds.size.height <= 720){
        height = 58;
    }else if(kBounds.size.height > 720){
        height = 88;
    }else{
        height = -24;
        _imageView.frame = CGRectMake(0, 0, self.view.frame.size.width + height - 20 - 10,  self.view.frame.size.width + height - 20 - 10);
        _imageView.layer.cornerRadius = (self.view.frame.size.width + height - 20 - 10) / 2.0;
    }
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width,self.view.frame.size.width + height - 20)];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0,38,kBounds.size.width,2)];
    view1.backgroundColor = [UIColor colorWithRed:38.0 / 256 green:187.0 / 256 blue:102.0 / 256 alpha:1];
    [self.view addSubview:view1];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 2,scrollView.frame.size.height);
    scrollView.pagingEnabled = YES;
    _imageView.center = CGPointMake(self.view.frame.size.width / 2.0, scrollView.frame.size.height / 2.0);
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    scrollView.showsHorizontalScrollIndicator = NO;
    [scrollView addSubview:_imageView];
    [scrollView addSubview:_tableView];
    UIView *viewt = [[UIView alloc]initWithFrame:CGRectMake(scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
    viewt.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:viewt];
    [self.view addSubview:scrollView];
    
}
- (void)playViews{
    CGFloat height = 0;
    if (kBounds.size.height > 480) {
        height = 150;
    }else{
        height = 100;
    }
    _playView = [[playView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - height - 64, self.view.frame.size.width, height)];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _playView.frame.origin.y, _playView.frame.size.width, 2)];
    view.backgroundColor = [UIColor colorWithRed:38.0 / 256 green:187.0 / 256 blue:102.0 / 256 alpha:1];
    //tag ＝ 2000为播放状态
    [_playView layoutSubviewPlayButtonTay:1000];
    if (_isPlay == YES) {
        _playView.playButton.tag = 2000;
        [_playView.playButton setBackgroundImage:[UIImage imageNamed:@"player_btn_pause_normal.png"] forState:UIControlStateNormal];
    }else{
        _playView.playButton.tag = 1000;
        [_playView.playButton setBackgroundImage:[UIImage imageNamed:@"player_btn_play_highlight.png"] forState:UIControlStateNormal];
    }
    _playView.playSlider.maximumValue = self.music.duration / 1000;
    _playView.playSlider.value = _Slidervalue;
    _playView.sumTime.text = [self timeStrFromTime:(self.music.duration / 1000)];
    _playView.sumTime.text = _sumTime;
    _playView.playTime.text = _playTime;
    
    [_playView.playSlider addTarget:self action:@selector(playSliderSelector:) forControlEvents:UIControlEventTouchUpOutside];
    
    [_playView.playSlider addTarget:self action:@selector(playSliderSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    [_playView.playSlider addTarget:self action:@selector(playSliders:) forControlEvents:UIControlEventValueChanged];
    
    [_playView.playSlider addTarget:self action:@selector(boolPlaySliderSelector:) forControlEvents:UIControlEventTouchDown];
    self.playSlie = YES;
    __block musicViewController *men = self;
    [AudioPlay solitaireAudioPlay].timerBlock = ^(CGFloat timerFloat){
        // 更新进度条
        if (men.playSlie == YES) {
            men.playView.playSlider.value = timerFloat;
            men.playView.playTime.text = [men timeStrFromTime:timerFloat];
            men.playView.sumTime.text = [men timeStrFromTime:(men.music.duration / 1000) - timerFloat];
        }
        // 图片进行旋转
        if ([AudioPlay solitaireAudioPlay].isPlay == YES) {
            men.imageView.transform = CGAffineTransformRotate(men.imageView.transform, - M_PI / 180);
        }
        // 播放歌词
        NSInteger index = [men lyricPathTimer:timerFloat];
        // 组拼indexPath
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [men.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:
            UITableViewScrollPositionMiddle];
        for (UITableViewCell *cellas in [men.tableView visibleCells]) {
            musicLyricsTableViewCell * cell = (musicLyricsTableViewCell *)cellas;
            cell.lyricsLabel.textColor = [UIColor grayColor];
        }
        musicLyricsTableViewCell * cell = (musicLyricsTableViewCell *)[men.tableView cellForRowAtIndexPath:indexPath];
        cell.lyricsLabel.textColor = [UIColor colorWithRed:38.0 / 256 green:187.0 / 256 blue:102.0 / 256 alpha:1];
    };
    [_playView.playButton addTarget:self action:@selector(playpause:) forControlEvents:UIControlEventTouchDown];
    [_playView.UpButton addTarget:self action:@selector(UpButtonSelector:) forControlEvents:UIControlEventTouchDown];
    [_playView.downButton addTarget:self action:@selector(downButtonSelector:) forControlEvents:UIControlEventTouchDown];
    //    avPlayer.volum;
    _playView.volumeSlider.value = _volume;
    _playView.volumeSlider.maximumValue = 1.0;
    [_playView.volumeSlider addTarget:self action:@selector(avPlayerVolume:) forControlEvents:UIControlEventTouchUpOutside|UIControlEventTouchUpInside];
    
    [self.view addSubview:_playView];
    [self.view addSubview:view];
}
- (NSArray *)timeArray{
    // 将时间字符串转为float类型
    NSMutableArray *allLyric = [NSMutableArray array];
    for (NSString *str in _timeArray) {
        NSArray *timeArray = [str componentsSeparatedByString:@":"];
        // 算出总时间
        float totalTime = [timeArray.firstObject intValue] * 60 + [timeArray.lastObject floatValue];
        [allLyric addObject:[NSString stringWithFormat:@"%lf",totalTime]];
    }
    return allLyric;
}
- (NSInteger)lyricPathTimer:(CGFloat)timer{
    for (int i = 0; i < _timeArray.count; i ++) {
        NSString *str = _timeArray[i];
        NSArray *array = [str componentsSeparatedByString:@":"];
        CGFloat timerfloat = [array[0] integerValue] * 60 + [array[1] doubleValue];
        if (timer < timerfloat) {
            if (i == 0) {
                return 0;
            }
            return i - 1;
        }
    }
    return _timeArray.count - 1;
}

- (NSInteger)indexOfLyricWithTime:(float)time
{
    NSArray *array = [self timeArray];
    for (int i = 0; i < array.count; i++) {
        NSString * items = array[i];
        if ([items doubleValue] > time) {
            _index = ((i - 1 > 0) ? i - 1 : 0);
            break;
        }
    }
    return _index;
}
- (void)boolPlaySliderSelector:(UISlider *)slider{
    self.playSlie = NO;
}
- (void)playSliderSelector:(UISlider *)slider{
    self.playSlie = YES;
    [[AudioPlay solitaireAudioPlay] seekToTime:slider.value];
}
- (void)playSliders:(UISlider *)slider{
    self.playView.playTime.text = [self timeStrFromTime:slider.value];
    self.playView.sumTime.text = [self timeStrFromTime:(self.music.duration / 1000) - slider.value];
}
- (void)avPlayerVolume:(UISlider *)slider{
    [AudioPlay solitaireAudioPlay].avPlayer.volume = slider.value;
}
- (void)playpause:(UIButton *)button{
    if (button.tag == 1000) {
        [[AudioPlay solitaireAudioPlay] pause];
    }else{
        [[AudioPlay solitaireAudioPlay] play];
    }
}
//下一首
- (void)downButtonSelector:(UIButton *)button{
    NSUInteger integer = [_MusicArray indexOfObject:_music];
    if (integer == (_MusicArray.count - 1)) {
        _music = _MusicArray[0];
    }else{
        _music = _MusicArray[integer + 1];
    }
    _labelName.text = _music.name;
    [TH_URLRequest TH_ImageView:_imageView OccupyingImageName:@"iconfont-yinyue" ImageURLString:_music.picUrl];
    _playView.sumTime.text = [self timeStrFromTime:(self.music.duration / 1000)];
    [self dataSelector];
    [self musicPlay];
}
//上一首
- (void)UpButtonSelector:(UIButton *)button{
    NSUInteger integer = [_MusicArray indexOfObject:_music];
    if (integer == 0) {
        _music = _MusicArray[_MusicArray.count - 1];
    }else{
        _music = _MusicArray[integer - 1];
    }
    _labelName.text = _music.name;
    [TH_URLRequest TH_ImageView:_imageView OccupyingImageName:@"iconfont-yinyue" ImageURLString:_music.picUrl];
    _playView.sumTime.text = [self timeStrFromTime:(self.music.duration / 1000)];
    [self dataSelector];
    [self musicPlay];
    
}
- (NSString *)timeStrFromTime:(float)time
{
    int minutes = time / 60;
    int second = (int)time % 60;
    return [NSString stringWithFormat:@"%02d:%02d", minutes, second];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
