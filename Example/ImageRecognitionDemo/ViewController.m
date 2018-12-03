//
//  ViewController.m
//  ImageRecognitionDemo
//
//  Created by 张利果 on 2018/11/21.
//  Copyright © 2018年 张利果. All rights reserved.
//
#import "InfoDisplayViewController.h"
#import <AipOcrSdk/AipOcrSdk.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "ImageRecognition.h"
#import "ViewController.h"

@interface ViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *dataList;
@property (nonatomic, strong) NSMutableArray<NSArray<NSString *> *> *actionList;
@property (nonatomic,strong) UIImage *images;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[AipOcrService shardService] authWithAK:@"Hr3FEBCnvN53HnoPBhGzczDv" andSK:@"7YP7Vs6ImUtCOLbz95TUlO3LjnbYfC2H"];
    //
    self.actionList = [NSMutableArray array];
    
    [self.actionList addObject:@[@"通用文字识别（基础版、不含位置信息）", @"detectTextBasicFromImage"]];
    [self.actionList addObject:@[@"通用文字识别（含位置信息版）", @"detectTextFromImage"]];
    [self.actionList addObject:@[@"通用文字识别（高精度、不含位置）", @"detectTextAccurateBasicFromImage"]];
    [self.actionList addObject:@[@"通用文字识别（高精度含位置）", @"detectTextAccurateFromImage"]];
    [self.actionList addObject:@[@"通用文字识别（含生僻字）", @"detectTextEnhancedFromImage"]];
    [self.actionList addObject:@[@"网络图片文字识别", @"detectWebImageFromImage"]];
    [self.actionList addObject:@[@"身份证正面拍照识别", @"detectIdCardFrontFromImage"]];
    [self.actionList addObject:@[@"身份证反面拍照识别", @"detectIdCardBackFromImage"]];
    [self.actionList addObject:@[@"银行卡正面拍照识别", @"detectBankCardFromImage"]];
    [self.actionList addObject:@[@"驾驶证识别", @"detectDrivingLicenseFromImage"]];
    [self.actionList addObject:@[@"行驶证识别", @"detectVehicleLicenseFromImage"]];
    [self.actionList addObject:@[@"车牌识别", @"detectPlateNumberFromImage"]];
    [self.actionList addObject:@[@"营业执照识别", @"detectBusinessLicenseFromImage"]];
    [self.actionList addObject:@[@"票据识别", @"detectReceiptFromImag"]];
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if (error) {
        
        NSLog(@"保存失败");
    }
    else  {
        NSLog(@"保存成功");
    }
    
}

#pragma mark - OCR识别返回结果处理
-(void)imageRecognitionType:(ImageRecognitionType)selectType {
    __weak typeof(self) weakSelf = self;
    [[ImageRecognition sharedInstance] imageRecognitionGeneralBasicVC:self imageRecognitionType:selectType successHandler:^(id result, UIImage *image) {
        
        //保存图片到系统相册
//        UIImageWriteToSavedPhotosAlbum( image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            
            //1,保存图片到系统相册
            [PHAssetChangeRequest creationRequestForAssetFromImage:image];
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            
            if (!success) return ;
            NSLog(@"保存成功");
        }];
        
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
            //到主线程处理
            if (message.length>0) {
                InfoDisplayViewController *vc = [InfoDisplayViewController controller];
                vc.image = image;
                vc.info = message;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
            else{
                //识别无内容
                [[[UIAlertView alloc] initWithTitle:nil message:@"图片内容空空如也～～" delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
            }
            
        }];
        
        
    } failHandler:^(NSError *error) {
        //识别失败
        NSString *msg = [NSString stringWithFormat:@"%li:%@", (long)[error code], [error localizedDescription]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"%@",error);
            [[[UIAlertView alloc] initWithTitle:@"识别失败" message:msg delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        }];
        
    }];
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.actionList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.actionList[indexPath.row][0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ImageRecognitionType type=0;
    if ([self.actionList[indexPath.row][1] isEqualToString:@"通用文字识别（基础版、不含位置信息）"]) {
        type = ImageRecognitionTypeDetectTextBasicFromImage;
    }
    else if ([self.actionList[indexPath.row][1] isEqualToString:@"通用文字识别（含位置信息版）"]) {
        type = ImageRecognitionTypeDetectTextFromImage;
    }
    else if ([self.actionList[indexPath.row][1] isEqualToString:@"通用文字识别（高精度、不含位置）"]) {
        type = ImageRecognitionTypeDetectTextAccurateBasicFromImage;
    }
    else if ([self.actionList[indexPath.row][1] isEqualToString:@"通用文字识别（高精度含位置）"]) {
        type = ImageRecognitionTypeDetectTextAccurateFromImage;
    }
    else if ([self.actionList[indexPath.row][1] isEqualToString:@"通用文字识别（含生僻字）"]) {
        type = ImageRecognitionTypeDetectTextEnhancedFromImage;
    }
    else if ([self.actionList[indexPath.row][1] isEqualToString:@"网络图片文字识别"]) {
        type = ImageRecognitionTypeDetectWebImageFromImage;
    }
    else if ([self.actionList[indexPath.row][1] isEqualToString:@"身份证正面拍照识别"]) {
        type = ImageRecognitionTypeDetectIdCardFrontFromImage;
    }
    else if ([self.actionList[indexPath.row][1] isEqualToString:@"身份证反面拍照识别"]) {
        type = ImageRecognitionTypeDetectIdCardBackFromImage;
    }
    else if ([self.actionList[indexPath.row][1] isEqualToString:@"银行卡正面拍照识别"]) {
        type = ImageRecognitionTypeDetectBankCardFromImage;
    }
    else if ([self.actionList[indexPath.row][1] isEqualToString:@"驾驶证识别"]) {
        type = ImageRecognitionTypeDetectDrivingLicenseFromImage;
    }
    else if ([self.actionList[indexPath.row][1] isEqualToString:@"行驶证识别"]) {
        type = ImageRecognitionTypeDetectVehicleLicenseFromImage;
    }
    else if ([self.actionList[indexPath.row][1] isEqualToString:@"车牌识别"]) {
        type = ImageRecognitionTypeDetectPlateNumberFromImage;
    }
    else if ([self.actionList[indexPath.row][1] isEqualToString:@"营业执照识别"]) {
        type = ImageRecognitionTypeDetectBusinessLicenseFromImage;
    }
    else if ([self.actionList[indexPath.row][1] isEqualToString:@"票据识别"]) {
        type = ImageRecognitionTypeDetectReceiptFromImage;
    }
    [self imageRecognitionType:type];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

@end
