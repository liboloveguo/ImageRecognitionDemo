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
    [ImageRecognition authWithAK:@"Hr3FEBCnvN53HnoPBhGzczDv" andSK:@"7YP7Vs6ImUtCOLbz95TUlO3LjnbYfC2H"];
    
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
            weakSelf.textView.text = message;
            NSLog(@"%@",message);
        }];
        
    } failHandler:^(NSError *err) {
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
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
