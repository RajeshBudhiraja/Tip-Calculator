//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Rajesh Budhiraja on 09/07/20.
//  Copyright © 2020 Rajesh Budhiraja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipTextField: UITextField!
    @IBOutlet weak var numberOfPeopleTextField: UITextField!
    @IBOutlet weak var tipEarnedLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: #selector(dismissKeyboard)),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        ]
        toolbar.sizeToFit()
        self.billTextField.inputAccessoryView = toolbar
        self.numberOfPeopleTextField.inputAccessoryView = toolbar
        self.tipTextField.inputAccessoryView = toolbar
        self.addObservers()
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    private func addObservers() {
        self.billTextField.addTarget(self, action: #selector(textFieldChanged(textfield:)), for: .editingChanged)
        self.tipTextField.addTarget(self, action: #selector(textFieldChanged(textfield:)), for: .editingChanged)
        self.numberOfPeopleTextField.addTarget(self, action: #selector(textFieldChanged(textfield:)), for: .editingChanged)
    }

    private func addDefaultValues() {
        self.billTextField.text = "0"
        self.numberOfPeopleTextField.text = "0"
        self.tipTextField.text = "0"
    }
    
    @objc private func textFieldChanged(textfield: UITextField) {
        self.calculateTip()
    }
    
    private func calculateTip() {
        if let peopleCount = numberOfPeopleTextField.text, let bill = billTextField.text, let tip = tipTextField.text {
            let billDouble = Double(bill) ?? 0.0
            let peopleDouble = Double(peopleCount) ?? 0
            let tipDouble = Double(tip) ?? 00.0
            guard peopleDouble != 0.0 else {
                self.totalAmountLabel.text = "Total Amount: NA"
                self.tipEarnedLabel.text = "Tip Earned: NA"
                return
            }
            let tipEarned = (billDouble * (tipDouble * 0.01)) / peopleDouble
            let roundedTip = String(format: "%.2f", tipEarned)
            
            let roundedAmount = String(format: "%.2f", tipEarned + billDouble/peopleDouble)
            self.totalAmountLabel.text = "Total Amount: \(roundedAmount)"
            self.tipEarnedLabel.text = "Tip Earned: \(roundedTip)"
            
        } else {
            self.totalAmountLabel.text = "Total Amount: 0"
            self.tipEarnedLabel.text = "Tip Earned: 0"
        }
    }
    

}

