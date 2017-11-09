//
//  ViewController.m
//  NSThread多线程
//
//  Created by zh dk on 2017/8/31.
//  Copyright © 2017年 zh dk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (int i=0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(100, 100+i*80, 80, 40);
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.tag = 100+i;
        if (i==0) {
            [btn setTitle:@"启动线程01" forState:UIControlStateNormal];
        }
        else if (i==1) {
            [btn setTitle:@"启动线程02" forState:UIControlStateNormal];
        }
       else if (i==2) {
            [btn setTitle:@"启动线程03" forState:UIControlStateNormal];
        }
        
        [self.view addSubview:btn];
    }
    
    _lock = [[NSLock alloc] init];
}

-(void)pressBtn:(UIButton*)btn
{
    //执行启动线程01
    if (btn.tag == 100) {
        NSLog(@"按钮1按下");
        //创建一个线程对象
        NSThread *newT = [[NSThread alloc] initWithTarget:self selector:@selector(actNew:) object:nil];
        //启动线程
        [newT start];
        
    }
    else if (btn.tag == 101){
        NSLog(@"按钮2按下");
        //创建并且启动线程
        [NSThread detachNewThreadSelector:@selector(actT1) toTarget:self withObject:nil];
    }
    else if (btn.tag == 102){
        NSLog(@"按钮3按下");
        
        _thread02 = [[NSThread alloc] initWithTarget:self selector:@selector(actT2) object:nil];
        [_thread02 start];
    }
}

-(void)actT1
{
    int i=0;
    while (true) {
//        NSLog(@"启动线程2");
        i++;
        if (i>=10000) {
            break;
        }
        
        //使加法操作安全性
        [_lock lock];
        _counter ++;
        [_lock unlock];
         NSLog(@"c1 = %ld",_counter);
    }
    NSLog(@"c1 final = %ld",_counter);

}

-(void)actT2
{
    while (true) {
//        NSLog(@"启动线程3");
        
        int i=0;
        while (true) {
//            NSLog(@"启动线程2");
            i++;
            if (i>=10000) {
                break;
            }
            [_lock lock];
            _counter ++;
            [_lock unlock];
            
            NSLog(@"c2 = %ld",_counter);
        }
        
        NSLog(@"c2 final = %ld",_counter);

    }
}

-(void) actNew:(NSThread*)thread{
    int i =0;
    while (true) {
        i++;
        NSLog(@"i = %d",i);
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
