//
//  ViewController.m
//  ImageRecognitionDemo
//
//  Created by 张利果 on 2018/11/21.
//  Copyright © 2018年 张利果. All rights reserved.
//

#import "ImageRecognition.h"
#import "ViewController.h"

@interface ViewController ()<UIAlertViewDelegate>
@property (nonatomic,strong) UITextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self UI];
    
    [self imageCallBack];
    
}

-(void)imageCallBack {
    
    //从百度云平台申请的对应项目的 AppKey 与 SecretKey
    
    [ImageRecognition authWithAppKey:@"Hr3FEBCnvN53HnoPBhGzczDv" andSecretKey:@"7YP7Vs6ImUtCOLbz95TUlO3LjnbYfC2H"];
    
    __weak typeof(self) weakSelf = self;
    [ImageRecognition imageRecognitionGeneralBasicVC:self successHandler:^(id result, UIImage *image) {
        
        //处理数据
        NSMutableString *message = [NSMutableString string];
        if(result[@"words_result"]){
            if([result[@"words_result"] isKindOfClass:[NSDictionary class]]){
                [result[@"words_result"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    if([obj isKindOfClass:[NSDictionary class]] && [obj objectForKey:@"words"]){
                        [message appendFormat:@"%@: %@\n", key, obj[@"words"]];
                    }else{
                        [message appendFormat:@"%@: %@\n", key, obj];
                    }
                    
                }];
            }else if([result[@"words_result"] isKindOfClass:[NSArray class]]){
                for(NSDictionary *obj in result[@"words_result"]){
                    if([obj isKindOfClass:[NSDictionary class]] && [obj objectForKey:@"words"]){
                        [message appendFormat:@"%@\n", obj[@"words"]];
                    }else{
                        [message appendFormat:@"%@\n", obj];
                    }
                    
                }
            }
            
        }else{
            [message appendFormat:@"%@", result];
        }
        
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            
            if (message.length > 0) {
                weakSelf.textView.text = message;
            }
            else{
                weakSelf.textView.text = @"内容为空";
            }
            NSLog(@"%@",message);
        }];
        
    } failHandler:^(NSError *err) {
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            weakSelf.textView.text = @"识别有误";
            NSLog(@"%@",err);
        }];
        
    }];
    
}

-(void) UI {
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-150, [UIScreen mainScreen].bounds.size.height*0.5)];
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.textColor = [UIColor blackColor];
    self.textView.center = self.view.center;
    [self.view addSubview:self.textView];
}

@end
