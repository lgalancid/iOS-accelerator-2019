//
//  MAOInitialViewController.m
//  MyAppOne
//
//  Created by Julio Castillo on 9/1/19.
//  Copyright © 2019 iOS-accelerator. All rights reserved.
//

#import "MAOInitialViewController.h"
#import "MAOListViewController.h"

@interface MAOInitialViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnCargarDatos;

@end

@implementation MAOInitialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

// Eventos
- (IBAction)onClickSelection:(id)sender {
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        indicator.center = self.view.center;
        [self.view addSubview:indicator];
        [indicator startAnimating];
    });
    
    [[MAOiTunesAPI iTunesServiceInstance]  getResults:^(NSArray *arrData, NSError *errMsg, NSURLResponse *varResponse) {
        if (!errMsg) {
            //NSLog(@"Error: %@", errMsg);
            //NSLog(@"Array: %@", varResponse);
            //NSLog(@"Array: %@", arrData);
            NSMutableArray *arrJSON = NSMutableArray.new;
            for (NSDictionary *dicDatos in [arrData valueForKey:@"results"]) {
                [arrJSON addObject: [MAOListViewControllerModel initWithDictionary:dicDatos]];
            }
            MAOListViewController *objListView = [[MAOListViewController alloc] initWithModel:arrJSON];
                        if (arrData) {
                [self.navigationController pushViewController:objListView animated:false];
            }
        }
        else {
            NSLog(@"%@", errMsg);
            UIAlertController* msgBox = [UIAlertController alertControllerWithTitle:errMsg.localizedFailureReason message:errMsg.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
            [msgBox addAction:defaultAction];
            [self presentViewController:msgBox animated:YES completion:nil];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            sleep(1);
            [indicator stopAnimating];
        });

    }];

    
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

@end
