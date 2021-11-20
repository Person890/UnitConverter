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
    
    
    let aDrop = DropDown()
    let bDrop = DropDown()
    let outDrop = DropDown()
    let volumeUnit = ["imperial liquid gallon", "imperial quart", "imperial pint", "imperial cup", "imperial fluid ounce", "imperial tablespoon", "imperial teaspoon", "liter"]
    
    enum VolumeUnit {
        case gallon
        case quart
        case pint
        case cup
        case ounce
        case tablespoon
        case teaspoon
        case liter
        
        static let getAllUnits = [gallon, quart, pint, cup, ounce, tablespoon, teaspoon, liter]
    }
    
    
    @IBAction func didTapButton(){
        let vc = storyboard?.instantiateViewController(identifier: "green_vc") as! GreenViewController
        present(vc, animated: true)
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
        aDrop.dataSource = volumeUnit
        aDrop.topOffset = CGPoint(x: 0, y:-(aDrop.anchorView?.plainView.bounds.height)!)
        aDrop.bottomOffset = CGPoint(x: 0, y:(aDrop.anchorView?.plainView.bounds.height)!)
        aDrop.direction = .bottom
        
        aDrop.selectionAction = { [unowned self]
            (index: Int, item: String) in
            print(index)
            self.aUnit.text = volumeUnit[index]
        }
        //B
        bDrop.anchorView = bDropDown
        bDrop.dataSource = volumeUnit
        bDrop.topOffset = CGPoint(x: 0, y:-(bDrop.anchorView?.plainView.bounds.height)!)
        bDrop.bottomOffset = CGPoint(x: 0, y:(bDrop.anchorView?.plainView.bounds.height)!)
        bDrop.direction = .bottom
        
        bDrop.selectionAction = { [unowned self]
            (index: Int, item: String) in
            self.bUnit.text = volumeUnit[index]
        }
        //output
        outDrop.anchorView = outDropDown
        outDrop.dataSource = volumeUnit
        outDrop.topOffset = CGPoint(x: 0, y:-(outDrop.anchorView?.plainView.bounds.height)!)
        outDrop.bottomOffset = CGPoint(x: 0, y:(outDrop.anchorView?.plainView.bounds.height)!)
        outDrop.direction = .top
        
        outDrop.selectionAction = { [unowned self]
            (index: Int, item: String) in
            self.outUnit.text = volumeUnit[index]
            
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
        var unitFrom = VolumeUnit.cup
        var unitTo = VolumeUnit.cup
        print(aDrop.index)
        
        switch aUnit.text{
        case "imperial liquid gallon":
            unitFrom = .gallon
        case "imperial quart":
            unitFrom = .quart
        case "imperial pint":
            unitFrom = .pint
        case "imperial cup":
            unitFrom = .cup
        case "imperial fluid ounce":
            unitFrom = .ounce
        case "imperial tablespoon":
            unitFrom = .tablespoon
        case "imperial teaspoon":
            unitFrom = .teaspoon
        case "liter":
            unitFrom = .liter
        default:
            break
        }
        switch outUnit.text{
        case "imperial liquid gallon":
            unitTo = .gallon
        case "imperial quart":
            unitTo = .quart
        case "imperial pint":
            unitTo = .pint
        case "imperial cup":
            unitTo = .cup
        case "imperial fluid ounce":
            unitTo = .ounce
        case "imperial tablespoon":
            unitTo = .tablespoon
        case "imperial teaspoon":
            unitTo = .teaspoon
        case "liter":
            unitTo = .liter
        default:
            break
        }
        
        //convert to cup
        var out = convertFrom(unit: unitFrom, op: varA)
        //convert from cup
        out = convertTo(unit: unitTo, op: out)
        
        
        
        print("the output is \(out)\n")
        resultLabel.text = "\(out)"
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
        }
        print("conver from \(op) cup to \(out) \(unit)\n")
        return out
    }
    
    
    /*
    @objc func didTapTopItem() {
        menu.show()
    }
    */

}


