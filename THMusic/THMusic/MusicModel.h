//
//  MusicModel.h
//  THMusic
//
//  Created by 童浩 on 15/8/27.
//  Copyright(c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {
 album = "Furious 7 (Original Motion Picture Soundtrack)";
 "artists_name" = "Wiz Khalifa";
 blurPicUrl = "http://music.163.com/api/img/blur/7731765766799133";
 duration = 229000;
 id = 30953009;
 lyric = "[00:00.00] \U4f5c\U66f2 : Wiz Khalifa\n[00:01.00] \U4f5c\U8bcd : Wiz Khalifa\n[00:10.440]It's been a long day without you my friend\n[00:17.400]And I'll tell you all about it when I see you again\n[00:23.200]We've come a long way from where we began\n[00:29.080]Oh I'll tell you all about it when I see you again\n[00:35.100]When I see you again\n[00:39.920]Damn who knew all the planes we flew\n[00:42.900]Good things we've been through\n[00:44.610]That I'll be standing right here\n[00:46.330]Talking to you about another path\n[00:48.750]I know we loved to hit the road and laugh\n[00:51.020]But something told me that it wouldn't last\n[00:53.390]Had to switch up look at things different see the bigger picture\n[00:57.100]Those were the days hard work forever pays\n[01:00.290]Now I see you in a better place\n[01:05.020]How could we not talk about family when family's all that we got?\n[01:08.660]Everything I went through you were standing there by my side\n[01:11.560]And now you gonna be with me for the last ride\n[01:13.760]It's been a long day without you my friend\n[01:20.330]And I'll tell you all about it when I see you again\n[01:26.200]We've come a long way from where we began\n[01:32.150]Oh I'll tell you all about it when I see you again\n[01:38.170]When I see you again\n[01:56.230]First you both go out your way\n[01:57.750]And the vibe is feeling strong and what's small turn to a friendship\n[02:01.540]a friendship turn into a bond and\n[02:03.390]that bond will never be broke and the love will never get lost\n[02:08.230]And when brotherhood come first then the line\n[02:10.310]Will never be crossed established it on our own\n[02:12.730]When that line had to be drawn and that line is what we reach\n[02:15.330]So remember me when I'm gone\n[02:19.960]How could we not talk about family when family's all that we got?\n[02:23.600]Everything I went through you were standing there by my side\n[02:26.550]And now you gonna be with me for the last ride\n[02:29.080]Let the light guide your way\n[02:32.080]Hold every memory as you go\n[02:38.140]And every road you take will always lead you home\n[02:49.190]Hoo\n[02:52.650]It's been a long day without you my friend\n[02:59.320]And I'll tell you all about it when I see you again\n[03:05.220]We've come a long way from where we began\n[03:11.130]Oh I'll tell you all about it when I see you again\n[03:16.980]When I see you again\n[03:22.660]Again\n[03:29.050]When I see you again see you again\n[03:41.020]When I see you again\n";
 mp3Url = "http://m1.music.126.net/gpi8Adr_-pfCuP7ZXk_F2w==/2926899953898363.mp3";
 name = "See You Again";
 picUrl = "http://p3.music.126.net/JIc9X91OSH-7fUZqVfQXAQ==/7731765766799133.jpg";
 singer = "Wiz Khalifa";
 },
 */
@interface MusicModel : NSObject
@property (nonatomic, strong)NSString *lyric;//歌词、

@property (nonatomic, assign)NSInteger id;

@property (nonatomic, assign)NSInteger duration;

@property (nonatomic, assign)NSString *blurPicUrl;

@property (nonatomic, strong)NSString *artists_name;

@property (nonatomic, strong)NSString *album;

@property (nonatomic, strong)NSString *mp3Url;

@property (nonatomic, strong)NSString *name;

@property (nonatomic, strong)NSString *picUrl;

@property (nonatomic, strong)NSString *singer;

@end
