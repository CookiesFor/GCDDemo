//
//  ViewController.m
//  GCDDemo
//
//  Created by SIMPLE PLAN on 16/3/2.
//  Copyright © 2016年 SIMPLE PLAN. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSURL * url = [NSURL URLWithString:@"http://www.baidu.com"];
//        NSError * error;
//        NSString * data = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
//        if (data != nil) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"call back, the data is: %@", data);
//            });
//        } else {
//            NSLog(@"error when download:%@", error);
//        }
//    });
    
    //获取全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //添加任务到队列中，就可以执行任务
    //异步：具备开启新线程的能力
    dispatch_async(queue, ^{
        NSLog(@"并发队列第一个懵逼%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"并发队列第二个懵逼%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"并发队列第三个懵逼%@",[NSThread currentThread]);
    });
    
    //打印主线程
    NSLog(@"串行队列主线程%@",[NSThread mainThread]);
    
    //创建串行队列
    dispatch_queue_t queue1 = dispatch_queue_create("guozhenwei", NULL);
    //第一个参数为穿行队列的名字，是C语言字符串
    //第二个参数为队列的属性，一般来说为空值NUll
    
    //添加任务到队列中执行
    dispatch_async(queue1, ^{
        NSLog(@"串行队列第一个懵逼%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue1, ^{
        NSLog(@"串行队列第二个懵逼%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue1, ^{
        NSLog(@"串行队列第三个懵逼%@",[NSThread currentThread]);
    });
    
    //原因 dispatch_sync 是同步线程执行代码 要阻塞当前线程，如果当前线程是主线程，首先被阻塞，然后执行hello输出，问题是代码的参数是dispatch_get_main_queue() 它会获取主线程然后在主线程执行 hello输出 主线程本来就被阻塞 所以造成了互锁。
//    NSLog(@"1");
//    dispatch_sync(dispatch_get_main_queue() , ^{
//        NSLog(@"2");
//    });
//    NSLog(@"3");
    
    
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 20)];
    label.text = @"www.baidu.com";
    
    [self.view addSubview:label];
    
    label.backgroundColor = [UIColor redColor];
    
    label.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [label addGestureRecognizer:tap];
    
    label.superview.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    
}

-(void)tap:(UITapGestureRecognizer *)tap
{
    //复制到剪切版
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"www.baidu.com";

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
