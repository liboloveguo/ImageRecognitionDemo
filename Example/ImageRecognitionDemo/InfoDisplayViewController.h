//
//  InfoDisplayViewController.h
//  ImageRecognitionDemo
//
//  Created by 张利果 on 2018/11/25.
//  Copyright © 2018年 张利果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoDisplayViewController : UIViewController
@property (nonatomic,strong) UIImage *image;
@property(nonatomic,copy) NSString *info;
+(instancetype)controller;
@end
