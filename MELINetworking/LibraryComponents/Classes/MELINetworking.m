//
//  MELINetworking.m
//  Pods
//
//  Created by Lautaro Emanuel Galan Cid on 30/01/2019.
//

#import "MELINetworking.h"

@implementation MELINetworking

-(void) getDatosAPI:(NSString *)parURL callback:
(void(^)(NSData *data, NSURLResponse *urlResponse, NSError *error))callback{
    
    dispatch_queue_t queueGlobal = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queueGlobal, ^{
        NSURLSessionConfiguration *sesionCfg = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *sesion = [NSURLSession sessionWithConfiguration: sesionCfg delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        NSURL *dataURL = [NSURL URLWithString:parURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:dataURL];
        [[sesion dataTaskWithRequest:request completionHandler:^void (NSData *data, NSURLResponse *urlResponse, NSError *error){
                callback(data, urlResponse, error);
        }]
         resume];
    });
}

-(void)getImagenURL:(NSString *)parURL callback:(void (^)(UIImage *))callback{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:parURL]];
        dispatch_async(dispatch_get_main_queue(), ^{
            callback([UIImage imageWithData:data]);
        });
    });
}

@end
