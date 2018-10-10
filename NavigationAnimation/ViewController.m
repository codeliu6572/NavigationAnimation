//
//  ViewController.m
//  NavigationAnimation
//
//  Created by 刘浩浩 on 2018/9/29.
//  Copyright © 2018年 CodingFire. All rights reserved.
//

#import "ViewController.h"
#import "NavAnimaitinCell.h"
#import "UIColor+Hex.h"

#define ks_width [UIScreen mainScreen].bounds.size.width
#define ks_height [UIScreen mainScreen].bounds.size.height
#define knavbar_height (kstatusBarHeight + 44)
#define kstatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define bottom_distance 60
#define img_height 281 / (450 / ks_width)
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
{
    UITableView *headerAniTableView;
    UIImageView *headerBgImageView;
    UIView *whiteBaseView;
    UIView *hdHeaderView;
    UIView *navigationView;
    UILabel *hotTitle;
    CGSize titlesize;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    headerAniTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ks_width, ks_height) style:UITableViewStylePlain];
    headerAniTableView.delegate = self;
    headerAniTableView.dataSource = self;
    [self.view addSubview:headerAniTableView];
    headerAniTableView.tableHeaderView = [self createNavHeaderView];
    
    [self creatNavigationView];
}

#pragma mark - creatNavigationView
- (void)creatNavigationView
{
    navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ks_width, knavbar_height)];
    navigationView.backgroundColor = [UIColor whiteColor];
    navigationView.alpha = 0;
    [self.view addSubview:navigationView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, knavbar_height - 0.5, ks_width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithHex:@"#999999"];
    [navigationView addSubview:lineView];
}
 
- (UIView *)createNavHeaderView
{
    hdHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ks_width, img_height)];
    hdHeaderView.clipsToBounds = YES;
    
    headerBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ks_width, img_height)];
    headerBgImageView.userInteractionEnabled = YES;
    headerBgImageView.image = [UIImage imageNamed:@"top_header.jpg"];
    [hdHeaderView addSubview:headerBgImageView];
    
    whiteBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ks_width, img_height)];
    whiteBaseView.userInteractionEnabled = NO;
    whiteBaseView.backgroundColor = [UIColor whiteColor];
    whiteBaseView.alpha = 0;
    [hdHeaderView addSubview:whiteBaseView];
    
    titlesize =  [@"落红不是无情物" boundingRectWithSize:CGSizeZero options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    hotTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, img_height - bottom_distance, titlesize.width, 44)];
    hotTitle.font = [UIFont boldSystemFontOfSize:18];
    hotTitle.textColor = [UIColor whiteColor];
    hotTitle.text = @"落红不是无情物";
    [self.view addSubview:hotTitle];
    
    return hdHeaderView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NavAnimaitinCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[NavAnimaitinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float luochaY = img_height - knavbar_height;
    NSArray *colorArray = @[@"#000000", @"#111111", @"#222222", @"#333333", @"#444444", @"#555555", @"#666666", @"#777777", @"#888888", @"#999999", @"#aaaaaa", @"#bbbbbb", @"#cccccc", @"#dddddd", @"#eeeeee", @"#ffffff"];
    CGFloat offSetY = scrollView.contentOffset.y;
    if (offSetY<=0) {
        scrollView.contentOffset = CGPointMake(0, 0);
        navigationView.alpha = 0;
        hotTitle.frame = CGRectMake(20, img_height - 60, titlesize.width, 44);
        hotTitle.textColor = [UIColor whiteColor];
        headerBgImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        whiteBaseView.alpha = 0;
    }
    else if (offSetY > luochaY) {
        offSetY = luochaY;
        navigationView.alpha = 1;
        whiteBaseView.alpha = 1;
        hotTitle.frame = CGRectMake(20 + offSetY / luochaY * ((ks_width - 40 - titlesize.width) / 2), kstatusBarHeight, titlesize.width, 44);
        hotTitle.textColor = [UIColor blackColor];
    }else{
        NSLog(@"%f", offSetY);
        navigationView.alpha = 0;
        hotTitle.frame = CGRectMake(20 + offSetY / luochaY * ((ks_width - 40 - titlesize.width) / 2),img_height - bottom_distance - (img_height - bottom_distance - kstatusBarHeight) * (offSetY / luochaY), titlesize.width, 44);
        int colorIndex = colorArray.count - offSetY / (luochaY / colorArray.count);
        hotTitle.textColor = [UIColor colorWithHex:colorArray[colorIndex]];
        headerBgImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1 + 0.4 * (offSetY / luochaY), 1 + 0.2* (offSetY / luochaY));
        whiteBaseView.alpha = offSetY / luochaY;
    }
    [self.view bringSubviewToFront:hotTitle];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat offSetY = scrollView.contentOffset.y;
    if (offSetY > 60 && offSetY <= 112) {
        [scrollView setContentOffset:CGPointMake(0, img_height - knavbar_height) animated:YES];
    }
    
    if (offSetY > 0 && offSetY <= 60) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
