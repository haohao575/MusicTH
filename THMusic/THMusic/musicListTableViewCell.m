//
//  musicListTableViewCell.m
//  THMusic
//
//  Created by 童浩 on 15/8/27.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "musicListTableViewCell.h"

@implementation musicListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self lodeView];
    }
    return self;
}
- (void)setMusic:(MusicModel *)music{
    if (_music != music) {
        _music = music;
    }
    _musicNameLabel.text = music.name;
    _musicPersonName.text = music.singer;
}

- (void)lodeView{
    
    _musicImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, kBounds.size.width / 3.0, kBounds.size.width / 3.0 + 20)];
    [self.contentView addSubview:_musicImageView];
    
    _musicNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_musicImageView.frame.origin.x + _musicImageView.frame.size.width + 5, _musicImageView.frame.origin.y - 10, kBounds.size.width - _musicImageView.frame.size.width -_musicImageView.frame.origin.x + 5, 80)];
    _musicNameLabel.numberOfLines = 0;
    [self.contentView addSubview:_musicNameLabel];
    
    _musicPersonName = [[UILabel alloc]initWithFrame:CGRectMake(_musicNameLabel.frame.origin.x, _musicImageView.frame.size.height - 30, _musicNameLabel.frame.size.width, 40)];
    _musicPersonName.textColor = [UIColor grayColor];
    _musicPersonName.font = [UIFont systemFontOfSize:16.0];
    [self.contentView addSubview:_musicPersonName];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
