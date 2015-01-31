//
//  ViewController.swift
//  Calculator
//
//  Created by WILLIAM MITCHELL on 1/31/15.
//  Copyright (c) 2015 WILLIAM MITCHELL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var display: UILabel!
    
    var userIsEnteringANumber = false
    
    @IBAction func operand(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsEnteringANumber {
            display.text = display.text! + digit
        } else {
            userIsEnteringANumber = true
            display.text = digit
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsEnteringANumber = false
        operandStack.append(displayValue)
        println("operandStack: \(operandStack)")
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsEnteringANumber {
            enter()
        }
        switch operation {
        case "✕": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "-": performOperation { $1 - $0 }
        case "√": performOperation { sqrt($0) }
        case "sin": performOperation { sin($0) }
        case "cos": performOperation { cos($0) }
        case "tan": performOperation { tan($0) }
        case "∏": displayValue = M_PI; enter()
        default : break
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsEnteringANumber = false
        }
    }
    
    private func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(operation: (Double) -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
        
}

