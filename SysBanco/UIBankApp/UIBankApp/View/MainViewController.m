//
//  MainViewController.m
//  UIBankApp
//
//  Created by Lautaro Emanuel Galan Cid on 01/02/2019.
//  Copyright © 2019 Lautaro Emanuel Galán Cid. All rights reserved.
//

#import "MainViewController.h"
#import "APIBankApp-Swift.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *selectGestion;

@property (weak, nonatomic) IBOutlet UITextField *txtMonto;

@property (weak, nonatomic) IBOutlet UIButton *btnAceptar;
@property (weak, nonatomic) IBOutlet UILabel *lblSaldo;
@property (weak, nonatomic) IBOutlet UILabel *lblDescubierto;
@property (weak, nonatomic) IBOutlet UILabel *lblNombreCliente;

@end

NSUInteger valorGestion;

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fnSetup];
}

-(void)fnSetup {
    
    _txtMonto.delegate = self;
    valorGestion = 0;
    AccountManagement *accMan = AccountManagement.new;
    
    [accMan setClient];
    
    double balance = [accMan getBalanceWithParIdClient:1];
    double overdraw = [accMan getOverdrawWithParIdClient:1];
    
    NSString *clientName = [accMan getClientDataWithParIdClient:1];
    _lblNombreCliente.text = clientName;
    
    _lblSaldo.text =
    [NSString stringWithFormat:@"Saldo actual: %.2f",balance];
    
    _lblDescubierto.text =
    [NSString stringWithFormat:@"Descubierto disponible: %.2f",overdraw];
    
    _txtMonto.keyboardType = UIKeyboardTypeDecimalPad;
    
}
-(void)fnRefresh{
    AccountManagement *accMan = AccountManagement.new;
    BOOL negativo = NO;
    double balance = [accMan getBalanceWithParIdClient:1];
    double overdraw = [accMan getOverdrawWithParIdClient:1];
    
    if (balance <0 ) {
        _lblSaldo.textColor = [UIColor redColor];
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
    [self fnRefresh];
}
-(void)fnDepositar{
    AccountMovement *accMov = AccountMovement.new;
    double monto = [_txtMonto.text doubleValue];
    [accMov DepositWithParIdCuenta:1 parMonto:monto];
    [self fnRefresh];
}

@end
