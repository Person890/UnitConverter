//
//  ViewController.swift
//  ConV
//
//  Created by Yi Qian on 10/22/21.
//
import DropDown
import UIKit

//speed ViewController
class SpeedViewController: UIViewController, UITextViewDelegate {
    
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
    
    var entry = Conversion()
    func createConversion(){
        let newEntry = Conversion(type: "Length", op1: textA.text!, op2: textB.text!, out: resultLabel.text!, add: operation.isSelected, unit1: aUnit.text!, unit2: bUnit.text!, unitOut: outUnit.text!)
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
    
    
    let aDrop = DropDown()
    let bDrop = DropDown()
    let outDrop = DropDown()
    let speedUnit = ["mile/hr", "foot/sec", "meter/sec", "kilometer/hr"]
    
    enum SpeedUnit {
        case mph
        case fps
        case mps
        case kph
        
        static let getAllUnits = [mph, fps, mps, kph]
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
        aDrop.dataSource = speedUnit
        aDrop.topOffset = CGPoint(x: 0, y:-(aDrop.anchorView?.plainView.bounds.height)!)
        aDrop.bottomOffset = CGPoint(x: 0, y:(aDrop.anchorView?.plainView.bounds.height)!)
        aDrop.direction = .bottom
        
        aDrop.selectionAction = { [unowned self]
            (index: Int, item: String) in
            print(index)
            self.aUnit.text = speedUnit[index]
        }
        //B
        bDrop.anchorView = bDropDown
        bDrop.dataSource = speedUnit
        bDrop.topOffset = CGPoint(x: 0, y:-(bDrop.anchorView?.plainView.bounds.height)!)
        bDrop.bottomOffset = CGPoint(x: 0, y:(bDrop.anchorView?.plainView.bounds.height)!)
        bDrop.direction = .bottom
        
        bDrop.selectionAction = { [unowned self]
            (index: Int, item: String) in
            self.bUnit.text = speedUnit[index]
        }
        //output
        outDrop.anchorView = outDropDown
        outDrop.dataSource = speedUnit
        outDrop.topOffset = CGPoint(x: 0, y:-(outDrop.anchorView?.plainView.bounds.height)!)
        outDrop.bottomOffset = CGPoint(x: 0, y:(outDrop.anchorView?.plainView.bounds.height)!)
        outDrop.direction = .top
        
        outDrop.selectionAction = { [unowned self]
            (index: Int, item: String) in
            self.outUnit.text = speedUnit[index]
            
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
        var unitAFrom = SpeedUnit.mps
        var unitBFrom = SpeedUnit.mps
        
        var unitTo = SpeedUnit.mps
        print(aDrop.index)
        
        switch aUnit.text{
        case "mile/hour":
            unitAFrom = .mph
        case "foot/second":
            unitAFrom = .fps
        case "meter/second":
            unitAFrom = .mps
        case "kilometer/hour":
            unitAFrom = .kph
        default:
            break
        }
        switch bUnit.text{
        case "mile/hr":
            unitBFrom = .mph
        case "foot/sec":
            unitBFrom = .fps
        case "meter/sec":
            unitBFrom = .mps
        case "kilometer/hr":
            unitBFrom = .kph
        default:
            break
        }
        switch outUnit.text{
        case "mile/hr":
            unitTo = .mph
        case "foot/sec":
            unitTo = .fps
        case "meter/sec":
            unitTo = .mps
        case "kilometer/hr":
            unitTo = .kph
        default:
            break
        }
        
        let outA = convertFrom(unit: unitAFrom, op: varA)
        let outB = convertFrom(unit: unitBFrom, op: varB)
        var out = operate(op1: outA, op2: outB, add: operation.isSelected)
        out = convertTo(unit: unitTo, op: out)
        //round to 3 dec place
        out = Double(round(1000*out)/1000)
        
        
        
        print("the output is \(out)\n")
        resultLabel.text = "\(out)"
        createConversion()
    }
    
    func convertFrom(unit: SpeedUnit, op: Double) -> Double{
        var out = 0.0
        switch unit {
        case .mph:
            out = op/2.237
        case .fps:
            out = op/3.281
        case .mps:
            out = op
        case .kph:
            out = op/3.6
        }
        print("conver from \(op) \(unit) to \(out) mps\n")
        return out
    }
    func convertTo(unit: SpeedUnit, op: Double) -> Double{
        var out = 0.0
        switch unit {
        case .mph:
            out = op*2.237
        case .fps:
            out = op*3.281
        case .mps:
            out = op
        case .kph:
            out = op*3.6
        }
        print("conver from \(op) mps to \(out) \(unit)\n")
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


