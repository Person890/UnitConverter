//
//  ViewController.swift
//  ConV
//
//  Created by Yi Qian on 10/22/21.
//
import DropDown
import UIKit

//length ViewController
class VolumeViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var VolumeOperation: UIButton!
    @IBOutlet weak var VolumeADropDown: UIView!
    @IBOutlet weak var VolumeAUnit: UILabel!
    @IBOutlet weak var VolumeBDropDown: UIView!
    @IBOutlet weak var VolumeBUnit: UILabel!
    @IBOutlet weak var VolumeOutDropDown: UIView!
    @IBOutlet weak var VolumeOutUnit: UILabel!
    @IBOutlet weak var volumeResultLabel: UILabel!
    
    @IBOutlet var volumeTextA: UITextField!
    @IBOutlet var volumeTextB: UITextField!
    
    
    @IBOutlet weak var save: UIButton!
    
    var entry = Conversion()
    func createConversion(){
        let newEntry = Conversion(type: "Volume", op1: volumeTextA.text!, op2: volumeTextB.text!, out: volumeResultLabel.text!, add: VolumeOperation.isSelected, unit1: VolumeAUnit.text!, unit2: VolumeBUnit.text!, unitOut: VolumeOutUnit.text!)
        entry = newEntry
    }
    @IBAction func saveConversion(  sender:UIButton) {
        if entry.getUnitOut() != "Unit" && entry.getType() != "null" {
            History.entries.append(entry)
            print(entry.getConversion())
            print(History.entries.count)
            let alert = UIAlertController(title: "Success", message: "The volume calculation was successully saved!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Error", message: "You are trying to save an empty calculation!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    let volumeADrop = DropDown()
    let volumeBDrop = DropDown()
    let volumeOutDrop = DropDown()
    let volumeUnit = ["liquid gallon", "quart", "pint", "cup", "fluid ounce", "tablespoon", "teaspoon", "liter"]
    
    enum VolumeUnit {
        case gallon
        case quart
        case pint
        case cup
        case ounce
        case tablespoon
        case teaspoon
        case liter
        case null
        
        static let getAllUnits = [gallon, quart, pint, cup, ounce, tablespoon, teaspoon, liter]
    }
    
    
    @IBAction func ashowUnits(  sender:Any) {
        volumeADrop.show()
    }
    @IBAction func bshowUnits(  sender:Any) {
        volumeBDrop.show()
    }
    @IBAction func outshowUnits(  sender:Any) {
        volumeOutDrop.show()
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //keyboard
        volumeTextA.keyboardType = UIKeyboardType.decimalPad
        volumeTextB.keyboardType = UIKeyboardType.decimalPad
        
        
        //A
        volumeADrop.anchorView = VolumeADropDown
        volumeADrop.dataSource = volumeUnit
        volumeADrop.topOffset = CGPoint(x: 0, y:-(volumeADrop.anchorView?.plainView.bounds.height)!)
        volumeADrop.bottomOffset = CGPoint(x: 0, y:(volumeADrop.anchorView?.plainView.bounds.height)!)
        volumeADrop.direction = .bottom
        
        volumeADrop.selectionAction = { [unowned self]
            (index: Int, item: String) in
            print(index)
            self.VolumeAUnit.text = volumeUnit[index]
        }
        //B
        volumeBDrop.anchorView = VolumeBDropDown
        volumeBDrop.dataSource = volumeUnit
        volumeBDrop.topOffset = CGPoint(x: 0, y:-(volumeBDrop.anchorView?.plainView.bounds.height)!)
        volumeBDrop.bottomOffset = CGPoint(x: 0, y:(volumeBDrop.anchorView?.plainView.bounds.height)!)
        volumeBDrop.direction = .bottom
        
        volumeBDrop.selectionAction = { [unowned self]
            (index: Int, item: String) in
            self.VolumeBUnit.text = volumeUnit[index]
        }
        //output
        volumeOutDrop.anchorView = VolumeOutDropDown
        volumeOutDrop.dataSource = volumeUnit
        volumeOutDrop.topOffset = CGPoint(x: 0, y:-(volumeOutDrop.anchorView?.plainView.bounds.height)!)
        volumeOutDrop.bottomOffset = CGPoint(x: 0, y:(volumeOutDrop.anchorView?.plainView.bounds.height)!)
        volumeOutDrop.direction = .top
        
        volumeOutDrop.selectionAction = { [unowned self]
            (index: Int, item: String) in
            self.VolumeOutUnit.text = volumeUnit[index]
            
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(  textFirld: UITextField) -> Bool{
        volumeTextA.resignFirstResponder()
        return (true)
    }
    
    @IBAction func operationAction(_ sender: UIButton) {
        //+/- behavior
        if sender.tag == 1{
            if VolumeOperation.isSelected{
                VolumeOperation.isSelected = false
            }
            else{
                VolumeOperation.isSelected = true
            }
        }
        
    }
    @IBAction func operation(  sender: Any) {
        let tA = volumeTextA.text ?? ""
        let tB = volumeTextB.text ?? ""
        let varA = Double(tA) ?? 0.0
        let varB = Double(tB) ?? 0.0
        var unitAFrom = VolumeUnit.cup
        var unitBFrom = VolumeUnit.cup
        var unitTo = VolumeUnit.cup
        print(volumeADrop.index)
        
        switch VolumeAUnit.text{
        case "liquid gallon":
            unitAFrom = .gallon
        case "quart":
            unitAFrom = .quart
        case "pint":
            unitAFrom = .pint
        case "cup":
            unitAFrom = .cup
        case "fluid ounce":
            unitAFrom = .ounce
        case "tablespoon":
            unitAFrom = .tablespoon
        case "teaspoon":
            unitAFrom = .teaspoon
        case "liter":
            unitAFrom = .liter
        default:
            unitAFrom = .null
        }
        switch VolumeBUnit.text{
        case "liquid gallon":
            unitBFrom = .gallon
        case "quart":
            unitBFrom = .quart
        case "pint":
            unitBFrom = .pint
        case "cup":
            unitBFrom = .cup
        case "fluid ounce":
            unitBFrom = .ounce
        case "tablespoon":
            unitBFrom = .tablespoon
        case "teaspoon":
            unitBFrom = .teaspoon
        case "liter":
            unitBFrom = .liter
        default:
            unitBFrom = .null
        }
        switch VolumeOutUnit.text{
        case "liquid gallon":
            unitTo = .gallon
        case "quart":
            unitTo = .quart
        case "pint":
            unitTo = .pint
        case "cup":
            unitTo = .cup
        case "fluid ounce":
            unitTo = .ounce
        case "tablespoon":
            unitTo = .tablespoon
        case "teaspoon":
            unitTo = .teaspoon
        case "liter":
            unitTo = .liter
        default:
            unitTo = .null
        }
        
        if (unitAFrom == VolumeUnit.null || unitTo == VolumeUnit.null) {
            let alert = UIAlertController(title: "Error", message: "Enter conversion unit", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        //convert to cup
        let outA = convertFrom(unit: unitAFrom, op: varA)
        let outB = convertFrom(unit: unitBFrom, op: varB)
        var out = operate(op1: outA, op2: outB, add: VolumeOperation.isSelected)
        //convert from cup
        out = convertTo(unit: unitTo, op: out)
        //round to 5 dec place
        out = Double(round(100000*out)/100000)
        
        
        
        print("the output is \(out)\n")
        volumeResultLabel.text = "\(out)"
        createConversion()
    }
    
    func convertFrom(unit: VolumeUnit, op: Double) -> Double{
        var out = 0.0
        switch unit {
        case .gallon:
            out = op*16
        case .quart:
            out = op*4
        case .pint:
            out = op*2
        case .cup:
            out = op
        case .ounce:
            out = op/10
        case .tablespoon:
            out = op/16
        case .teaspoon:
            out = op/48
        case .liter:
            out = op*3.52
        case .null:
            out = 0.0
        }
        print("conver from \(op) \(unit) to \(out) cup\n")
        return out
    }
    func convertTo(unit: VolumeUnit, op: Double) -> Double{
        var out = 0.0
        switch unit {
        case .gallon:
            out = op/16
        case .quart:
            out = op/4
        case .pint:
            out = op/2
        case .cup:
            out = op
        case .ounce:
            out = op*10
        case .tablespoon:
            out = op*16
        case .teaspoon:
            out = op*48
        case .liter:
            out = op/3.52
        case .null:
            out = 0.0
        }
        print("conver from \(op) cup to \(out) \(unit)\n")
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


