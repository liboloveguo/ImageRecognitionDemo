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

static ImageRecognition *_instance=nil;
static dispatch_once_t onceToken;

-(void)imageRecognitionGeneralBasicVC:(UIViewController *)controller imageRecognitionType:(ImageRecognitionType)optionType successHandler:(void (^)(id result, UIImage *image))successHandler failHandler: (void (^)(NSError* err))failHandler {
    
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
    
    if (optionType == ImageRecognitionTypeDetectTextBasicFromImage) {
        //通用文字识别（基础版、不含位置信息）
        [self detectTextBasicFromImage:controller successHandler:successHandler failHandler:failHandler];
    }
    else if (optionType == ImageRecognitionTypeDetectTextFromImage) {
        //通用文字识别（含位置信息）
        [self detectTextFromImage:controller successHandler:successHandler failHandler:failHandler];
    }
    else if (optionType == ImageRecognitionTypeDetectTextAccurateBasicFromImage) {
        //通用文字识别（高精度、不含位置信息)
        [self detectTextAccurateBasicFromImage:controller successHandler:successHandler failHandler:failHandler];
    }
    else if (optionType == ImageRecognitionTypeDetectTextAccurateFromImage) {
        //通用文字识别（高精度、含位置信息)
        [self detectTextAccurateFromImage:controller successHandler:successHandler failHandler:failHandler];
    }
    else if (optionType == ImageRecognitionTypeDetectTextEnhancedFromImage) {
        //通用文字识别(含生僻字)
        [self detectTextFromImage:controller successHandler:successHandler failHandler:failHandler];
    }
    else if (optionType == ImageRecognitionTypeDetectWebImageFromImage) {
        //网图识别
        [self detectWebImageFromImage:controller successHandler:successHandler failHandler:failHandler];
    }
    else if (optionType == ImageRecognitionTypeDetectIdCardFrontFromImage) {
        //身份证正面识别
        [self detectIdCardFrontFromImage:controller successHandler:successHandler failHandler:failHandler];
    }
    else if (optionType == ImageRecognitionTypeDetectIdCardBackFromImage) {
        //身份证背面识别
        [self detectIdCardBackFromImage:controller successHandler:successHandler failHandler:failHandler];
    }
    else if (optionType == ImageRecognitionTypeDetectBankCardFromImage) {
        //银行卡识别
        [self detectBankCardFromImag:controller successHandler:successHandler failHandler:failHandler];
    }
    else if (optionType == ImageRecognitionTypeDetectDrivingLicenseFromImage) {
        //驾驶证识别
        [self detectDrivingLicenseFromImage:controller successHandler:successHandler failHandler:failHandler];
    }
    else if (optionType == ImageRecognitionTypeDetectVehicleLicenseFromImage) {
        //行驶证识别
        [self detectVehicleLicenseFromImage:controller successHandler:successHandler failHandler:failHandler];
    }
    else if (optionType == ImageRecognitionTypeDetectPlateNumberFromImage) {
        //车牌识别
        [self detectPlateNumberFromImage:controller successHandler:successHandler failHandler:failHandler];
    }
    else if (optionType == ImageRecognitionTypeDetectBusinessLicenseFromImage) {
        //营业执照识别
        [self detectBusinessLicenseFromImage:controller successHandler:successHandler failHandler:failHandler];
    }
    else if (optionType == ImageRecognitionTypeDetectReceiptFromImage) {
        //通用票据识别
        [self detectReceiptFromImage:controller successHandler:successHandler failHandler:failHandler];
    }
}

/**
 * 通用文字识别（基础版、不含位置信息）
 */
