//
//  ImageRecognition.m
//  ImageRecognitionDemo
//
//  Created by 张利果 on 2018/12/3.
//  Copyright © 2018年 张利果. All rights reserved.
//

#import <AipOcrSdk/AipOcrSdk.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/PHPhotoLibrary.h>
#import "ImageRecognition.h"

@implementation ImageRecognition


+ (void)authWithAK: (NSString *)ak andSK: (NSString *)sk {
    [[AipOcrService shardService] authWithAK:ak andSK:sk];
}

+ (void)imageRecognitionGeneralBasicVC:(UIViewController *)controller successHandler:(void (^)(id result, UIImage *image))successHandler failHandler: (void (^)(NSError* err))failHandler {
    
    if (![self isCameraOpen]) {
        NSString *errorStr = @"请允许App访问您的相机";
        [self imageSelectAlertMessage:errorStr andVC:controller];
        return;
    }
    if (![self isPhotoLibraryCanUse]) {
        NSString *errorStr = @"请允许App访问您的相册";
        [self imageSelectAlertMessage:errorStr andVC:controller];
        return;
    }
    
    //通用文字识别（基础版、不含位置信息）
    [self detectTextBasicFromImage:controller successHandler:successHandler failHandler:failHandler];
}

/**
 * 通用文字识别（基础版、不含位置信息）
 */
+(void)detectTextBasicFromImage:(UIViewController *)controller successHandler:(void (^)(id result, UIImage *image))successHandler failHandler: (void (^)(NSError* err))failHandler {
    UIViewController * aipGeneralVC = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
        NSDictionary *options = @{@"language_type": @"CHN_ENG", @"detect_direction": @"true"};
        [[AipOcrService shardService] detectTextBasicFromImage:image withOptions:options successHandler:^(id result) {
            if (successHandler) {
                successHandler(result, image);
            }
        } failHandler:^(NSError *err) {
            if (failHandler) {
                failHandler(err);
            }
        }];
    }];
    [controller presentViewController:aipGeneralVC animated:YES completion:nil];
}

#pragma mark - 图片识别基础配置判断
+ (BOOL)isCameraOpen{
    //    iOS 判断应用是否有使用相机的权限
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        return NO;
    }
    return YES;
}
+ (BOOL)isPhotoLibraryCanUse{
    //    iOS 判断应用是否有使用相册的权限
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}
+ (void)imageSelectAlertMessage:(NSString *)message andVC:(UIViewController *)controller{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([ [UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:setAction];
    [alertController addAction:cancelAction];
    [controller presentViewController:alertController animated:YES completion:nil];
}

@end
