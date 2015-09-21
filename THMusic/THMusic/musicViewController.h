//
//  musicViewController.h
//  THMusic
//
//  Created by 童浩 on 15/8/27.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MusicModel;
@interface musicViewController : UIViewController

@property (nonatomic, strong)MusicModel *music;

@property (nonatomic, strong)NSArray *MusicArray;

@property (nonatomic, assign)CGFloat volume;

@property (nonatomic, assign)CGFloat Slidervalue;

@property (nonatomic, strong)NSString *playTime;

@property (nonatomic, strong)NSString *sumTime;

@property (nonatomic, assign)BOOL isPlay;

@property (nonatomic, assign)NSInteger playfashion;

@property (nonatomic, copy)void (^block)(CGFloat Volume,MusicModel *music,BOOL isPlay,NSInteger playInte,NSArray * musicArray);

@end
