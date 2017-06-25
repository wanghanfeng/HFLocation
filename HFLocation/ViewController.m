//
//  ViewController.m
//  HFLocation
//
//  Created by whf on 17/6/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "HFLocation.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *lable;
@property (nonatomic, strong) HFLocation *location;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 400, 60)];
    self.lable = lable;
    self.lable.backgroundColor = [UIColor blueColor];
    [self.view addSubview:lable];
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    refreshBtn.frame = CGRectMake(100, 300, 100, 40);
    [refreshBtn setTitle:@"刷新位置" forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(btnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshBtn];
    HFLocation *location = [[HFLocation alloc] sharedInstance];
    self.location = location;
}

- (void)btnDidClick {
    self.lable.text = @"";
    [self.location getLocationName:^(NSError *error, NSDictionary *result) {
        NSString *addrStr = [NSString stringWithFormat:@"%@%@",[result[@"FormattedAddressLines"] firstObject],result[@"Name"]];
        self.lable.text = addrStr;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
