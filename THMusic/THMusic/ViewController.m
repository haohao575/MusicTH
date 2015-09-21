//
//  ViewController.m
//  THMusic
//
//  Created by 童浩 on 15/8/26.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "ViewController.h"
#import "MusicModel.h"
#import "musicListTableViewCell.h"
#import "TH_URLRequest.h"
#import "musicViewController.h"
#import "playView.h"
#import "AudioPlay.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *musicArray;

@property (nonatomic, strong)playView *playViews;

@property (nonatomic, strong)MusicModel *music;

@property (nonatomic, strong)UIImageView *imageView;

@property (nonatomic, strong)UILabel *musicLabel;

@property (nonatomic, assign)BOOL playSlie;

@property (nonatomic, assign)NSInteger playfashion;

@property (nonatomic, strong)UIButton *buttons;

@end

@implementation ViewController
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
- (void)rightBarButton:(NSInteger)playInte{
    self.playfashion = playInte;
    switch (playInte) {
        case 0:
        {
            [_buttons setBackgroundImage:[UIImage imageNamed:@"iconfont-danquxunhuan"] forState:UIControlStateNormal];
            _buttons.tag = 3000;
            
        }
            break;
        case 1:
        {
            [_buttons setBackgroundImage:[UIImage imageNamed:@"iconfont-xunhuanbofang"] forState:UIControlStateNormal];
            _buttons.tag = 4000;
        }
            break;
        case 2:
        {
            [_buttons setBackgroundImage:[UIImage imageNamed:@"iconfont-suijibofang"] forState:UIControlStateNormal];
            _buttons.tag = 5000;
            
        }
            break;
        default:
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"TH_Music" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:38.0 / 256 green:187.0 / 256 blue:102.0 / 256 alpha:1] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 80, 30);
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = menuButton;
    
    _buttons = [UIButton buttonWithType:UIButtonTypeSystem];
    [_buttons addTarget:self action:@selector(sideBarss:) forControlEvents:UIControlEventTouchDown];
    [_buttons setBackgroundImage:[UIImage imageNamed:@"iconfont-xunhuanbofang"] forState:UIControlStateNormal];
    _buttons.tag = 4000;
    self.playfashion = 1;
    _buttons.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *menuButtons = [[UIBarButtonItem alloc] initWithCustomView:_buttons];
    self.navigationItem.rightBarButtonItem = menuButtons;
    
    self.title = @"Music List";
    _playSlie = YES;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:kOccupyingImageName]];
    imageView.frame = self.view.frame;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height / 2.0 - 60, self.view.frame.size.width, 80)];
    label.text = @"正在加载歌曲列表,请稍后...";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:26];
    [self.view addSubview:imageView];
    [self.view addSubview:label];
    _musicArray = [NSMutableArray array];
    dispatch_queue_t myQueue = dispatch_queue_create("com.th.music.", DISPATCH_QUEUE_SERIAL);
    dispatch_async(myQueue, ^{
     NSArray *array = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:kMusicList]];
        for (NSDictionary *dictionary in array) {
            MusicModel *music = [[MusicModel alloc]init];
            [music setValuesForKeysWithDictionary:dictionary];
            [_musicArray addObject:music];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            _tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - 100 - 64)];
            _tableView.showsVerticalScrollIndicator = NO;
            [self.view addSubview:_tableView];
            [self playViewsas];
            self.tableView.delegate = self;
            self.tableView.dataSource = self;
            [self.tableView reloadData];
            [imageView removeFromSuperview];
            self.navigationController.navigationBar.translucent = NO;
            [self.navigationController setNavigationBarHidden:NO animated:NO];
        });
    });
    __block ViewController *men = self;
    [AudioPlay solitaireAudioPlay].blockss = ^(){
        switch (men.playfashion) {
            case circulate:{
                [men musicPlaycirculate];
            }
                break;
            case order:{
                [men downButtonSelectoraaa:nil];
            }
                break;
            case randoms:{
                NSUInteger inte = men.musicArray.count;
                NSUInteger integer = arc4random() % inte;
                if (integer == [men.musicArray indexOfObject:men.music]) {
                    if (integer == (men.musicArray.count - 1)) {
                        integer = 0;
                    }else{
                        integer++;
                    }
                }
                men.music = men.musicArray[integer];
                [men musicPlay];
            }
                break;
            default:{
                
            }
                break;
        }
    };
}
#pragma mark 图片点击方法
- (void)buttonSelector:(UIButton *)button{
    musicViewController *musicVC = [[musicViewController alloc]init];
    musicVC.MusicArray = _musicArray;
    musicVC.playfashion = self.playfashion;
    musicVC.volume = self.playViews.volumeSlider.value;
    musicVC.Slidervalue = _playViews.playSlider.value;
    musicVC.playTime = _playViews.playTime.text;
    musicVC.sumTime = _playViews.sumTime.text;
    musicVC.isPlay = [AudioPlay solitaireAudioPlay].isPlay;
    if (!_music) {
        musicVC.music = _musicArray[0];
    }else{
        musicVC.music = _music;
    }
    self.playViews.playSlider.maximumValue = musicVC.music.duration / 1000;
    __block ViewController *men = self;
    musicVC.block = ^(CGFloat Volume,MusicModel *music,BOOL isplay,NSInteger playInte,NSArray *array){
        [self rightBarButton:playInte];
        men.playViews.volumeSlider.value = Volume;
        _music = [[MusicModel alloc]init];
        _music = music;
        men.musicLabel.text = music.name;
        [TH_URLRequest TH_ImageView:men.imageView OccupyingImageName:@"iconfont-yinyue" ImageURLString:music.picUrl];
        if (isplay == YES) {
            men.playViews.playButton.tag = 2000;
            [men.playViews.playButton setBackgroundImage:[UIImage imageNamed:@"player_btn_pause_normal.png"] forState:UIControlStateNormal];
        }else{
            men.playViews.playButton.tag = 1000;
            [men.playViews.playButton setBackgroundImage:[UIImage imageNamed:@"player_btn_play_highlight.png"] forState:UIControlStateNormal];
        }
    };
    [self.navigationController pushViewController:musicVC animated:YES];
}
#pragma mark 底下播放View
- (void)playViewsas{
    
    CGFloat height = 100;
    self.playViews = [[playView alloc]initWithFrame:CGRectMake(100, self.view.frame.size.height - 64 - height, self.view.frame.size.width - 100, height)];
    //tag ＝ 2000为播放状态
    [self.playViews layoutSubviewPlayButtonTay:1000];
    [self.view addSubview:self.playViews];
    
    [self.playViews.UpButton addTarget:self action:@selector(UpButtonSelector:) forControlEvents:UIControlEventTouchDown];
    [self.playViews.downButton addTarget:self action:@selector(downButtonSelectoraaa:) forControlEvents:UIControlEventTouchDown];
    [self.playViews.playButton addTarget:self action:@selector(playpause:) forControlEvents:UIControlEventTouchDown];
    
    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"112740250791f28f39l.jpg"]];
    _imageView.layer.masksToBounds=YES;
    _imageView.layer.cornerRadius = 30;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.playViews.frame.origin.y, self.view.frame.size.width, 2)];
    view.backgroundColor = [UIColor blackColor];
    _imageView.frame = CGRectMake(20, view.frame.origin.y + 30, 60, 60);
    _musicLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, view.frame.origin.y, 90, 30)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = _imageView.frame;
    [button addTarget:self action:@selector(buttonSelector:) forControlEvents:UIControlEventTouchDown];
    _musicLabel.text = @"Music";
    _musicLabel.textAlignment = NSTextAlignmentCenter;
    _musicLabel.font = [UIFont systemFontOfSize:12.0];
    _musicLabel.numberOfLines = 0;
    self.playViews.playSlider.maximumValue = self.music.duration / 1000;
    self.playViews.sumTime.text = [self timeStrFromTime:(self.music.duration / 1000)];
    [self.playViews.playSlider addTarget:self action:@selector(playSliderSelector:) forControlEvents:UIControlEventTouchUpOutside];
    [self.playViews.playSlider addTarget:self action:@selector(playSliderSelector:) forControlEvents:UIControlEventTouchUpInside];
    [self.playViews.playSlider addTarget:self action:@selector(playSliders:) forControlEvents:UIControlEventValueChanged];
    [self.playViews.playSlider addTarget:self action:@selector(boolPlaySliderSelector:) forControlEvents:UIControlEventTouchDown];
    __block ViewController *men = self;
    [AudioPlay solitaireAudioPlay].timerSSBlock = ^(CGFloat timerFloat){
        // 更新进度条
        if (men.playSlie == YES) {
            men.playViews.playSlider.value = timerFloat;
            men.playViews.playTime.text = [men timeStrFromTime:timerFloat];
            men.playViews.sumTime.text = [men timeStrFromTime:(men.music.duration / 1000) - timerFloat];
        }
        // 图片进行旋转
        if ([AudioPlay solitaireAudioPlay].isPlay == YES) {
            men.imageView.transform = CGAffineTransformRotate(men.imageView.transform, - M_PI / 180);
        }
        
    };
    self.playViews.volumeSlider.value = 1.0;
    self.playViews.volumeSlider.maximumValue = 1.0;
    [self.playViews.volumeSlider addTarget:self action:@selector(avPlayerVolume:) forControlEvents:UIControlEventTouchUpOutside|UIControlEventTouchUpInside];
    
    [self.view addSubview:_musicLabel];
    [self.view addSubview:_imageView];
    [self.view addSubview:view];
    [self.view addSubview:button];
}
- (void)boolPlaySliderSelector:(UISlider *)slider{
    self.playSlie = NO;
}
- (void)playSliderSelector:(UISlider *)slider{
    self.playSlie = YES;
    [[AudioPlay solitaireAudioPlay] seekToTime:slider.value];
}
- (void)playSliders:(UISlider *)slider{
    self.playViews.playTime.text = [self timeStrFromTime:slider.value];
    self.playViews.sumTime.text = [self timeStrFromTime:(self.music.duration / 1000) - slider.value];
}
- (void)avPlayerVolume:(UISlider *)slider{
    [AudioPlay solitaireAudioPlay].avPlayer.volume = slider.value;
}



