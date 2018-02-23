//
//  LXD3ViewController.m
//  iOSProject
//
//  Created by zheng zhang on 2018/2/13.
//  Copyright © 2018年 HuXuPeng. All rights reserved.
//

#import "LXD3ViewController.h"
#import "LMJLiftCycleViewController.h"
#import "MusicPlayerViewController.h"

@interface LXD3ViewController ()

@end

@implementation LXD3ViewController
int p2 = 1;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray<LMJWordItem *> * items = [[NSMutableArray alloc]init];
    
    
   
    
    NSString *url = [NSString stringWithFormat:@"http://www.ximalaya.com/13237119/album/329784/?page=%d",p2];
    p2 = p2 + 1;
    
    
    NSURL *hurl=[[NSURL alloc] initWithString:url];
    NSString *s6=[[NSString alloc] initWithContentsOfURL:hurl encoding:NSUTF8StringEncoding error:nil];
   
    //原字段
    NSString *testString1 = @"clc_cfzxyq@163.com wcowfjwogjwoiejfiow 12321@qq.com 298349845fwe ctftf:iLoveiOS@qq.com";
    NSError *error;
    //正则表达式，解析邮箱
    
    //<a class="title" href="/13237119/sound/5115050/" hashlink="" title="岑参：轮台歌奉送封大夫出师西征">
   // 岑参：轮台歌奉送封大夫出师西征
   // </a>
    NSString* regexString = @"<a class=\"title\"(.*?)>";
    //创建一个正则表达式对象，存储匹配规则
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:0 error:&error];
    if (regex != nil) {
        //用该方法解析出所有
        NSArray* array = [regex matchesInString:s6 options:NSMatchingReportProgress range:NSMakeRange(0, [s6 length])];
        NSMutableArray* stringArray = [[NSMutableArray alloc] init];
        
        //当解析出的数组至少有一个对象时，即原文本中存在至少一个符合规则的字段
        NSLog(@"%d\n",array.count);
        if (array.count != 0) {
            for (NSTextCheckingResult* result in array) {
                //从NSTextCheckingResult类中取出range属性
                NSRange range = result.range;
                //从原文本中将字段取出并存入一个NSMutableArray中
                NSString *mystr = [s6 substringWithRange:range];
                NSLog(@"%@",mystr);
                [stringArray addObject:[s6 substringWithRange:range]];
                NSUInteger location = [mystr rangeOfString:@"title=\""].location +7;
                NSUInteger length = [mystr rangeOfString:@"\">"].location - location;
                //NSUInteger length = [str rangeOfString:@"<" options:NSBackwardsSearch].location - location;//需要注意str中有两个<
                NSRange range2 = NSMakeRange(location, length);
                
                //根据range，在原字符串中截取后得到新字符串
                NSString *newStr = [mystr substringWithRange:range2];//返回一个新的字符串
                
                NSUInteger location2 = [mystr rangeOfString:@"sound/"].location +6;
                NSUInteger length2 = [mystr rangeOfString:@"/\" hashlink"].location - location2;
                NSRange range3 = NSMakeRange(location2, length2);
                NSString *mid = [mystr substringWithRange:range3];//返回一个新的字符串
                NSLog(@"%@",mid);
            
                LMJWordArrowItem *item = [LMJWordArrowItem itemWithTitle:newStr subTitle: nil];
                item.mid = mid;
                item.destVc = [MusicPlayerViewController class];
                
                
                [items addObject:item];
            }
        }
        //打印结果
       // NSLog(@"%@",stringArray);
        
        
    }
    
    LMJItemSection *section0 = [LMJItemSection sectionWithItems:items andHeaderTitle:@"唐诗三百首1" footerTitle:@""];
    
[self.sections addObject:section0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
