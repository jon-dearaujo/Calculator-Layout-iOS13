//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    var ongoingOperation: String? = Optional.none
    var collectedLeftOperand: Double? = Optional.none
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        displayLabel.text = nil
    }
    
    
    @IBAction func reverseButtonPressed(_ sender: Any) {
        guard let currentText = displayLabel.text, currentText != "0" else {
            return
        }

        if currentText.contains("-") {
            displayLabel.text = String(currentText.suffix(from: currentText.index(after: currentText.startIndex)))
        } else {
            displayLabel.text = "-\(currentText)"
        }
    }
    
    
    @IBAction func percentButtonPressed(_ sender: Any) {
        guard let currentValueText = displayLabel.text, let currentValue = Double(currentValueText) else {
            return
        }
        
        displayLabel.text = String(currentValue / 100)
    }
    
    
    
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        guard let op = sender.titleLabel?.text else {
            return
        }
        setOngoingOperation(op: op)
    }
    
    @IBAction func dotButtonPressed(_ sender: Any) {
        guard let currentText = displayLabel.text, !currentText.contains(".") else {
            return
        }
        
        displayLabel.text = currentText + "."
    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        
        guard let currentText = displayLabel.text, let pressedButtonLabel = sender.titleLabel?.text, currentText != "0" else {
            displayLabel.text = sender.titleLabel?.text
            return
        }

        displayLabel.text = "\(currentText)\(pressedButtonLabel)"
    }

    
    @IBAction func onResultPressed(_ sender: Any) {
        guard let currentValueText = displayLabel.text, let op = ongoingOperation, let leftOperand = collectedLeftOperand, let currentValue = Double(currentValueText) else {
            return
        }
        
        var result: Double = 0
        
        switch op {
        case "+":
            result = leftOperand + currentValue
        case "-":
            result = leftOperand - currentValue
        case "x":
            result = leftOperand * currentValue
        case "÷":
            result =  currentValue == 0 ? 0 : leftOperand / currentValue
        default:
            result = 0
        }
        
        
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            displayLabel.text = String(Int(result))
        } else {
            displayLabel.text = String(result)
        }
        
        ongoingOperation = nil
        collectedLeftOperand = nil
    }
    
 
    private func setOngoingOperation(op: String) {
        guard let currentText = displayLabel.text, ongoingOperation == nil else {
            return
        }
        
        ongoingOperation = op
        collectedLeftOperand = Double(currentText)
        
        displayLabel.text = nil
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

