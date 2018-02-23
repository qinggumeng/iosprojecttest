//
//  PoemCell.m
//  iOSProject
//
//  Created by zheng zhang on 2018/2/13.
//  Copyright © 2018年 HuXuPeng. All rights reserved.
//

#import "PoemCell.h"
#import "VIDMoviePlayerViewController.h"

@interface PoemCell()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *moreLable;
@property (nonatomic,strong) UIImageView *giveImageView;
@end

@implementation PoemCell


- (instancetype)initWithFrame:(CGRect)frame{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellTapgesture)];
    [self addGestureRecognizer:tap];
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:[UIColor redColor]];
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"优选水果";
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [_titleLabel sizeToFit];
        _moreLable = [[UILabel alloc]init];
        _moreLable.font = [UIFont systemFontOfSize:12];
        _moreLable.textAlignment = NSTextAlignmentRight;
        _moreLable.text = @"更多 >";
        [_moreLable sizeToFit];
        
        _giveImageView = [[UIImageView alloc]init];
        [self addSubview:_lineView];
        [self addSubview:_titleLabel];
        [self addSubview:_moreLable];
        [self addSubview:_giveImageView];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(3);
            make.top.equalTo(self).offset(5);
            make.height.mas_equalTo(15);
            make.leading.equalTo(self).offset(10);
            //make.centerY.equalTo(self);
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_lineView);
            make.leading.equalTo(_lineView).offset(10);
            make.height.mas_equalTo(15);
        }];
        [_moreLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self).offset(10);
            make.centerY.equalTo(_lineView);
            make.height.mas_equalTo(15);
        }];
        
        [_giveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_moreLable.mas_bottom).offset(10);
            make.centerX.equalTo(self);
            make.bottom.equalTo(self).offset(-10);
            make.width.mas_equalTo(self.width-20);
//            make.height.mas_equalTo(150);
//            make.width.mas_equalTo(150);
            
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = _title;
}

-(void)setImage:(NSString *)image{
    _image = image;
    NSLog(@"%@",_image);
     [_giveImageView sd_setImageWithURL:[NSURL URLWithString:_image] placeholderImage:[UIImage imageNamed:@"v2_placeholder_square"]];
}

- (void)cellTapgesture{
    VIDMoviePlayerViewController *playerVc = [[VIDMoviePlayerViewController alloc] init];
    playerVc.videoURL = @"http://rotation.vod.zlive.cc/channel/1258.m3u8";
    
    [self.viewController.navigationController pushViewController:playerVc animated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
