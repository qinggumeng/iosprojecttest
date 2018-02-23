//
//  LXD1ViewController.m
//  iOSProject
//
//  Created by zheng zhang on 2018/2/13.
//  Copyright © 2018年 HuXuPeng. All rights reserved.
//

#import "LXD1ViewController.h"
#import "LMJLiftCycleViewController.h"

@interface LXD1ViewController ()

@end

@implementation LXD1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //VIDMoviePlayerViewController *playerVc = [[VIDMoviePlayerViewController alloc] init];
  //  playerVc.videoURL = item.subTitle.copy;
  //  [self.navigationController pushViewController:playerVc animated:YES];
    
    LMJWordArrowItem *item00 = [LMJWordArrowItem itemWithTitle:@"电影1HD" subTitle: nil];
    item00.destVc = [LMJLiftCycleViewController class];
    
    LMJWordArrowItem *item01 = [LMJWordArrowItem itemWithTitle:@"运行时RunTime 的知识运用" subTitle: nil];
    item01.destVc = [LMJLiftCycleViewController class];
    
    LMJWordArrowItem *item03 = [LMJWordArrowItem itemWithTitle:@"Protocol 的实现类" subTitle: nil];
    item03.destVc = [LMJLiftCycleViewController class];
    
    
    LMJWordArrowItem *item04 = [LMJWordArrowItem itemWithTitle:@"Block 内存释放" subTitle: nil];
    item04.destVc = [LMJLiftCycleViewController class];
    
   
    
    
    
    
    LMJItemSection *section0 = [LMJItemSection sectionWithItems:@[item00, item01, item03, item04
                                                                ] andHeaderTitle:@"" footerTitle:@""];
    
    
    
    [self.sections addObject:section0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**头部标题*/
- (NSMutableAttributedString*)lmjNavigationBarTitle:(LMJNavigationBar *)navigationBar
{
    return [self changeTitle:@"首页"];
}

-(NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
    
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
    
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, title.length)];
    
    return title;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//　- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.01;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0.01;
//}

@end
