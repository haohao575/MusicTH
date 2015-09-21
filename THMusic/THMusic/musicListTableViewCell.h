//
//  musicListTableViewCell.h
//  THMusic
//
//  Created by 童浩 on 15/8/27.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"
@interface musicListTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *musicImageView;

@property (nonatomic, strong)UILabel *musicNameLabel;

@property (nonatomic, strong)UILabel *musicPersonName;

@property (nonatomic, strong)MusicModel *music;
@end
