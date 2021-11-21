//
//  ViewController.swift
//  ConV
//
//  Created by Yi Qian on 10/22/21.
//
import DropDown
import UIKit

//length ViewController
class LengthViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var operation: UIButton!
    @IBOutlet weak var aDropDown: UIView!
    @IBOutlet weak var aUnit: UILabel!
    @IBOutlet weak var bDropDown: UIView!
    @IBOutlet weak var bUnit: UILabel!
    @IBOutlet weak var outDropDown: UIView!
    @IBOutlet weak var outUnit: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet var textA: UITextField!
    @IBOutlet var textB: UITextField!
    
    @IBOutlet weak var save: UIButton!
    @IBAction func saveConversion(  sender:UIButton) {
        if resultLabel.text != "0.0"{
            let entry = Conversion(type: "Length", op1: textA.text!, op2: textB.text!, out: resultLabel.text!, add: operation.isSelected, unit1: aUnit.text!, unit2: bUnit.text!, unitOut: outUnit.text!)
            History.entries.append(entry)
            print(entry.getConversion())
            print(History.entries.count)
            //print(History.entries[0].getConversion())
        }
    }
    
    let aDrop = DropDown()
    let bDrop = DropDown()
    let outDrop = DropDown()
    let lengthUnit = ["kilometer", "meter", "millimeter", "mile", "yard", "foot", "inch"]
    
    enum DistanceUnit {
        case kilometer
        case meter
        case millimeter
        case mile
        case yard
        case foot
        case inch
        
        static let getAllUnits = [kilometer, meter, millimeter, mile, yard, foot, inch]
    }
    
    
    @IBAction func ashowUnits(  sender:Any) {
        aDrop.show()
    }
    @IBAction func bshowUnits(  sender:Any) {
        bDrop.show()
    }
    @IBAction func outshowUnits(  sender:Any) {
        outDrop.show()
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //keyboard
        textA.keyboardType = UIKeyboardType.decimalPad
        textB.keyboardType = UIKeyboardType.decimalPad
        
        
        //A
        aDrop.anchorView = aDropDown
        aDrop.dataSource = lengthUnit
        aDrop.topOffset = CGPoint(x: 0, y:-(aDrop.anchorView?.plainView.bounds.height)!)
        aDrop.bottomOffset = CGPoint(x: 0, y:(aDrop.anchorView?.plainView.bounds.height)!)
        aDrop.direction = .bottom
        
        aDrop.selectionAction = { [unowned self]
            (index: Int, item: String) in
            print(index)
            self.aUnit.text = lengthUnit[index]
        }
        //B
        bDrop.anchorView = bDropDown
        bDrop.dataSource = lengthUnit
        bDrop.topOffset = CGPoint(x: 0, y:-(bDrop.anchorView?.plainView.bounds.height)!)
        bDrop.bottomOffset = CGPoint(x: 0, y:(bDrop.anchorView?.plainView.bounds.height)!)
        bDrop.direction = .bottom
        
        bDrop.selectionAction = { [unowned self]
            (index: Int, item: String) in
            self.bUnit.text = lengthUnit[index]
        }
        //output
        outDrop.anchorView = outDropDown
        outDrop.dataSource = lengthUnit
        outDrop.topOffset = CGPoint(x: 0, y:-(outDrop.anchorView?.plainView.bounds.height)!)
        outDrop.bottomOffset = CGPoint(x: 0, y:(outDrop.anchorView?.plainView.bounds.height)!)
        outDrop.direction = .top
        
        outDrop.selectionAction = { [unowned self]
            (index: Int, item: String) in
            self.outUnit.text = lengthUnit[index]
            
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(  textFirld: UITextField) -> Bool{
        textA.resignFirstResponder()
        return (true)
    }
    
    @IBAction func operationAction(_ sender: UIButton) {
        //+/- behavior
        if sender.tag == 1{
            if operation.isSelected{
                operation.isSelected = false
            }
            else{
                operation.isSelected = true
            }
        }
        
    }
    @IBAction func operation(  sender: Any) {
        let tA = textA.text ?? ""
        let tB = textB.text ?? ""
        let varA = Double(tA) ?? 0.0
        let varB = Double(tB) ?? 0.0
        var unitAFrom = DistanceUnit.meter
        var unitBFrom = DistanceUnit.meter
        
        var unitTo = DistanceUnit.meter
        print(aDrop.index)
        
        switch aUnit.text{
        case "kilometer":
            unitAFrom = .kilometer
        case "meter":
            unitAFrom = .meter
        case "millimeter":
            unitAFrom = .millimeter
        case "mile":
            unitAFrom = .mile
        case "yard":
            unitAFrom = .yard
        case "foot":
            unitAFrom = .foot
        case "inch":
            unitAFrom = .inch
        default:
            break
        }
        switch bUnit.text{
        case "kilometer":
            unitBFrom = .kilometer
        case "meter":
            unitBFrom = .meter
        case "millimeter":
            unitBFrom = .millimeter
        case "mile":
            unitBFrom = .mile
        case "yard":
            unitBFrom = .yard
        case "foot":
            unitBFrom = .foot
        case "inch":
            unitBFrom = .inch
        default:
            break
        }
        switch outUnit.text{
        case "kilometer":
            unitTo = .kilometer
        case "meter":
            unitTo = .meter
        case "millimeter":
            unitTo = .millimeter
        case "mile":
            unitTo = .mile
        case "yard":
            unitTo = .yard
        case "foot":
            unitTo = .foot
        case "inch":
            unitTo = .inch
        default:
            break
        }
        
        //convert to meter
        let outA = convertFrom(unit: unitAFrom, op: varA)
        let outB = convertFrom(unit: unitBFrom, op: varB)
        var out = operate(op1: outA, op2: outB, add: operation.isSelected)
        //convert from meter
        out = convertTo(unit: unitTo, op: out)
        //round to 3 dec place
        out = Double(round(1000*out)/1000)
        
        
        
        print("the output is \(out)\n")
        resultLabel.text = "\(out)"
    }
    
    func convertFrom(unit: DistanceUnit, op: Double) -> Double{
        var out = 0.0
        switch unit {
        case .kilometer:
            out = op*1000
        case .meter:
            out = op
        case .yard:
            out = op/1.094
        case .foot:
            out = op/3.281
        case .inch:
            out = op/39.37
        case .mile:
            out = op*1609.344
        case .millimeter:
            out = op/1000
        }
        print("conver from \(op) \(unit) to \(out) meter\n")
        return out
    }
    func convertTo(unit: DistanceUnit, op: Double) -> Double{
        var out = 0.0
        switch unit {
        case .kilometer:
            out = op/1000
        case .meter:
            out = op
        case .yard:
            out = op*1.094
        case .foot:
            out = op*3.281
        case .inch:
            out = op*39.37
        case .mile:
            out = op/1609.344
        case .millimeter:
            out = op*1000
        }
        print("conver from \(op) meter to \(out) \(unit)\n")
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


