//
//  MELINetworking.h
//  Pods
//
//  Created by Lautaro Emanuel Galan Cid on 30/01/2019.
//

#import <Foundation/Foundation.h>

@interface MELINetworking : NSObject

-(void) getDatosAPI:(NSString *)parURL
callback: (void(^)(NSData *data, NSURLResponse *urlResponse, NSError* error))callback;

-(void)getImagenURL:(NSString *)parURL
callback:(void (^)(UIImage *))callback;

@end
