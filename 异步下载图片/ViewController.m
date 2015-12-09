//
//  ViewController.m
//  异步下载图片
//
//  Created by Jusive on 15/12/9.
//  Copyright © 2015年 Jusive. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UIScrollView *scV;
@property (nonatomic,strong) UIImageView *imageV;
@end

@implementation ViewController


-(void)loadView{
    self.scV = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.scV.backgroundColor = [UIColor whiteColor];
    self.view  =  self.scV;
    
    self.imageV = [[UIImageView alloc]init];
    [self.scV addSubview:self.imageV];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *URL = [NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/pic/item/472309f790529822c4ac8ad0d5ca7bcb0a46d402.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:URL];
        //转换成图片
        UIImage * image = [UIImage imageWithData:data];
        //回到主线程
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.imageV.image = image;
            [self.imageV sizeToFit];
            self.scV.contentSize = image.size;
        });
    });
}
@end