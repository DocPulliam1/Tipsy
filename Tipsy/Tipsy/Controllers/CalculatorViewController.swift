//
//  ViewController.swift
//  Tipsy
//
//  Created by Doc Pulliam on 09/09/2019.
//  Copyright © 2019 Doc Pulliam  All rights reserved.
//


import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
    @IBAction func tipChanged(_ sender: UIButton) {
        //Stop editing bill amount
        billTextField.endEditing(true)
        
        //Turn all buttons Off then selected button On
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        //Grab button title, take off percentage sign, convert to Double, divide 100 to get actual poercent
        let buttonTitle = sender.currentTitle!
        let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        tip = buttonTitleAsANumber / 100

    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        //Grab Splt text, convert to integer and assign to variable
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        //Grab bill from Text field
        let bill = billTextField.text!
        
        //Check for nill
        if bill != "" {
            
        //Assign bill total from text field, calculate full bill, covert full bill to string
            billTotal = Double(bill)!
            let result = billTotal * (1 + tip) / Double(numberOfPeople)
            finalResult = String(format: "%.2f", result)
        }
        //Segue info to other page
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResults" {
            
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = finalResult
            //Turn tip back into percent 
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberOfPeople
        }
    }
}
