//
//  ViewController.swift
//  ConV
//
//  Created by Yi Qian on 10/22/21.
//
import DropDown
import UIKit

//Weight ViewController
class WeightViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var WeightOperation: UIButton!
    @IBOutlet weak var WeightADropDown: UIView!
    @IBOutlet weak var WeightAUnit: UILabel!
    @IBOutlet weak var WeightBDropDown: UIView!
    @IBOutlet weak var WeightBUnit: UILabel!
    @IBOutlet weak var WeightOutDropDown: UIView!
    @IBOutlet weak var WeightOutUnit: UILabel!
    @IBOutlet weak var WeightResultLabel: UILabel!
    
    @IBOutlet var WeightTextA: UITextField!
    @IBOutlet var WeightTextB: UITextField!
    
    @IBOutlet weak var save: UIButton!
    
    var entry = Conversion()
    func createConversion(){
        let newEntry = Conversion(type: "Weighterature", op1: WeightTextA.text!, op2: WeightTextB.text!, out: WeightResultLabel.text!, add: WeightOperation.isSelected, unit1: WeightAUnit.text!, unit2: WeightBUnit.text!, unitOut: WeightOutUnit.text!)
        entry = newEntry
    }
    @IBAction func saveConversion(  sender:UIButton) {
        if entry.getType() != "null"{
            History.entries.append(entry)
            print(entry.getConversion())
            print(History.entries.count)
            let alert = UIAlertController(title: "Success", message: "The length calculation was successully saved!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Error", message: "You are trying to save an empty calculation!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    let WeightADrop = DropDown()
    let WeightBDrop = DropDown()
    let WeightOutDrop = DropDown()
    let weightUnit = ["metric ton", "kilogram", "gram", "pound", "ounce"]
    
    enum WeightUnit {
        case ton
        case kilogram
        case gram
        case pound
        case ounce
        
        static let getAllUnits = [ton, kilogram, gram, pound, ounce]
    }
    
    
    @IBAction func ashowUnits(  sender:Any) {
        WeightADrop.show()
    }
    @IBAction func bshowUnits(  sender:Any) {
        WeightBDrop.show()
    }
    @IBAction func outshowUnits(  sender:Any) {
        WeightOutDrop.show()
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //keyboard
        WeightTextA.keyboardType = UIKeyboardType.decimalPad
        WeightTextB.keyboardType = UIKeyboardType.decimalPad
        
        
        //A
        WeightADrop.anchorView = WeightADropDown
        WeightADrop.dataSource = weightUnit
        WeightADrop.topOffset = CGPoint(x: 0, y:-(WeightADrop.anchorView?.plainView.bounds.height)!)
        WeightADrop.bottomOffset = CGPoint(x: 0, y:(WeightADrop.anchorView?.plainView.bounds.height)!)
        WeightADrop.direction = .bottom
        
        WeightADrop.selectionAction = { [unowned self]
            (index: Int, item: String) in
            print(index)
            self.WeightAUnit.text = weightUnit[index]
        }
        //B
        WeightBDrop.anchorView = WeightBDropDown
        WeightBDrop.dataSource = weightUnit
        WeightBDrop.topOffset = CGPoint(x: 0, y:-(WeightBDrop.anchorView?.plainView.bounds.height)!)
        WeightBDrop.bottomOffset = CGPoint(x: 0, y:(WeightBDrop.anchorView?.plainView.bounds.height)!)
        WeightBDrop.direction = .bottom
        
        WeightBDrop.selectionAction = { [unowned self]
            (index: Int, item: String) in
            self.WeightBUnit.text = weightUnit[index]
        }
        //output
        WeightOutDrop.anchorView = WeightOutDropDown
        WeightOutDrop.dataSource = weightUnit
        WeightOutDrop.topOffset = CGPoint(x: 0, y:-(WeightOutDrop.anchorView?.plainView.bounds.height)!)
        WeightOutDrop.bottomOffset = CGPoint(x: 0, y:(WeightOutDrop.anchorView?.plainView.bounds.height)!)
        WeightOutDrop.direction = .top
        
        WeightOutDrop.selectionAction = { [unowned self]
            (index: Int, item: String) in
            self.WeightOutUnit.text = weightUnit[index]
            
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(  textFirld: UITextField) -> Bool{
        WeightTextA.resignFirstResponder()
        return (true)
    }
    
    @IBAction func operationAction(_ sender: UIButton) {
        //+/- behavior
        if sender.tag == 1{
            if WeightOperation.isSelected{
                WeightOperation.isSelected = false
            }
            else{
                WeightOperation.isSelected = true
            }
        }
        
    }
    @IBAction func operation(  sender: Any) {
        let tA = WeightTextA.text ?? ""
        let tB = WeightTextB.text ?? ""
        let varA = Double(tA) ?? 0.0
        let varB = Double(tB) ?? 0.0
        var unitAFrom = WeightUnit.kilogram
        var unitBFrom = WeightUnit.kilogram
        var unitTo = WeightUnit.kilogram
        print(WeightADrop.index)
        
        switch WeightAUnit.text{
        case "metric ton":
            unitAFrom = .ton
        case "kilogram":
            unitAFrom = .kilogram
        case "gram":
            unitAFrom = .gram
        case "pound":
            unitAFrom = .pound
        case "ounce":
            unitAFrom = .ounce
        default:
            break
        }
        switch WeightBUnit.text{
        case "metric ton":
            unitBFrom = .ton
        case "kilogram":
            unitBFrom = .kilogram
        case "gram":
            unitBFrom = .gram
        case "pound":
            unitBFrom = .pound
        case "ounce":
            unitBFrom = .ounce
        default:
            break
        }
        switch WeightOutUnit.text{
        case "metric ton":
            unitTo = .ton
        case "kilogram":
            unitTo = .kilogram
        case "gram":
            unitTo = .gram
        case "pound":
            unitTo = .pound
        case "ounce":
            unitTo = .ounce
        default:
            break
        }
        
        //convert to kg
        let outA = convertFrom(unit: unitAFrom, op: varA)
        let outB = convertFrom(unit: unitBFrom, op: varB)
        var out = operate(op1: outA, op2: outB, add: WeightOperation.isSelected)
        //convert from kg
        out = convertTo(unit: unitTo, op: out)
        //round to 3 dec place
        out = Double(round(1000*out)/1000)
        
        print("the output is \(out)\n")
        WeightResultLabel.text = "\(out)"
        createConversion()
    }
    
    func convertFrom(unit: WeightUnit, op: Double) -> Double{
        var out = 0.0
        switch unit {
        case .ton:
            out = op*1000
        case .kilogram:
            out = op
        case .gram:
            out = op/1000
        case .pound:
            out = op/2.205
        case .ounce:
            out = op/35.274
        }
        print("conver from \(op) \(unit) to \(out) kg\n")
        return out
    }
    func convertTo(unit: WeightUnit, op: Double) -> Double{
        var out = 0.0
        switch unit {
        case .ton:
            out = op/1000
        case .kilogram:
            out = op
        case .gram:
            out = op*1000
        case .pound:
            out = op*2.205
        case .ounce:
            out = op*35.274
        }
        print("conver from \(op) kg to \(out) \(unit)\n")
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


