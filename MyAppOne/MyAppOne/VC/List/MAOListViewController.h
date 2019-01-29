//
//  MAOListViewController.h
//  MyAppOne
//
//  Created by Julio Castillo on 9/1/19.
//  Copyright © 2019 iOS-accelerator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAOListViewControllerModel.h"



@interface MAOListViewController : UIViewController

- (instancetype) initWithModel:( NSArray<MAOListViewControllerModel *> *) arrayModels;

@end


