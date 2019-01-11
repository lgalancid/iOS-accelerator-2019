//
//  MAOInitialViewController.h
//  MyAppOne
//
//  Created by Julio Castillo on 9/1/19.
//  Copyright © 2019 iOS-accelerator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../MAO_service/MAOiTunesAPI.h"
#import "MAOListViewControllerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MAOInitialViewController : UIViewController

-(NSArray<MAOListViewControllerModel *> *) sortByTrack:(NSArray<MAOListViewControllerModel *> *)arrData;

-(NSArray<MAOListViewControllerModel *> *) sortByDate:(NSArray<MAOListViewControllerModel *> *)arrData;

-(NSArray<MAOListViewControllerModel *> *) sortInvertArray:(NSArray<MAOListViewControllerModel *> *)arrData;


@end

NS_ASSUME_NONNULL_END
