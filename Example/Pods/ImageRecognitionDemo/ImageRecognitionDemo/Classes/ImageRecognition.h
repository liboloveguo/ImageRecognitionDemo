//
//  ImageRecognition.h
//  ImageRecognitionDemo
//
//  Created by 张利果 on 2018/12/3.
//  Copyright © 2018年 张利果. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ImageRecognition : NSObject

-(void)imageRecognitionGeneralBasicVC:(UIViewController *)controller successHandler:(void (^)(id result, UIImage *image))successHandler failHandler: (void (^)(NSError* err))failHandler;

+ (void)imageRecognitionGeneralBasicImage:(UIImage *)image successHandler:(void (^)(id result, UIImage *image))successHandler failHandler: (void (^)(NSError* err))failHandler;

/**
 * 使用Api Key, Secret Key授权
 */

+ (void)authWithAK: (NSString *)ak andSK: (NSString *)sk;

/*!**生成单例***/
+ (instancetype)sharedInstance;

/*!**销毁单例***/
+ (void)destroyInstance;

@end
