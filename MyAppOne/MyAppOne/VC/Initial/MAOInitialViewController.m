//
//  MAOInitialViewController.m
//  MyAppOne
//
//  Created by Julio Castillo on 9/1/19.
//  Copyright © 2019 iOS-accelerator. All rights reserved.
//
#import "MAOInitialViewController.h"
#import "MAOListViewController.h"
#import "PruebaViewController.h"

@interface MAOInitialViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnCargarDatos;
@property (weak, nonatomic) IBOutlet UIButton *btnCargarXTrackId;
@property (weak, nonatomic) IBOutlet UIButton *btnCargarXFecha;
@property (weak, nonatomic) IBOutlet UIButton *btnCargarInvertido;
@end

@implementation MAOInitialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)getData:(NSInteger)parGetType
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator startAnimating];
    [[MAOiTunesAPI iTunesServiceInstance] getResults:^(NSArray *arrData, NSError *errMsg, NSURLResponse *varResponse) {
        if (!errMsg) {
            //NSLog(@"Error: %@", errMsg);
            //NSLog(@"Array: %@", varResponse);
            //NSLog(@"Array: %@", arrData);
            NSMutableArray *arrJSON = NSMutableArray.new;
            for (NSDictionary *dicDatos in [arrData valueForKey:@"results"]) {
                
                MAOListViewControllerModel *objModel = MAOListViewControllerModel.new;
                
                [arrJSON addObject: [objModel initWithDictionary:dicDatos]];
            }
            NSArray *arrJSONProcesado = NSMutableArray.new;
            switch (parGetType) {
                case 1:
                    arrJSONProcesado = arrJSON;
                    break;
                case 2:
                    arrJSONProcesado = [self sortByTrack:arrJSON];
                    break;
                case 3:
                    arrJSONProcesado = [self sortByDate:arrJSON];
                    break;
                case 4:
                    arrJSONProcesado = [self sortInvertArray:arrJSON];
                    break;
                default:
                    break;
            }
            
//            MAOViewController *objViewController = [[MAOViewController alloc] initWithModel:arrJSONProcesado];
            
            PruebaViewController *prueba = [[PruebaViewController alloc] initWithModel: arrJSONProcesado];
            if (arrData) {
                [self.navigationController pushViewController:prueba animated:YES];
            }
        }
        else {
            NSLog(@"%@", errMsg);
            NSString *errCode = [[NSString alloc]initWithFormat:@"Error Nº %lid", errMsg.code];
            UIAlertController* msgBox = [UIAlertController alertControllerWithTitle:errCode message:errMsg.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
            [msgBox addAction:defaultAction];
            [self presentViewController:msgBox animated:YES completion:nil];
        }
        sleep(.5);
        [indicator stopAnimating];
    }];
    
    //
    //
    //
}

// Eventos
- (IBAction)onClickSelection:(id)sender {
    [self getData:1];
    // TODO
    // ACA BUSCAMOS LA DATA DEL SERVER Y AVANZAMOS AL PROXIMO VC CUANDO YA LA TENGAMOS PROCESADA
    // 1-  Request al server (URL: https://itunes.apple.com/search?term=jack+johnson)
    // 2 - Parser del response
    // 3 - Crecion del modelo del VC 2
    // 4 - Iniciar el vc 2 con el modelo
    //-------------------------------------------
    //NTH:
    // Manejo de errores en el request.
    // Mostrar mensaje mientras carga.
    // Mensajes de alerta.
}
- (IBAction)byTrackId:(UIButton *)sender {
    [self getData:2];
}

- (IBAction)byLaunchDate:(id)sender {
    [self getData:3];
}

- (IBAction)InvertSort:(id)sender {
    [self getData:4];
}

- (NSArray<MAOListViewControllerModel *> *)sortByTrack:(NSArray<MAOListViewControllerModel *> *)arrData{
    NSArray *arrOrdered;
    arrOrdered = [arrData sortedArrayUsingComparator:^NSComparisonResult(MAOListViewControllerModel *a, MAOListViewControllerModel *b) {
        NSString *first = [a trackName];
        NSString *second = [b trackName];
        return [first compare:second];
    }];
    return arrOrdered;
}

- (NSArray<MAOListViewControllerModel *> *)sortByDate:(NSArray<MAOListViewControllerModel *> *)arrData{
    NSArray *arrOrdered;
    arrOrdered = [arrData sortedArrayUsingComparator:^NSComparisonResult(MAOListViewControllerModel *a, MAOListViewControllerModel *b) {
        NSDate *first = [a releaseDate];
        NSDate *second = [b releaseDate];
        return [first compare:second];
    }];
    return arrOrdered;
}

- (NSArray<MAOListViewControllerModel *> *)sortInvertArray:(NSArray<MAOListViewControllerModel *> *)arrData
{
    NSArray *arrOrdered;
    arrOrdered = [[arrData reverseObjectEnumerator] allObjects];
    return arrOrdered;
}

@end
