//
//  AccountManagement.swift
//  APIBankApp
//
//  Created by Lautaro Emanuel Galan Cid on 01/02/2019.
//  Copyright © 2019 Lautaro Emanuel Galán Cid. All rights reserved.
//

import UIKit

@objc public class AccountManagement: NSObject {
    private let db: StorageManagement = StorageManagement()
    
    @objc public func setClient() {
        db.SeedClientData()
    }
    
    @objc public func getClientData(parIdClient: Int) -> String {
        let objCliente: Client = db.SelectClient(parIdClient: parIdClient)
        return objCliente.clientName
    }
    
    @objc public func getBalance(parIdClient: Int) -> Double {
        let objCliente: Client = db.SelectClient(parIdClient: parIdClient)
        return objCliente.balance!
    }

    @objc public func getOverdraw(parIdClient: Int) -> Double {
        let objCliente: Client = db.SelectClient(parIdClient: parIdClient)
        return objCliente.overdraw!
    }
    
    @objc public func getTransactions(parIdClient: Int) -> [String] {
        let objTrans: Transaction = db.SelectTransactions(parIdClient: parIdClient)
        return objTrans.Movement!
    }
    
    @objc public func getTransactionsCount(parIdClient: Int) -> Int {
        let countTrans: Int = db.SelectTransactionsCount(parIdClient: parIdClient)
        return countTrans
    }
    
    

}
