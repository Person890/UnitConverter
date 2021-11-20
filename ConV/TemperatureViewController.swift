//
//  TemperatureViewController.swift
//  ConV
//
//  Created by Yi Qian on 11/19/21.
//
import DropDown
import UIKit

class TemperatureViewController: UIViewController {
    
    @IBOutlet weak var tempOperation: UIButton!
    @IBOutlet weak var tempADropDown: UIView!
    @IBOutlet weak var tempAUnit: UILabel!
    @IBOutlet weak var tempBDropDown: UIView!
    @IBOutlet weak var tempBUnit: UILabel!
    @IBOutlet weak var tempOutDropDown: UIView!
    @IBOutlet weak var tempOutUnit: UILabel!
    @IBOutlet weak var tempResultLabel: UILabel!
    
    @IBOutlet var tempTextA: UITextField!
    @IBOutlet var tempTextB: UITextField!
    
    
    let tempADrop = DropDown()
    let tempBDrop = DropDown()
    let tempOutDrop = DropDown()
    let temperatureUnit = ["celsius", "fahrenheit", "kelvin"]
    
    enum TemperatureUnit {
        case celsius
        case fahrenheit
        case kelvin
        
        static let getAllUnits = [celsius, fahrenheit, kelvin]
    }
    
    @IBAction func ashowUnits(  sender:Any) {
        tempADrop.show()
    }
    @IBAction func bshowUnits(  sender:Any) {
        tempBDrop.show()
    }
    @IBAction func outshowUnits(  sender:Any) {
        tempOutDrop.show()
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //keyboard
        tempTextA.keyboardType = UIKeyboardType.decimalPad
        tempTextB.keyboardType = UIKeyboardType.decimalPad
        
        
        //A
        tempADrop.anchorView = tempADropDown
        tempADrop.dataSource = temperatureUnit
        tempADrop.topOffset = CGPoint(x: 0, y:-(tempADrop.anchorView?.plainView.bounds.height)!)
        tempADrop.bottomOffset = CGPoint(x: 0, y:(tempADrop.anchorView?.plainView.bounds.height)!)
        tempADrop.direction = .bottom
        
        tempADrop.selectionAction = { [unowned self]
            (index: Int, item: String) in
            print(index)
            self.tempAUnit.text = temperatureUnit[index]
        }
        //B
        tempBDrop.anchorView = tempBDropDown
        tempBDrop.dataSource = temperatureUnit
        tempBDrop.topOffset = CGPoint(x: 0, y:-(tempBDrop.anchorView?.plainView.bounds.height)!)
        tempBDrop.bottomOffset = CGPoint(x: 0, y:(tempBDrop.anchorView?.plainView.bounds.height)!)
        tempBDrop.direction = .bottom
        
        tempBDrop.selectionAction = { [unowned self]
            (index: Int, item: String) in
            self.tempBUnit.text = temperatureUnit[index]
        }
        //output
        tempOutDrop.anchorView = tempOutDropDown
        tempOutDrop.dataSource = temperatureUnit
        tempOutDrop.topOffset = CGPoint(x: 0, y:-(tempOutDrop.anchorView?.plainView.bounds.height)!)
        tempOutDrop.bottomOffset = CGPoint(x: 0, y:(tempOutDrop.anchorView?.plainView.bounds.height)!)
        tempOutDrop.direction = .top
        
        tempOutDrop.selectionAction = { [unowned self]
            (index: Int, item: String) in
            self.tempOutUnit.text = temperatureUnit[index]
            
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(  textFirld: UITextField) -> Bool{
        tempTextA.resignFirstResponder()
        return (true)
    }
    
    @IBAction func operationAction(_ sender: UIButton) {
        //+/- behavior
        if sender.tag == 1{
            if tempOperation.isSelected{
                tempOperation.isSelected = false
            }
            else{
                tempOperation.isSelected = true
            }
        }
        
    }
    @IBAction func operation(  sender: Any) {
        let tA = tempTextA.text ?? ""
        let tB = tempTextB.text ?? ""
        let varA = Double(tA) ?? 0.0
        let varB = Double(tB) ?? 0.0
        var unitAFrom = TemperatureUnit.celsius
        var unitBFrom = TemperatureUnit.celsius
        var unitTo = TemperatureUnit.celsius
        print(tempADrop.index)
        
        switch tempAUnit.text{
        case "celsius":
            unitAFrom = .celsius
        case "fahrenheit":
            unitAFrom = .fahrenheit
        case "kelvin":
            unitAFrom = .kelvin
        default:
            break
        }
        switch tempBUnit.text{
        case "celsius":
            unitBFrom = .celsius
        case "fahrenheit":
            unitBFrom = .fahrenheit
        case "kelvin":
            unitBFrom = .kelvin
        default:
            break
        }
        switch tempOutUnit.text{
        case "celsius":
            unitTo = .celsius
        case "fahrenheit":
            unitTo = .fahrenheit
        case "kelvin":
            unitTo = .kelvin
        default:
            break
        }
        //convert to degree celsius
        let outA = convertFrom(unit: unitAFrom, op: varA)
        let outB = convertFrom(unit: unitBFrom, op: varB)
        //convert from degree celsius
        var out = operate(op1: outA, op2: outB, add: tempOperation.isSelected)
        out = convertTo(unit: unitTo, op: out)
        
        
        print("the output is \(out)\n")
        tempResultLabel.text = "\(out)"
    }
    
    func convertFrom(unit: TemperatureUnit, op: Double) -> Double{
        var out = 0.0
        switch unit {
        case .celsius:
            out = op
        case .fahrenheit:
            out = (op - 32) * 5 / 9
        case .kelvin:
            out = op - 273.15
        }
        print("conver from \(op) \(unit) to \(out) degree celsius\n")
        return out
    }
    func convertTo(unit: TemperatureUnit, op: Double) -> Double{
        var out = 0.0
        switch unit {
        case .celsius:
            out = op
        case .fahrenheit:
            out = op * 9 / 5 + 32
        case .kelvin:
            out = op + 273.15
        }
        print("conver from \(op) degree celsius to \(out) \(unit)\n")
        return out
    }
    func operate(op1: Double, op2: Double, add: Bool) -> Double{
        var out = 0.0
        if(!add){
            out = op1 + op2
        }
        else{
            out = op1 - op2
        }
        return out
    }
    
    
    /*
    @objc func didTapTopItem() {
        menu.show()
    }
    */

}


