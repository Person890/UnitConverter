//
//  History.swift
//  ConV
//
//  Created by Yi Qian on 11/20/21.
//

import UIKit

class Conversion{
    let type: String
    let op1: String
    let op2: String
    let out: String
    let add: Bool
    let unit1: String
    let unit2: String
    let unitOut: String
    
    init(){
        self.type = "null"
        self.op1 = "null"
        self.op2 = "null"
        self.out = "null"
        self.add = true
        self.unit1 = "null"
        self.unit2 = "null"
        self.unitOut = "null"
    }
    init(type: String, op1: String, op2: String, out: String, add: Bool, unit1: String, unit2: String, unitOut: String){
        self.type = type
        self.op1 = op1
        self.op2 = op2
        self.out = out
        self.add = add
        self.unit1 = unit1
        self.unit2 = unit2
        self.unitOut = unitOut
    }
    
    func getConversion() -> String {
        var conversion: String
        var operation: String
        if(!add) {
            operation="+"
        }
        else {
            operation="-"
        }
        conversion = "\(op1) \(unit1) \(operation) \(op2) \(unit2) = \(out) \(unitOut)"
        return conversion
    }
    
    func getType() -> String {
        return type
    }
    
    
}
