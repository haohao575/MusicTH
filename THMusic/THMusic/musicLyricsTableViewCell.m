//
//  musicLyricsTableViewCell.m
//  THMusic
//
//  Created by 童浩 on 15/8/27.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "musicLyricsTableViewCell.h"

@implementation musicLyricsTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self lodeView];
    }
    return self;
}
- (void)lodeView{
    _lyricsLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, kBounds.size.width - 10, 60)];
    _lyricsLabel.font = [UIFont systemFontOfSize:14];
    _lyricsLabel.numberOfLines = 0;
    _lyricsLabel.textAlignment = NSTextAlignmentCenter;
    _lyricsLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_lyricsLabel];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
