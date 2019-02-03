//
//  MainViewController.m
//  UIBankApp
//
//  Created by Lautaro Emanuel Galan Cid on 01/02/2019.
//  Copyright © 2019 Lautaro Emanuel Galán Cid. All rights reserved.
//

#import "MainViewController.h"
#import "APIBankApp-Swift.h"
#import "Settings/SettingsViewController.h"
#import "Movimientos/MovementsViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *selectGestion;

@property (weak, nonatomic) IBOutlet UITextField *txtMonto;

@property (weak, nonatomic) IBOutlet UIButton *btnAceptar;
@property (weak, nonatomic) IBOutlet UILabel *lblSaldo;
@property (weak, nonatomic) IBOutlet UILabel *lblDescubierto;
@property (weak, nonatomic) IBOutlet UILabel *lblNombreCliente;
@property (weak, nonatomic) IBOutlet UIButton *btnMovimientos;

@end

NSUInteger valorGestion;

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fnSetup];
}

- (void)viewWillAppear:(BOOL)animated{
    [self fnRefresh];
}

-(void)fnSetup {
    _txtMonto.delegate = self;
    valorGestion = 0;
    AccountManagement *accMan = AccountManagement.new;
    
    NSString *clientName = [accMan getClientDataWithParIdClient:1];
    _lblNombreCliente.text = clientName;
    
    _txtMonto.keyboardType = UIKeyboardTypeDecimalPad;
    [self fnCargarDatosBancarios];
}

-(void)fnRefresh{
    AccountManagement *accMan = AccountManagement.new;
    double balance = [accMan getBalanceWithParIdClient:1];
    if (balance <0) {
        [self fnCargarColorNegativo];
    }
}

-(void)fnCargarColorNegativo{
    AppSettings *AppSets = AppSettings.new;
    NSString *negColor = AppSets.getNegativeColor;
    if ([negColor  isEqual: @"Rojo"]) {
        _lblSaldo.textColor = [UIColor redColor];
    }
    else if ([negColor  isEqual: @"Verde"]) {
        _lblSaldo.textColor = [UIColor greenColor];
    }
    else if ([negColor  isEqual: @"Azul"]) {
        _lblSaldo.textColor = [UIColor blueColor];
    }
    else if ([negColor  isEqual: @"Amarillo"]) {
        _lblSaldo.textColor = [UIColor yellowColor];
    }
}

-(void)fnCargarDatosBancarios{
    AccountManagement *accMan = AccountManagement.new;
    
    NSInteger movimientos = [accMan getTransactionsCountWithParIdClient:1];
    if (movimientos < 1) {
        _btnMovimientos.enabled = NO;
    }
    else {
        _btnMovimientos.enabled = YES;
    }
    BOOL negativo = NO;
    double balance = [accMan getBalanceWithParIdClient:1];
    double overdraw = [accMan getOverdrawWithParIdClient:1];
    
    if (balance <0 ) {
        [self fnCargarColorNegativo];
        negativo = YES;
    }
    else
    {
        _lblSaldo.textColor = [UIColor blackColor];
        negativo = NO;
    }
    
    if (!negativo) {
        _lblSaldo.text =
        [NSString stringWithFormat:@"Saldo actual: $%.2f",balance];
    }
    else{
        _lblSaldo.text =
        [NSString stringWithFormat:@"Saldo actual: ($%.2f)",balance];
    }
    _lblDescubierto.text =
    [NSString stringWithFormat:@"Descubierto disponible: $%.2f",overdraw];
    _txtMonto.text = @"";
    
}

- (IBAction)selectGestionCambio:(UISegmentedControl *)sender {
    _txtMonto.text = @"";
    valorGestion = [_selectGestion selectedSegmentIndex];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *nuevoMonto = [_txtMonto.text stringByReplacingCharactersInRange:range withString:string];
    NSArray *separador = [nuevoMonto componentsSeparatedByString:@"."];
    
// Maximo monto
    if (separador.count > 0)
    {
        NSString *maximoMonto = separador[0];
        if (maximoMonto.length > 6)
            return NO;
    }
// Dos digitos decimales
    if (separador.count > 1)
    {
        NSString *maximoDecimales = separador[1];
        if (maximoDecimales.length > 2)
            return NO;
    }
    
// Un solo punto decimal
    if (separador.count > 2)
        return NO;

// Maximo de caracteres y solo numeros y una coma decimal
    if (_txtMonto.text.length < 9) {
        NSCharacterSet *setNumerosDecimales = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
        NSString *filtrado = [[string componentsSeparatedByCharactersInSet:setNumerosDecimales] componentsJoinedByString:@""];
        return [string isEqualToString:filtrado];
    }
    else
    {
        if (range.length > 0)
        {
            return true;
        }
        else{
            return false;
        }
    }
}

- (IBAction)btnAceptarClick:(UIButton *)sender {
    switch (valorGestion) {
        case 0:
            [self fnExtraer];
            break;
        case 1:
            [self fnDepositar];
            break;
        default:
            break;
    }
}

-(void)fnExtraer{
    AccountMovement *accMov = AccountMovement.new;
    double monto = [_txtMonto.text doubleValue];
    [accMov WithdrawWithParIdCuenta:1 parMonto:monto];
    [self fnCargarDatosBancarios];
}

-(void)fnDepositar{
    AccountMovement *accMov = AccountMovement.new;
    double monto = [_txtMonto.text doubleValue];
    [accMov DepositWithParIdCuenta:1 parMonto:monto];
    [self fnCargarDatosBancarios];
}

- (IBAction)btnVerMovimientosClick:(UIButton *)sender {
    AccountManagement *accMan = AccountManagement.new;
    NSArray *arrMovimientos = [accMan getTransactionsWithParIdClient:1];
    
    MovementsViewController *movTVC = [[MovementsViewController alloc] initWithModel: arrMovimientos];
    
    [self showViewController:movTVC sender:nil];
    


}

- (IBAction)btnPreferenciasClick:(UIButton *)sender {
    SettingsViewController *settings = [[SettingsViewController alloc]init];
    settings.providesPresentationContextTransitionStyle = YES;
    settings.definesPresentationContext = YES;
    [settings setModalPresentationStyle:UIModalPresentationCurrentContext];
    [self showViewController:settings sender:nil];
}

@end
