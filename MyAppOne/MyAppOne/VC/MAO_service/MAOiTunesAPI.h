//
//  MAOiTunesAPI.h
//  MyAppOne
//
//  Created by Lautaro Emanuel Galan Cid on 10/01/2019.
//  Copyright © 2019 iOS-accelerator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAOiTunesAPI : NSObject

+(MAOiTunesAPI *) iTunesServiceInstance;

-(void) getResults:(void(^)(NSArray *arrData, NSError *errMsg, NSURLResponse *varResponse)) completionBlock;

@end