- (void)playpause:(UIButton *)button{
    if (!_music) {
        [self downButtonSelectoraaa:nil];
    }else{
        if (button.tag == 1000) {
            [[AudioPlay solitaireAudioPlay] pause];
        }else{
            [[AudioPlay solitaireAudioPlay] play];
        }
    }
}
//下一首
- (void)downButtonSelectoraaa:(UIButton *)button{
    NSUInteger integer = 0;
    if (!_music) {
        integer = -1;
    }else{
        integer = [_musicArray indexOfObject:_music];
        _music = nil;
    }
    if (integer == (_musicArray.count - 1)) {
        _music = _musicArray[0];
    }else{
        _music = _musicArray[integer + 1];
    }
    [self musicPlay];
}
- (void)musicPlaycirculate{
    self.playViews.playSlider.maximumValue = self.music.duration / 1000;
    [AudioPlay solitaireAudioPlay].playMusic = _music;
    [[AudioPlay solitaireAudioPlay] planMP3URLString:_music.mp3Url];
    self.musicLabel.text = self.music.name;
    [TH_URLRequest TH_ImageView:self.imageView OccupyingImageName:@"iconfont-yinyue" ImageURLString:self.music.picUrl];
    self.playViews.sumTime.text = [self timeStrFromTime:(self.music.duration / 1000)];
}
- (void)musicPlay{
    if ([_music isEqual:[AudioPlay solitaireAudioPlay].playMusic]) {
        return;
    }
    [self.playViews.playButton setBackgroundImage:[UIImage imageNamed:@"player_btn_pause_normal.png"] forState:UIControlStateNormal];
    self.playViews.playButton.tag = 2000;
    
    self.playViews.playSlider.maximumValue = _music.duration / 1000;
    [AudioPlay solitaireAudioPlay].playMusic = _music;
    [[AudioPlay solitaireAudioPlay] planMP3URLString:_music.mp3Url];
    self.musicLabel.text = _music.name;
    [TH_URLRequest TH_ImageView:self.imageView OccupyingImageName:@"iconfont-yinyue" ImageURLString:_music.picUrl];
    self.playViews.sumTime.text = [self timeStrFromTime:(_music.duration / 1000)];
}
//上一首
- (void)UpButtonSelector:(UIButton *)button{
    NSUInteger integer = [_musicArray indexOfObject:_music];
    if (!_music) {
        integer = 1;
    }
    if (integer == 0) {
        _music = _musicArray[_musicArray.count - 1];
    }else{
        _music = _musicArray[integer - 1];
    }
    _musicLabel.text = _music.name;
    [TH_URLRequest TH_ImageView:_imageView OccupyingImageName:@"iconfont-yinyue" ImageURLString:_music.picUrl];
    self.playViews.sumTime.text = [self timeStrFromTime:(self.music.duration / 1000)];
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
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _musicArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellString = @"TableCell";
    musicListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (!cell) {
        cell = [[musicListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    MusicModel *music = _musicArray[indexPath.section];
    
    cell.music = music;
    
    [TH_URLRequest TH_ImageView:cell.musicImageView OccupyingImageName:kOccupyingImageName ImageURLString:music.picUrl indexPath:indexPath tableView:tableView];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kBounds.size.width / 3.0 + 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == _musicArray.count - 1) {
        return 10;
    }
    return 0.0001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor blackColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor blackColor];
    return view;
}
#pragma mark table点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MusicModel *music = _musicArray[indexPath.section];
    musicViewController *musicVC = [[musicViewController alloc]init];
    musicVC.music = music;
    musicVC.isPlay = YES;
    
    musicVC.playfashion = self.playfashion;
    
    musicVC.volume = self.playViews.volumeSlider.value;
    musicVC.MusicArray = _musicArray;
    musicVC.Slidervalue = _playViews.playSlider.value;
    musicVC.playTime = _playViews.playTime.text;
    musicVC.sumTime = _playViews.sumTime.text;
    self.playViews.playSlider.maximumValue = music.duration / 1000;
    __block ViewController *men = self;
    musicVC.block = ^(CGFloat Volume,MusicModel *music,BOOL isplay,NSInteger playInte,NSArray *array){
        [self rightBarButton:playInte];
        men.playViews.volumeSlider.value = Volume;
        _music = music;
        men.musicLabel.text = music.name;
        [TH_URLRequest TH_ImageView:men.imageView OccupyingImageName:@"iconfont-yinyue" ImageURLString:music.picUrl];
        if (isplay == YES) {
            men.playViews.playButton.tag = 2000;
            [men.playViews.playButton setBackgroundImage:[UIImage imageNamed:@"player_btn_pause_normal.png"] forState:UIControlStateNormal];
        }else{
            men.playViews.playButton.tag = 1000;
            [men.playViews.playButton setBackgroundImage:[UIImage imageNamed:@"player_btn_play_highlight.png"] forState:UIControlStateNormal];
        }
    };
    [self.navigationController pushViewController:musicVC animated:YES];
}

@end
