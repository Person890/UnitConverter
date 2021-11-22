//
//  HistoryViewController.swift
//  ConV
//
//  Created by Yi Qian on 11/20/21.
//

import UIKit

struct History{
    static var entries = [Conversion]();
}

class HistoryViewController: UITableViewController {
    
    //@IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var conversionText: UILabel!
    //@IBOutlet weak var conversionType: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBAction func editPressed(_ sender: UIBarButtonItem){
        self.tableView.isEditing = !self.tableView.isEditing
        editBtn.isSelected = !editBtn.isSelected
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(animated)
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if History.entries.count == 0{
            self.tableView.setEmptyMessage("No saved conversions found", UIColor.gray)
        }
        else{
            self.tableView.restore()
        }
        print("count: ")
        print(History.entries.count)
        return History.entries.count
        //return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = HistoryTableViewCell()
        let cell = UITableViewCell()
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HistoryTableViewCell
        //print(History.entries[indexPath.row].getConversion())
        //print(History.entries[indexPath.row].getType())
        cell.textLabel!.text = History.entries[indexPath.row].getConversion()
        //conversionType.text = History.entries[indexPath.row].getType()
        //conversionText.text = History.entries[indexPath.row].getConversion()
        //cell.conversionText.text = History.entries[indexPath.row].getConversion()
        //cell.conversionType.text = History.entries[indexPath.row].getType()
        //cell.isUserInteractionEnabled = false
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print(History.entries.count)
    }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath){
        let selectedItem = History.entries[sourceIndexPath.row]
        History.entries.remove(at: sourceIndexPath.row)
        History.entries.insert(selectedItem, at: destinationIndexPath.row)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            History.entries.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
