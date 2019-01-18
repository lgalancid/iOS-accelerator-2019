//
//  pruebaTableViewCell.h
//  MyAppOne
//
//  Created by Lautaro Emanuel Galan Cid on 17/01/2019.
//  Copyright © 2019 iOS-accelerator. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface pruebaTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *vcContenedor;
@property (strong, nonatomic) IBOutlet UILabel *lblAlbumName;
@property (strong, nonatomic) IBOutlet UILabel *lblTrackName;
@property (strong, nonatomic) IBOutlet UIImageView *imgAlbumCover;

@end

NS_ASSUME_NONNULL_END