-(void)detectTextBasicFromImage:(UIViewController *)controller successHandler:(void (^)(id result, UIImage *image))successHandler failHandler: (void (^)(NSError* err))failHandler {
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

/**
 * 通用文字识别（含位置信息）
 */
-(void)detectTextFromImage:(UIViewController *)controller successHandler:(void (^)(id result, UIImage *image))successHandler failHandler: (void (^)(NSError* err))failHandler {
    UIViewController * aipGeneralVC = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
        NSDictionary *options = @{@"language_type": @"CHN_ENG", @"detect_direction": @"true"};
        [[AipOcrService shardService] detectTextFromImage:image withOptions:options successHandler:^(id result) {
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

/**
 * 通用文字识别（高精度、不含位置信息)
 */
-(void)detectTextAccurateBasicFromImage:(UIViewController *)controller successHandler:(void (^)(id result, UIImage *image))successHandler failHandler: (void (^)(NSError* err))failHandler {
    UIViewController * aipGeneralVC = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
        NSDictionary *options = @{@"language_type": @"CHN_ENG", @"detect_direction": @"true"};
        [[AipOcrService shardService] detectTextAccurateBasicFromImage:image withOptions:options successHandler:^(id result) {
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

/**
 * 通用文字识别（高精度、含位置信息)
 */
-(void)detectTextAccurateFromImage:(UIViewController *)controller successHandler:(void (^)(id result, UIImage *image))successHandler failHandler: (void (^)(NSError* err))failHandler {
    UIViewController * aipGeneralVC = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
        NSDictionary *options = @{@"language_type": @"CHN_ENG", @"detect_direction": @"true"};
        [[AipOcrService shardService] detectTextAccurateFromImage:image withOptions:options successHandler:^(id result) {
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

/**
 * 通用文字识别(含生僻字)
 */
-(void)detectTextEnhancedFromImage:(UIViewController *)controller successHandler:(void (^)(id result, UIImage *image))successHandler failHandler: (void (^)(NSError* err))failHandler {
    UIViewController * aipGeneralVC = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
        NSDictionary *options = @{@"language_type": @"CHN_ENG", @"detect_direction": @"true"};
        [[AipOcrService shardService] detectTextEnhancedFromImage:image withOptions:options successHandler:^(id result) {
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

/**
 * 网图识别
 */
-(void)detectWebImageFromImage:(UIViewController *)controller successHandler:(void (^)(id result, UIImage *image))successHandler failHandler: (void (^)(NSError* err))failHandler {
    UIViewController * aipGeneralVC = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
        [[AipOcrService shardService] detectWebImageFromImage:image withOptions:nil successHandler:^(id result) {
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

/**
 * 身份证正面识别
 */
-(void)detectIdCardFrontFromImage:(UIViewController *)controller successHandler:(void (^)(id result, UIImage *image))successHandler failHandler: (void (^)(NSError* err))failHandler {
    UIViewController *aipGeneralVC = [AipCaptureCardVC ViewControllerWithCardType:CardTypeIdCardFont andImageHandler:^(UIImage *image) {
        [[AipOcrService shardService] detectIdCardFrontFromImage:image withOptions:nil successHandler:^(id result) {
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

/**
 * 身份证背面识别
 */
-(void)detectIdCardBackFromImage:(UIViewController *)controller successHandler:(void (^)(id result, UIImage *image))successHandler failHandler: (void (^)(NSError* err))failHandler {
    UIViewController *aipGeneralVC = [AipCaptureCardVC ViewControllerWithCardType:CardTypeIdCardBack andImageHandler:^(UIImage *image) {
        [[AipOcrService shardService] detectIdCardBackFromImage:image withOptions:nil successHandler:^(id result) {
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

/**
 * 银行卡识别
 */
-(void)detectBankCardFromImag:(UIViewController *)controller successHandler:(void (^)(id result, UIImage *image))successHandler failHandler: (void (^)(NSError* err))failHandler {
    UIViewController *aipGeneralVC = [AipCaptureCardVC ViewControllerWithCardType:CardTypeBankCard andImageHandler:^(UIImage *image) {
        [[AipOcrService shardService] detectBankCardFromImage:image successHandler:^(id result) {
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

/**
 * 驾驶证识别
 */
-(void)detectDrivingLicenseFromImage:(UIViewController *)controller successHandler:(void (^)(id result, UIImage *image))successHandler failHandler: (void (^)(NSError* err))failHandler {
    UIViewController *aipGeneralVC = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
        [[AipOcrService shardService] detectDrivingLicenseFromImage:image withOptions:nil successHandler:^(id result) {
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

/**
 * 行驶证识别
 */
-(void)detectVehicleLicenseFromImage:(UIViewController *)controller successHandler:(void (^)(id result, UIImage *image))successHandler failHandler: (void (^)(NSError* err))failHandler {
    UIViewController *aipGeneralVC = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
        [[AipOcrService shardService] detectVehicleLicenseFromImage:image withOptions:nil successHandler:^(id result) {
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

/**
 * 车牌识别
 */
-(void)detectPlateNumberFromImage:(UIViewController *)controller successHandler:(void (^)(id result, UIImage *image))successHandler failHandler: (void (^)(NSError* err))failHandler {
    UIViewController *aipGeneralVC = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
        [[AipOcrService shardService] detectPlateNumberFromImage:image withOptions:nil successHandler:^(id result) {
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

/**
 * 营业执照识别
 */
-(void)detectBusinessLicenseFromImage:(UIViewController *)controller successHandler:(void (^)(id result, UIImage *image))successHandler failHandler: (void (^)(NSError* err))failHandler {
    UIViewController *aipGeneralVC = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
        [[AipOcrService shardService] detectBusinessLicenseFromImage:image withOptions:nil successHandler:^(id result) {
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

/**
 * 通用票据识别
 */
-(void)detectReceiptFromImage:(UIViewController *)controller successHandler:(void (^)(id result, UIImage *image))successHandler failHandler: (void (^)(NSError* err))failHandler {
    UIViewController *aipGeneralVC = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
        [[AipOcrService shardService] detectReceiptFromImage:image withOptions:nil successHandler:^(id result) {
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

#pragma mark - 单利创建
+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance=[[self alloc] init];
        
        NSLog(@"%@:----创建了",NSStringFromSelector(_cmd));
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (void)destroyInstance {
    onceToken = 0;
    _instance=nil;
}

- (id)copyWithZone:(NSZone *)zone {
    
    return _instance;
}

- (void)dealloc {
    NSLog(@"%@:----释放了",NSStringFromSelector(_cmd));
}

#pragma mark - 图片识别基础配置判断
- (BOOL)isCameraOpen{
    //    iOS 判断应用是否有使用相机的权限
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        return NO;
    }
    return YES;
}
- (BOOL)isPhotoLibraryCanUse{
    //    iOS 判断应用是否有使用相册的权限
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}
- (void)imageSelectAlertMessage:(NSString *)message andVC:(UIViewController *)controller{
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
