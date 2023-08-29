//
//  SettingsViewController.swift
//  task4_app
//
//  Created by Özgür  Atak  on 29.08.2023.
//

import Foundation
import UIKit

protocol SettingDelegate {
    func settingsSaved(vm: SettingsViewModel)
}

class SettingsViewController: UITableViewController {
    private var vm = SettingsViewModel()
    var delegate: SettingDelegate?

    @IBAction func closeButtoTapped (){
        if let delegate = self.delegate {
            delegate.settingsSaved(vm: vm)
        }
        self.dismiss(animated: true, completion: nil)
        print(vm.selectedUnit.rawValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.units.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingItems = vm.units[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        
        cell.textLabel?.text = settingItems.displayName
        
        if settingItems == vm.selectedUnit {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.visibleCells.forEach { cell in
            cell.accessoryType = .none
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            let unit = Units.allCases[indexPath.row]
            vm.selectedUnit = unit
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
}
