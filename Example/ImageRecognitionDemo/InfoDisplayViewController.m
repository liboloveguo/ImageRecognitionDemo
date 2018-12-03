//
//  InfoDisplayViewController.m
//  ImageRecognitionDemo
//
//  Created by 张利果 on 2018/11/25.
//  Copyright © 2018年 张利果. All rights reserved.
//

#import "InfoDisplayViewController.h"

@interface InfoDisplayViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@end

@implementation InfoDisplayViewController

+(instancetype)controller{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"InfoDisplayViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"识别结果";
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    //1.imageview
    CGFloat padding = 20;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(padding, padding, width-padding*2, width-padding*2)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = self.image;
    [self.scrollview addSubview:imageView];
    
    //2.lable
    UIFont *font = [UIFont systemFontOfSize:16];
    UIColor *color = [UIColor blackColor];
    UILabel *lable = [[UILabel alloc]init];
    lable.text = self.info;
    lable.font = font;
    lable.textColor = color;
    lable.numberOfLines = 0;
    [self.scrollview addSubview:lable];
    CGRect textRect = [self.info boundingRectWithSize:CGSizeMake(width-padding*2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{
                                                        NSForegroundColorAttributeName:color,
                                                                                                                    NSFontAttributeName:font
                                                                                                                                            } context:nil];
    lable.frame = CGRectMake(padding, CGRectGetMaxY(imageView.frame)+20, textRect.size.width, textRect.size.height);
    
    self.scrollview.contentSize = CGSizeMake(width, CGRectGetMaxY(lable.frame)+20);
    
}



@end
