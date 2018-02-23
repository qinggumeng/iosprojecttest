//
//  MusicPlayerViewController.m
//  iOSProject
//
//  Created by zheng zhang on 2018/2/14.
//  Copyright © 2018年 HuXuPeng. All rights reserved.
//

#import "MusicPlayerViewController.h"

#import <AVFoundation/AVFoundation.h>
@interface MusicPlayerViewController () <AVAudioPlayerDelegate>{
    AVAudioPlayer *_audioPlayer;
    AVPlayer *_avPlayer;
    NSString *murl;
}

@end

@implementation MusicPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //@"https://api.douban.com/v2/movie/in_theaters?start=0&count=20"
    
    NSString *jsonurl = [NSString stringWithFormat:@"http://www.ximalaya.com/tracks/%@.json",[self.navigationItem title]];

    [manager GET:jsonurl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"success--%@--%@",[responseObject class],responseObject );
    NSString *musicurl2 = [responseObject valueForKeyPath:@"play_path"];
        NSString *title = [responseObject valueForKeyPath:@"title"];
        [self setTitle:title];
        murl = musicurl2;
    
        NSLog(@"musicurl--%@",murl);
        
        NSURL *url = [NSURL URLWithString:murl];
        
        
            //创建播放器
        _avPlayer = [[AVPlayer alloc] initWithURL:url];
        
        [_avPlayer play];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"failure--%@",error);
    }];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)leftButtonEvent:(UIButton *)sender navigationBar:(LMJNavigationBar *)navigationBar
{
    NSLog(@"%s", __func__);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIImage *)lmjNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(LMJNavigationBar *)navigationBar
{
    [leftButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateHighlighted];
    
    return [UIImage imageNamed:@"navigationButtonReturnClick"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
