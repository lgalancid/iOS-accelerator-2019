//
//  StorageManagement.swift
//  APIBankApp
//
//  Created by Lautaro Emanuel Galan Cid on 01/02/2019.
//  Copyright © 2019 Lautaro Emanuel Galán Cid. All rights reserved.
//

import UIKit

class StorageManagement: NSObject {
    
    func SeedData(){
        // instancio cliente
        let objClient = Client(idClient: 1, clientName: "Lautaro Galan", balance: 0.00, overdraw: 2000.00)
        let idClient = "\(objClient.idClient)"
        // Creo encoder y guardo json del objeto en user defaults
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(objClient) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "storedClient_"+idClient)
        }
    }
    
    func Select(parIdClient: Int) -> Client {
        let defaults = UserDefaults.standard
        let parStr: String = "\(parIdClient)"
        let storedClient = defaults.object(forKey: "storedClient_"+parStr) as? Data
        let decoder = JSONDecoder()
        let readClient = try? decoder.decode(Client.self, from: storedClient!)
        return readClient!
    }
    
    func Update(parIdClient: Int, parBalance: Double, parOverdraw: Double){
        let defaults = UserDefaults.standard
        let parStr: String = "\(parIdClient)"
        let storedClient = defaults.object(forKey: "storedClient_"+parStr) as? Data
        let decoder = JSONDecoder()
        var readClient = try? decoder.decode(Client.self, from: storedClient!)
        readClient?.balance = parBalance
        readClient?.overdraw = parOverdraw
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(readClient) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "storedClient_"+parStr)
        }
    }
}
