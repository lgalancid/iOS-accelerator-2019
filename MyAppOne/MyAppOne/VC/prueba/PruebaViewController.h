//
//  PruebaViewController.h
//  MyAppOne
//
//  Created by Lautaro Emanuel Galan Cid on 17/01/2019.
//  Copyright © 2019 iOS-accelerator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAOListViewControllerModel.h"
#import "pruebaTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface PruebaViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) NSArray<MAOListViewControllerModel *> *arrDatos;

@property (strong, nonatomic) IBOutlet UITableView *tabCustom;


-(instancetype) initWithModel: (NSArray<MAOListViewControllerModel *> *)arrDatos;

@end

NS_ASSUME_NONNULL_END
