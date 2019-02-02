//
//  ClientData.swift
//  APIBankApp
//
//  Created by Lautaro Emanuel Galan Cid on 01/02/2019.
//  Copyright © 2019 Lautaro Emanuel Galán Cid. All rights reserved.
//

import UIKit

struct Client: Codable {
        let idClient : Int
        let clientName: String
        var balance : Double?
        var overdraw : Double?
}

