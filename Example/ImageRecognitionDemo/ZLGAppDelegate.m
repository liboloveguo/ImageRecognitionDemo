//
//  ZLGAppDelegate.m
//  ImageRecognitionDemo
//
//  Created by 张利果 on 12/03/2018.
//  Copyright (c) 2018 张利果. All rights reserved.
//
//#import <ImageRecognitionDemo/ImageRecognitionDemo.h>
#import "ZLGAppDelegate.h"
#import "ImageRecognition.h"
@implementation ZLGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [ImageRecognition authWithAK:@"Hr3FEBCnvN53HnoPBhGzczDv" andSK:@"7YP7Vs6ImUtCOLbz95TUlO3LjnbYfC2H"];
    [ImageRecognition imageRecognitionGeneralBasicImage:[UIImage imageNamed:@"图片"] successHandler:^(id result, UIImage *image) {
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

        NSLog(@"%@",message);

    } failHandler:^(NSError *err) {
        NSLog(@"%@",err);
    }];

    
//    [XXXXX setappkey:string];
//    [XXXXX prosssImage:UIImage comptiong: string{
//
//
//    }]
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
