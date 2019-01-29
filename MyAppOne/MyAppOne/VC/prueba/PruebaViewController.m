//
//  PruebaViewController.m
//  MyAppOne
//
//  Created by Lautaro Emanuel Galan Cid on 17/01/2019.
//  Copyright © 2019 iOS-accelerator. All rights reserved.
//

#import "PruebaViewController.h"
#import "MAOModalVC.h"
@interface PruebaViewController ()

@end

@implementation PruebaViewController

-(instancetype)initWithModel:(NSArray<MAOListViewControllerModel *> *)arrDatos{
    self = [super init];
    if (self) {
        self.arrDatos=arrDatos;
    }
    return self;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    pruebaTableViewCell *objCeldaContenedora = pruebaTableViewCell.new;
    
    // obtener altura definida
    
//    return 208;
   // return UITableViewAutomaticDimension;
    return ((pruebaTableViewCell *) [[NSBundle mainBundle] loadNibNamed:@"pruebaTableViewCell" owner:self options:nil].lastObject).frame.size.height;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabCustom.delegate = self;
    self.tabCustom.dataSource = self;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrDatos.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (nonnull UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *varIdCelda = @"idCelda";
    pruebaTableViewCell *cellCustom = (pruebaTableViewCell*) [tableView dequeueReusableCellWithIdentifier:varIdCelda];
    
    if (cellCustom == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"pruebaTableViewCell" owner:self options:nil];
        cellCustom =  [nib objectAtIndex:0]; 
    }
    cellCustom.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cellCustom.lblTrackName.text = [NSString stringWithFormat:@"%@", [[self.arrDatos objectAtIndex:indexPath.row]trackName]];

    cellCustom.lblAlbumName.text = [NSString stringWithFormat:@"%@", [[self.arrDatos objectAtIndex:indexPath.row]collectionName]];


    dispatch_queue_t dispatchImage = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);

    dispatch_async(dispatchImage, ^{

        NSURL *varURL = [NSURL URLWithString:[[self.arrDatos objectAtIndex:[indexPath row]] artworkUrl100]];

        NSData *varAlbumCover = [NSData dataWithContentsOfURL:varURL];
        dispatch_async(dispatch_get_main_queue(), ^{

            cellCustom.imgAlbumCover.image = [UIImage imageWithData:varAlbumCover];
        });
    });
    return cellCustom;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MAOListViewControllerModel *modelo = [self.arrDatos objectAtIndex:indexPath.row];
    MAOModalVC *objModal = [[MAOModalVC alloc] initWithModel:modelo];
//
//    objModal.varTrackName = modelo.trackName;
//    objModal.varArtistName = modelo.artistName;
//    objModal.varCollectionName = modelo.collectionName;
//    objModal.varTrackPrice = modelo.trackPrice;
//    objModal.varAlbumCover = modelo.artworkUrl100;
    
    objModal.modalPresentationStyle = UIModalPresentationOverFullScreen;
    objModal.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:objModal animated:YES completion:nil];

}


@end
