//
//  ViewController.m
//  CustomPopView
//
//  Created by apple on 17/1/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HomeViewController.h"
#import "CustomPopView.h"

#define RGBCOLOR(r,g,b)		[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define UIColorFromHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

@interface HomeViewController ()<CustomPopViewDelegate>{
     NSArray *menus;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = UIColorFromHex(0x222222); // 背景色
    self.navigationController.navigationBar.translucent = NO;
    menus = @[@"发起群聊", @"添加朋友",@"扫一扫",@"收付款"];
    [self setNavigitionItem];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setNavigitionItem{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setImage:[UIImage imageNamed:@"ger_add"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)buttonAction: (UIButton *)sender{
    //这里的44是tableView的行高
    CustomPopView *pView = [[CustomPopView alloc]initWithBounds:CGRectMake(0, 0, 120, 44 * menus.count) titleMenus: menus maskAlpha:0.0];
    pView.delegate = self;
    // pView.containerBackgroudColor = RGBCOLOR(0, 100, 14);//可以用来调节边界线的颜色
    pView.containerBackgroudColor = [UIColor redColor];
    [pView showFrom:sender alignStyle:CPAlignStyleRight];
}

#pragma mark - CustomPopViewDelegate
- (void)popOverView:(CustomPopView *)pView didClickMenuIndex:(NSInteger)index{
    NSLog(@"%@", menus[index]);
    NSString *titleStr = [NSString stringWithFormat:@"你点击了 %@",menus[index]];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:titleStr message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:sureAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
