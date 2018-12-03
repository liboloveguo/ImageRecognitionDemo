//
//  ImageRecognition.h
//  ImageRecognitionDemo
//
//  Created by 张利果 on 2018/12/3.
//  Copyright © 2018年 张利果. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,ImageRecognitionType)
{
    ImageRecognitionTypeDetectTextBasicFromImage,//通用文字识别（基础版、不含位置信息）
    ImageRecognitionTypeDetectTextFromImage,//通用文字识别（含位置信息）
    ImageRecognitionTypeDetectTextAccurateBasicFromImage,//通用文字识别（高精度、不含位置信息)
    ImageRecognitionTypeDetectTextAccurateFromImage,//通用文字识别（高精度、含位置信息)
    ImageRecognitionTypeDetectTextEnhancedFromImage,//通用文字识别(含生僻字)
    ImageRecognitionTypeDetectWebImageFromImage,//网图识别
    ImageRecognitionTypeDetectIdCardFrontFromImage,//身份证正面识别
    ImageRecognitionTypeDetectIdCardBackFromImage,//身份证背面识别
    ImageRecognitionTypeDetectBankCardFromImage,//银行卡识别
    ImageRecognitionTypeDetectDrivingLicenseFromImage,//驾驶证识别
    ImageRecognitionTypeDetectVehicleLicenseFromImage,//行驶证识别
    ImageRecognitionTypeDetectPlateNumberFromImage,//车牌识别
    ImageRecognitionTypeDetectBusinessLicenseFromImage,//营业执照识别
    ImageRecognitionTypeDetectReceiptFromImage,//通用票据识别
};

@interface ImageRecognition : NSObject

-(void)imageRecognitionGeneralBasicVC:(UIViewController *)controller imageRecognitionType:(ImageRecognitionType)options successHandler:(void (^)(id result, UIImage *image))successHandler failHandler: (void (^)(NSError* err))failHandler;

/*!**生成单例***/
+ (instancetype)sharedInstance;

/*!**销毁单例***/
+ (void)destroyInstance;

@end
