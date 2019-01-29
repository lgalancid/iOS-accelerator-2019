//
//  MAOModalVC.m
//  MyAppOne
//
//  Created by Lautaro Emanuel Galan Cid on 18/01/2019.
//  Copyright © 2019 iOS-accelerator. All rights reserved.
//

#import "MAOModalVC.h"

@interface MAOModalVC ()
@property (strong, nonatomic) IBOutlet UIView *viewContenedor;
@property (strong, nonatomic) IBOutlet UILabel *lblTrackName;
@property (strong, nonatomic) IBOutlet UILabel *lblCollectionName;
@property (strong, nonatomic) IBOutlet UILabel *lblArtistName;
@property (strong, nonatomic) IBOutlet UILabel *lblTrackPrice;
@property (strong, nonatomic) IBOutlet UIImageView *imgAlbumCover;

@property (strong, nonatomic) MAOListViewControllerModel *objModelo;

@end

@implementation MAOModalVC

- (void)viewDidLoad {

    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.50];
    
    self.viewContenedor.layer.cornerRadius = 10.0;
    self.lblTrackName.text = self.objModelo.trackName;
    self.lblArtistName.text = self.objModelo.artistName;
    self.lblTrackPrice.text = [NSString stringWithFormat:@"Precio: u$ %@", self.objModelo.trackPrice];
    self.lblCollectionName.text = self.objModelo.collectionName;
    dispatch_queue_t dispatchImage = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    dispatch_async(dispatchImage, ^{
        
        NSURL *varURL = [NSURL URLWithString:self.objModelo.artworkUrl100];
        
        NSData *varAlbumCover = [NSData dataWithContentsOfURL:varURL];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.imgAlbumCover.image = [UIImage imageWithData:varAlbumCover];
        });
    });
    
//    self.lblTrackName.text = self.varTrackName;
//    self.lblArtistName.text = self.varArtistName;
//    self.lblTrackPrice.text = [NSString stringWithFormat:@"Precio: u$ %@", self.varTrackPrice];
//    self.lblCollectionName.text = self.varCollectionName;
//    dispatch_queue_t dispatchImage = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
//
//    dispatch_async(dispatchImage, ^{
//
//        NSURL *varURL = [NSURL URLWithString:self.varAlbumCover];
//
//        NSData *varAlbumCover = [NSData dataWithContentsOfURL:varURL];
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            self.imgAlbumCover.image = [UIImage imageWithData:varAlbumCover];
//        });
//    });
}

-(instancetype) initWithModel:(MAOListViewControllerModel *)objModelo{
    [super viewDidLoad];
    _objModelo = objModelo;
    return self;
}

- (IBAction)didClickBtnAceptar:(UIButton *)sender {
    NSURL *varURL = [NSURL URLWithString:_objModelo.trackViewUrl];

    NSLog(@"%@", _objModelo.trackViewUrl);
    [[UIApplication sharedApplication]openURL:varURL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"OK");
        }
    }];
}

- (IBAction)didClickBtnAnterior:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if(touches.anyObject.view != self.viewContenedor ) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
