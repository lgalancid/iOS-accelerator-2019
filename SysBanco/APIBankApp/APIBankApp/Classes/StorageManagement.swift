//
//  StorageManagement.swift
//  APIBankApp
//
//  Created by Lautaro Emanuel Galan Cid on 01/02/2019.
//  Copyright © 2019 Lautaro Emanuel Galán Cid. All rights reserved.
//

import UIKit

class StorageManagement: NSObject {
    
    func SeedClientData(){
        // instancio cliente
        let objClient = Client(idClient: 1, clientName: "Lautaro Galan", balance: 0.00, overdraw: 2000.00)
        let idClient = "\(objClient.idClient)"
        // Creo encoder y guardo json del objeto en user defaults
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(objClient) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: Parameter.storedClient+idClient)
        }
    } 
    
    func SeedInitialTransaction(parIdClient: String, parTransaction: String){
        let arr = [CurrentTimestamp()+"\n"+parTransaction]
        let defaults = UserDefaults.standard
        
        let objTransaction = Transaction(Movement: arr)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(objTransaction) {
            defaults.set(encoded, forKey: Parameter.storedTransaction+parIdClient)
        }
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    func SelectClient(parIdClient: Int) -> Client {
        let defaults = UserDefaults.standard
        let strIdClient: String = "\(parIdClient)"
        var storedClient = defaults.object(forKey: Parameter.storedClient+strIdClient) as? Data
        if storedClient == nil {
            SeedClientData()
            storedClient = defaults.object(forKey: Parameter.storedClient+strIdClient) as? Data
        }
        let decoder = JSONDecoder()
        let readClient = try? decoder.decode(Client.self, from: storedClient!)
        return readClient!
    }
    
    func UpdateClient(parIdClient: Int, parBalance: Double, parOverdraw: Double){
        let defaults = UserDefaults.standard
        let strIdClient: String = "\(parIdClient)"
        let storedClient = defaults.object(forKey: Parameter.storedClient+strIdClient) as? Data
        let decoder = JSONDecoder()
        var readClient = try? decoder.decode(Client.self, from: storedClient!)
        readClient?.balance = parBalance
        readClient?.overdraw = parOverdraw
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(readClient) {
            defaults.set(encoded, forKey: Parameter.storedClient+strIdClient)
        }
    }
    
    func SelectTransactions(parIdClient: Int) -> Transaction {
        let defaults = UserDefaults.standard
        let strIdClient: String = "\(parIdClient)"
        let storedTransaction = defaults.object(forKey: Parameter.storedTransaction+strIdClient) as? Data
        let decoder = JSONDecoder()
        let readTransaction = try? decoder.decode(Transaction.self, from: storedTransaction!)
        return readTransaction!
    }
    
    func SelectTransactionsCount(parIdClient: Int) -> Int {
        let strIdClient: String = "\(parIdClient)"

        if isKeyPresentInUserDefaults(key: Parameter.storedTransaction+strIdClient){
            let defaults = UserDefaults.standard
            let storedTransaction = defaults.object(forKey: Parameter.storedTransaction+strIdClient) as? Data
            let decoder = JSONDecoder()
            let readTransaction = try? decoder.decode(Transaction.self, from: storedTransaction!)
            return (readTransaction?.Movement?.count)!
        }
        else {
            return 0
        }
    }
    
    func UpdateTransaction(parIdClient: Int, parTransaction: String){
        let defaults = UserDefaults.standard
        let strIdClient: String = "\(parIdClient)"
        
        let storedTransaction = defaults.object(forKey: Parameter.storedTransaction+strIdClient) as? Data
        
        if storedTransaction == nil {
            SeedInitialTransaction(parIdClient: strIdClient, parTransaction: parTransaction)
        }
        else {
            let decoder = JSONDecoder()
            var readTransaction = try? decoder.decode(Transaction.self, from: storedTransaction!)
            
            readTransaction?.Movement?.append(CurrentTimestamp()+"\n"+parTransaction)
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(readTransaction) {
                defaults.set(encoded, forKey: Parameter.storedTransaction+strIdClient)
            }
        }
    }
    
    func CurrentTimestamp() -> String{
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        let Timestamp = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        return Timestamp
    }
    
}
