//
//  MAOiTunesAPI.m
//  MyAppOne
//
//  Created by Lautaro Emanuel Galan Cid on 10/01/2019.
//  Copyright © 2019 iOS-accelerator. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MAOiTunesAPI.h"
#import "../Constants.h"
@implementation MAOiTunesAPI
-(void) getResults:(void(^)(NSArray *arrData, NSError *errMsg, NSURLResponse *varResponse)) callBack {
    
   NSURLSessionConfiguration *cfgSesion = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *varSesion = [NSURLSession sessionWithConfiguration: cfgSesion delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *urlAPI = [NSURL URLWithString:iAPISEARCHRESULTURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlAPI];
    
    [[varSesion dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
      {
          if (error) {
              NSLog(@"Respuesta: %@ - Error: %@", response, error);
          }
          
          NSArray *arrJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
          callBack(arrJson, error, response);
      }
      ]resume];
}

+(MAOiTunesAPI *) iTunesServiceInstance {
    static MAOiTunesAPI *_Instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _Instance = [[MAOiTunesAPI alloc] init];
    });
    
    return _Instance;
}

    

@end
