//
//  MovementsViewController.m
//  UIBankApp
//
//  Created by Lautaro Emanuel Galan Cid on 03/02/2019.
//  Copyright © 2019 Lautaro Emanuel Galán Cid. All rights reserved.
//

#import "MovementsViewController.h"
#import "APIBankApp-Swift.h"
#import "MovementTableViewCell.h"

@interface MovementsViewController ()

@property (strong, nonatomic) NSArray *arrDatos;

@property (weak, nonatomic) IBOutlet UITableView *tableMovimientos;

@end

@implementation MovementsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableMovimientos.delegate = self;
    self.tableMovimientos.dataSource = self;
}

- (IBAction)btnRegresarClick:(UIButton *)sender {
        [self dismissViewControllerAnimated:YES completion:nil];
}

-(instancetype)initWithModel:(NSArray*)parArrDatos{
    self = [super init];
    if (self) {
        self.arrDatos = parArrDatos;
        
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    AccountManagement *accMan = AccountManagement.new;
    return [accMan getTransactionsCountWithParIdClient:1];
}

- (nonnull UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *varIdCelda = @"idCelda";
    MovementTableViewCell *cellCustom = (MovementTableViewCell*) [tableView dequeueReusableCellWithIdentifier:varIdCelda];
    if (cellCustom == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MovementTableViewCell" owner:self options:nil];
        cellCustom =  [nib objectAtIndex:0];
    }
    cellCustom.selectionStyle = UITableViewCellSelectionStyleNone;
    cellCustom.lblMovimiento.text = [self.arrDatos objectAtIndex:indexPath.row];
    return cellCustom;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ((MovementTableViewCell *) [[NSBundle mainBundle] loadNibNamed:@"MovementTableViewCell" owner:self options:nil].lastObject).frame.size.height;
}

@end
