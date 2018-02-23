//
//  LXD2ViewController.m
//  
//
//  Created by zheng zhang on 2018/2/13.
//

#import "LXD2ViewController.h"
#import "PoemCell.h"
#import "MJRefresh.h"

#define Width  [[UIScreen mainScreen] bounds].size.width
#define Height [[UIScreen mainScreen] bounds].size.height

@interface LXD2ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) NSMutableArray *images;
@end

@implementation LXD2ViewController
int p = 0;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _datas = [[NSMutableArray alloc]init];
    _images =[[NSMutableArray alloc]init];
   
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 8;
    layout.minimumLineSpacing = 8;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [_collectionView registerClass:[PoemCell class] forCellWithReuseIdentifier:@"poemCell"];
   
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(65, 0, 0, 0));
       
    }];
    
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        //Call this Block When enter the refresh status automatically
        [_collectionView.mj_header setAlpha:1];
        // 增加5条假数据
        for (int i = 11; i<=15; i++) {
            NSString *newString = [NSString stringWithFormat:@"%@%d",@"data",i];
            [_datas appendObject:newString];
        }
        
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_collectionView reloadData];
            
            // 结束刷新
            [_collectionView.mj_header endRefreshing];
            [_collectionView.mj_header setAlpha:0];
        });
        
    }];
    
    //https://raw.githubusercontent.com/nanjiale/LiveChannels/f53831d9e36c374f783026ebdbac28fa4392abd5/app/src/main/assets/channels.json
   //网络请求 下拉刷新 自动布局
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        // 增加5条假数据

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //@"https://api.douban.com/v2/movie/in_theaters?start=0&count=20"
        
        NSString *url = [NSString stringWithFormat:@"https://api.douban.com/v2/movie/in_theaters?start=%d&count=5",p*20];
        p = p + 1;
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //NSLog(@"success--%@--%@",[responseObject class],responseObject );
            NSArray *dict = [responseObject valueForKeyPath:@"subjects"];
            
            for (int i = 0; i<5; i++) {
                NSString *title = [dict[i] valueForKeyPath:@"title"];
                NSString *image = [dict[i] valueForKeyPath:@"images.large"];
                //NSLog(@"%@",image);
                [_datas appendObject:title];
                [_images appendObject:image];
            }
            [_collectionView reloadData];
            
            // 结束刷新
            [_collectionView.mj_footer endRefreshing];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"failure--%@",error);
        }];
        
      
      
        
      
    }];
    
    // Enter the refresh status immediately
    //self.collectionView.mj_footer.hidden = YES;
    self.collectionView.mj_header.hidden = YES;
    [self.collectionView.mj_footer beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**头部标题*/
- (NSMutableAttributedString*)lmjNavigationBarTitle:(LMJNavigationBar *)navigationBar
{
    return [self changeTitle:@"最新电影"];
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    if (section==0) {
//        return self.homeHeadData.category.act_rows.count;
//    }else{
//        return self.freshHots.count;
//    }
    
    return _datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    
    PoemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"poemCell" forIndexPath:indexPath];
    //NSLog(@"self.freshHots[indexPath.row] = %@",self.freshHots[indexPath.row]);
    NSLog(@"%@",_images[indexPath.row]);
    [cell setTitle:_datas[indexPath.row]];
    [cell setImage:_images[indexPath.row]];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    if (indexPath.section == 0) {
        itemSize = CGSizeMake(Width, Width+100);
    }else if (indexPath.section == 1){
        itemSize = CGSizeMake((Width - 5 * 2) * 0.5 - 4, 260);
    }
    return itemSize;
}

@end
