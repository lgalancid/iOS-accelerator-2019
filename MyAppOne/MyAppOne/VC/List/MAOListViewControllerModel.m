//
//  MAOListViewControllerModel.m
//  MyAppOne
//
//  Created by Julio Castillo on 10/1/19.
//  Copyright © 2019 iOS-accelerator. All rights reserved.
//

#import "MAOListViewControllerModel.h"

@implementation MAOListViewControllerModel

- (instancetype)initWithDictionary:(NSDictionary *)dicModelo{
    MAOListViewControllerModel *objModelo = [[MAOListViewControllerModel alloc] init];
    objModelo.artistName = dicModelo[@"artistName"];
    objModelo.collectionName = dicModelo[@"collectionName"];
    objModelo.trackName  = dicModelo[@"trackName"];
    objModelo.artistViewUrl = dicModelo[@"artistViewUrl"];
    objModelo.collectionViewUrl = dicModelo[@"collectionViewUrl"];
    objModelo.trackViewUrl = dicModelo[@"trackViewUrl"];
    objModelo.collectionPrice = dicModelo[@"collectionPrice"];
    objModelo.trackPrice = dicModelo[@"trackPrice"];
    objModelo.releaseDate = dicModelo[@"releaseDate"];
    objModelo.artworkUrl100 = dicModelo[@"artworkUrl100"];
    return objModelo;
}

@end
