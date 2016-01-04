//
//  ViewController.m
//  DamonPhotoBrowser
//
//  Created by acer_mac on 15/12/31.
//  Copyright © 2015年 Damon. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSString *tableViewStyle;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataArr = @[@[
                             @"http://pic2.ooopic.com/01/03/51/25b1OOOPIC19.jpg",
                             @"http://pic14.nipic.com/20110522/7411759_164157418126_2.jpg",
                             @"http://pica.nipic.com/2008-03-19/2008319183523380_2.jpg",
                             @"http://imgsrc.baidu.com/forum/pic/item/3ac79f3df8dcd1004e9102b8728b4710b9122f1e.jpg",
                             @"http://pic.nipic.com/2007-11-08/2007118192311804_2.jpg",
                             @"http://pic.nipic.com/2007-11-08/200711819133664_2.jpg",

                             ],
                         @[
                             @"http://pic2.ooopic.com/01/03/51/25b1OOOPIC19.jpg",
                             @"http://pic14.nipic.com/20110522/7411759_164157418126_2.jpg",
                             @"http://pica.nipic.com/2008-03-19/2008319183523380_2.jpg",
                             @"http://imgsrc.baidu.com/forum/pic/item/3ac79f3df8dcd1004e9102b8728b4710b9122f1e.jpg",
                             @"http://pic.nipic.com/2007-11-08/2007118192311804_2.jpg",
  
                             ],
                         @[
                             @"http://pica.nipic.com/2008-03-19/2008319183523380_2.jpg",
                             @"http://imgsrc.baidu.com/forum/pic/item/3ac79f3df8dcd1004e9102b8728b4710b9122f1e.jpg",
                             ],
                         @[
                             @"http://pica.nipic.com/2008-03-19/2008319183523380_2.jpg",
                             @"http://imgsrc.baidu.com/forum/pic/item/3ac79f3df8dcd1004e9102b8728b4710b9122f1e.jpg",
                             @"http://pic.nipic.com/2007-11-08/2007118192311804_2.jpg",
                             @"http://pic.nipic.com/2007-11-08/200711819133664_2.jpg",
                             ],
                         @[
                             @"http://pic2.ooopic.com/01/03/51/25b1OOOPIC19.jpg",
                             @"http://pic14.nipic.com/20110522/7411759_164157418126_2.jpg",
                             @"http://pica.nipic.com/2008-03-19/2008319183523380_2.jpg",
                             ],
                         @[
                             @"http://pic2.ooopic.com/01/03/51/25b1OOOPIC19.jpg",
                             @"http://pic14.nipic.com/20110522/7411759_164157418126_2.jpg",
                             @"http://pica.nipic.com/2008-03-19/2008319183523380_2.jpg",
                             @"http://imgsrc.baidu.com/forum/pic/item/3ac79f3df8dcd1004e9102b8728b4710b9122f1e.jpg",
                             @"http://pic.nipic.com/2007-11-08/2007118192311804_2.jpg",

                             ]
                         ];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self tableView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        [self.view addSubview: _tableView = tableView];
        
    }
    
    return _tableView;
}


#pragma mark 设置UItableView的cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}


- (CGFloat)tableView:(__unused UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

  CGFloat height = (self.view.frame.size.width - 30) / 3.0;
    
    
    return height * ceil( 1.0 * self.dataArr.count / 3.0);
}

#pragma mark 给cell传值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaa"];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aaa" rowHeight:0];
    }
//    CGFloat height = (self.view.frame.size.width - 30) / 3.0;
//    cell height * ceil(self.dataArr.count / 3.0);
    cell.imageArr = self.dataArr[indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
