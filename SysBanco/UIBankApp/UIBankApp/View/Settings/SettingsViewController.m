//
//  SettingsViewController.m
//  UIBankApp
//
//  Created by Lautaro Emanuel Galan Cid on 02/02/2019.
//  Copyright © 2019 Lautaro Emanuel Galán Cid. All rights reserved.
//

#import "SettingsViewController.h"
#import "APIBankApp-Swift.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *selectColorNegativos;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupParameters];
}

-(void)setupParameters{
    AppSettings *AppSets = AppSettings.new;
    NSString *negColor = AppSets.getNegativeColor;
    if ([negColor  isEqual: @"Rojo"]) {
        _selectColorNegativos.selectedSegmentIndex = 0;
    }
    else if ([negColor  isEqual: @"Verde"]) {
        _selectColorNegativos.selectedSegmentIndex = 1;
    }
    else if ([negColor  isEqual: @"Azul"]) {
        _selectColorNegativos.selectedSegmentIndex = 2;
    }
    else if ([negColor  isEqual: @"Amarillo"]) {
        _selectColorNegativos.selectedSegmentIndex = 3;
    }

}

- (IBAction)selectColorNegativosCambio:(UISegmentedControl *)sender {
    AppSettings *AppSets = AppSettings.new;
    if (_selectColorNegativos.selectedSegmentIndex == 0) {
        [AppSets setNegativeColorWithParColor:@"Rojo"];
    }
    else if (_selectColorNegativos.selectedSegmentIndex == 1) {
        [AppSets setNegativeColorWithParColor:@"Verde"];
    }
    else if (_selectColorNegativos.selectedSegmentIndex == 2) {
        [AppSets setNegativeColorWithParColor:@"Azul"];
    }
    else if (_selectColorNegativos.selectedSegmentIndex == 3) {
        [AppSets setNegativeColorWithParColor:@"Amarillo"];
    }
}

- (IBAction)btnRegresarClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
