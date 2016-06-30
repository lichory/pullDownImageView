//
//  ViewController.m
//  下拉图片变大
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 李重阳. All rights reserved.
//

#import "ViewController.h"

static CGFloat navH = 64;
static CGFloat startImageViewH = 150;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIImageView * imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.automaticallyAdjustsScrollViewInsets = NO;

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, navH, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - navH) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    /* 设置tableView的偏移量 **/
    _tableView.contentInset = UIEdgeInsetsMake(startImageViewH, 0, 0, 0);
    [self.view addSubview:_tableView];
    
    /*
     * 注意 imageView 的Y 值是-startImageViewH 其实这个值就是 tableView的内容偏移量
     * 如果Y 是0的话它还是会跟着tableView偏移startImageViewH 值
     **/
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -startImageViewH, CGRectGetWidth(self.view.frame), startImageViewH)];
    imageView.image = [UIImage imageNamed:@"1"];
    self.imageView = imageView;
    [self.tableView addSubview:imageView];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"offsetY = %f",offsetY);
    
    /* 计算往下拉的时候偏移量 **/
    if (offsetY < -startImageViewH) {
        
        /* 计算差值 **/
        CGFloat interval = -CGRectGetHeight(self.imageView.frame) - offsetY;
        
        /* imageView 的高度 增加 interval **/
        CGFloat imageViewH = CGRectGetHeight(self.imageView.frame) + interval;
        /* 计算 imageView的 高度增加后的，宽度增加后的值  **/
        CGFloat imageViewW = imageViewH*CGRectGetWidth(self.imageView.frame)/CGRectGetHeight(self.imageView.frame);
        /* 计算 imageView X 的偏移量 **/
        CGFloat imageViewX =self.imageView.frame.origin.x - (imageViewW -CGRectGetWidth(self.imageView.frame))/2;
        /* 计算 imageView Y 的偏移量 **/
        CGFloat imageViewY =self.imageView.frame.origin.y - interval;
        /* 赋值 **/
        self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
        
    }
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = @(indexPath.row).description;
    return cell;
}




@end
