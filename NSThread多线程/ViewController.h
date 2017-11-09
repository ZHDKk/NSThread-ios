//
//  ViewController.h
//  NSThread多线程
//
//  Created by zh dk on 2017/8/31.
//  Copyright © 2017年 zh dk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    //定义线程对象
    NSThread *_thread01;
    NSThread *_thread02;
    //定义一个计数器
    NSInteger *_counter;
    //定义一个线程对象
    NSLock *_lock;
}


@end

