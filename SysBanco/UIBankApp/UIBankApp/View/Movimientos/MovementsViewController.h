//
//  MovementsViewController.h
//  UIBankApp
//
//  Created by Lautaro Emanuel Galan Cid on 03/02/2019.
//  Copyright © 2019 Lautaro Emanuel Galán Cid. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovementsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
-(instancetype) initWithModel: (NSArray*)arrDatos;

@end

NS_ASSUME_NONNULL_END
