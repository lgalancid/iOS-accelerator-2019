//
//  AccountMovement.swift
//  APIBankApp
//
//  Created by Lautaro Emanuel Galan Cid on 01/02/2019.
//  Copyright © 2019 Lautaro Emanuel Galán Cid. All rights reserved.
//

import UIKit

@objc public class AccountMovement: NSObject {
    private let db: StorageManagement = StorageManagement()

    @objc public func Deposit(parIdCuenta: Int, parMonto: Double) -> Void {
        let accMgmt: AccountManagement = AccountManagement()
        
        let overdraw: Double = accMgmt.getOverdraw(parIdClient: parIdCuenta)
        
        let balance: Double = accMgmt.getBalance(parIdClient: parIdCuenta) + parMonto

        db.UpdateClient(parIdClient: parIdCuenta, parBalance: balance, parOverdraw: overdraw)
        
        let movimientoTransaccional = "Deposito: $\(parMonto)"
        db.UpdateTransaction(parIdClient: parIdCuenta, parTransaction: movimientoTransaccional)
    }
    
    @objc public func Withdraw(parIdCuenta: Int, parMonto: Double) -> Void {
        let accMgmt: AccountManagement = AccountManagement()
        var overdraw: Double = accMgmt.getOverdraw(parIdClient: parIdCuenta)
        var balance: Double = accMgmt.getBalance(parIdClient: parIdCuenta)
        if overdraw + balance < parMonto || (overdraw == 0 && (balance == 0 || balance < parMonto)) {
            print("No posee fondos para realizar esta transaccion")
            return
        }
        balance = balance - parMonto
        
        if balance <= 0 {
            overdraw = overdraw + balance
        }
        db.UpdateClient(parIdClient: parIdCuenta, parBalance: balance, parOverdraw: overdraw)
        let movimientoTransaccional = "Extraccion: (-$\(parMonto))"
        db.UpdateTransaction(parIdClient: parIdCuenta, parTransaction: movimientoTransaccional)
    }
}
