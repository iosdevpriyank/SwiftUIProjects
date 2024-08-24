//
//  Order.swift
//  CupcakeCorner
//
//  Created by Akshat Gandhi on 24/08/24.
//

import SwiftUI
import Observation

@Observable
class Order: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    static let types = ["Vanila", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                 extraFrosting = false
                 addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    // Address field
    var name = "" {
        didSet {
            UserDefaults.standard.setValue(name, forKey: "name")
        }
    }
    var streetAddress = "" {
        didSet {
            UserDefaults.standard.setValue(streetAddress, forKey: "streetAddress")
        }
    }
    var city = "" {
        didSet {
            UserDefaults.standard.setValue(city, forKey: "city")
        }
    }
    var zip = "" {
        didSet {
            UserDefaults.standard.setValue(zip, forKey: "zip")
        }
    }
    
    var hasValidAddress: Bool {
        if name.isEmptyCheck || streetAddress.isEmptyCheck || city.isEmptyCheck || zip.isEmptyCheck {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        // 80 Rupees per cake
        var cost = Decimal(quantity) * 80
        
        cost += Decimal(type) / 2
        
        // 40 Rupess cake for exara frosting
        if extraFrosting {
            cost += Decimal(quantity) * 40
        }
        
        if addSprinkles {
            cost += Decimal(quantity) * 20
        }
        
        return cost
    }
    
    init() {
        name = UserDefaults.standard.string(forKey: "name") ?? ""
        streetAddress = UserDefaults.standard.string(forKey: "streetAddress") ?? ""
        city = UserDefaults.standard.string(forKey: "city") ?? ""
        zip = UserDefaults.standard.string(forKey: "zip") ?? ""
    }
}
