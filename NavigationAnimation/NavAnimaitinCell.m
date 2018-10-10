//
//  NavAnimaitinCell.m
//  NavigationAnimation
//
//  Created by 刘浩浩 on 2018/9/29.
//  Copyright © 2018年 CodingFire. All rights reserved.
//

#import "NavAnimaitinCell.h"

#define ks_width [UIScreen mainScreen].bounds.size.width

@implementation NavAnimaitinCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createCommenCell];
    }
    return self;
}
//没有用约束是因为这个只做为参考
- (void)createCommenCell
{
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 60, 60)];
    _headerImageView.layer.cornerRadius = 30;
    _headerImageView.image = [UIImage imageNamed:@"header_img.jpg"];
    _headerImageView.clipsToBounds = YES;
    [self.contentView addSubview:_headerImageView];
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 12, 200, 60)];
    _userNameLabel.text = @"乌托邦";
    _userNameLabel.font = [UIFont systemFontOfSize:15];
    _userNameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_userNameLabel];
    
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 90, ks_width - 24, 100)];
    _contentLabel.text = @"君不见黄河之水天上来，奔流到海不复回。君不见高堂明镜悲白发，朝如青丝暮成雪。人生得意须尽欢，莫使金樽空对月。天生我材必有用，千金散尽还复来。烹羊宰牛且为乐，会须一饮三百杯。岑夫子，丹丘生，将进酒，杯莫停。与君歌一曲，请君为我侧耳听。钟鼓馔玉不足贵，但愿长醉不复醒。古来圣贤皆寂寞，惟有饮者留其名。陈王昔时宴平乐，斗酒十千恣欢谑。主人何为言少钱，径须沽取对君酌。五花马，千金裘，呼儿将出换美酒，与尔同销万古愁。";
    _contentLabel.font = [UIFont systemFontOfSize:13];
    _contentLabel.numberOfLines = 0;
    _contentLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_contentLabel];
    
}

@end
