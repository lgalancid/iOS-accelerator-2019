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
        db.SeedData()
    }
    
    @objc public func getClientData(parIdClient: Int) -> String {
        let objCliente: Client = db.Select(parIdClient: parIdClient)
        return objCliente.clientName
    }
    
    @objc public func getBalance(parIdClient: Int) -> Double {
        let objCliente: Client = db.Select(parIdClient: parIdClient)
        return objCliente.balance!
    }

    @objc public func getOverdraw(parIdClient: Int) -> Double {
        let objCliente: Client = db.Select(parIdClient: parIdClient)
        return objCliente.overdraw!
    }
}
