//
//  MAOModalVC.h
//  MyAppOne
//
//  Created by Lautaro Emanuel Galan Cid on 18/01/2019.
//  Copyright © 2019 iOS-accelerator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAOListViewControllerModel.h"


@interface MAOModalVC : UIViewController

@property NSString *varTrackName;
@property NSString *varCollectionName;
@property NSString *varArtistName;
@property NSNumber *varTrackPrice;
@property NSString *varAlbumCover;

-(instancetype)initWithModel:(MAOListViewControllerModel *)objModelo;

@end
