/*
    *  ViewController.swift
    *  CalculatorApp_Part_02
    *  Created by Raj Kumar Shahu on 2020-10-02.
    *  StudentID: 300783746
    *  Description:
            * This is the second part of the Calculator App assignment.
            * In this part, logic is implemented to make the Calculator App functioning.
 */

import UIKit

class ViewController: UIViewController
    {
        var leftOperand = 0.0       // left operand for the operation
        var rightOperand = 0.0      // right opernad for the operation
        var clickedOperator = ""    // currently clicked Operator
        var activeOperator = ""     // active operator
        var operationResult = 0.0   //result of operation = leftOperand activeOperator rightOperand
        var resetInputLabel = true  // resetInputLabel  = true means start of operation
                                                    // also when we click numbers it will replace existing numbers.

    @IBOutlet weak var ResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func OnNumberButton_Press(_ sender: UIButton)
    {
                
        switch sender.titleLabel?.text!
        {
        case "C":
            ResultLabel.text! = "0"
            leftOperand = 0.0
            rightOperand = 0.0
            operationResult = 0.0
            clickedOperator = ""
            activeOperator = ""
            resetInputLabel = true
        case "⌫":
            ResultLabel.text!.removeLast()
            if((ResultLabel.text!.count < 1) || (ResultLabel.text! == "-"))
            {
                ResultLabel.text! = "0"
            }
        case "π":
            ResultLabel.text!.removeLast()
            ResultLabel.text! = String(Double.pi)
        case ".":
            if(!ResultLabel.text!.contains(".")) // Gets concatenated to decimal
            {
                ResultLabel.text! += "."
            }
            else if (!ResultLabel.text!.contains("0")){ // Gets concatenated to "0."
                 ResultLabel.text! += "0."
            }
        case "+/-":
            if(ResultLabel.text! != "0")
            {
                if(!ResultLabel.text!.contains("-"))
                {
                    ResultLabel.text!.insert("-", at: ResultLabel.text!.startIndex)
                }
                else
                {
                    ResultLabel.text!.remove(at: ResultLabel.text!.startIndex)
                }
            }
        default:
            print("default")
            // This gets executed when we click numbers
            if(resetInputLabel || ResultLabel.text! == "0")
            {
                // if start this is executed
                ResultLabel.text = sender.titleLabel!.text!
                resetInputLabel = false;
            }
            else
            {
                if(ResultLabel.text!.count > 15 ) // This will restrict the result character to no more than 15
                {
                    return
                }
                ResultLabel.text! += sender.titleLabel!.text!
            }
        }
    }
    
    @IBAction func OnOperatorButton_Press(_ sender: UIButton)
    {
        // when operator is clicked this gets executed
            clickedOperator = sender.titleLabel!.text!
        print(clickedOperator)
            
            let singleOperandOperator = ["=", "sin", "cos", "tan", "√"];
            
        
            if(activeOperator == "")
            {
                activeOperator = clickedOperator
                resetInputLabel = true;
            }
            
            if(operationResult != 0.0) {
                return // exit the code block
            }
            
            
            if(leftOperand != 0.0)
            {
                rightOperand = Double(ResultLabel.text!)!
            }
            else
            {
                print(ResultLabel.text!)
                leftOperand = Double(ResultLabel.text!)!
            }
            
            if(rightOperand == 0.0 && !singleOperandOperator.contains(clickedOperator))
            {
                return // exit the block if rightOperand is zero. If currently currentClicked operator is "=" we will not exit the function but we will show operationResult
            }
            
            
            // this part of the code gets executed
                    // only if we have both left and right operands and active Operator
            
            // this is special case for "%" computation
            if(clickedOperator == "%")
            {
                rightOperand = rightOperand / 100
            }
        
        switch activeOperator
        {
            case "+":
                operationResult = leftOperand + rightOperand
            case "-":
                operationResult = leftOperand - rightOperand
            case "X":
                operationResult = leftOperand * rightOperand
            case "÷":
                operationResult = leftOperand / rightOperand
            case "=":
                operationResult = leftOperand
            case "sin":
                operationResult = Double(round(1000*sin(leftOperand * Double.pi/180))/1000)
            case "cos":
                operationResult = Double(round(1000*cos(leftOperand * Double.pi/180))/1000)
            case "tan":
                operationResult = Double(round(1000*tan(leftOperand * Double.pi/180))/1000)
            case "√":
                operationResult = sqrt(leftOperand)
            default:
                ResultLabel.text! = "Wrong operation!!!"
        }
        // Reset process for next operation
        leftOperand = operationResult
        rightOperand = 0.00
        activeOperator = clickedOperator
        resetInputLabel = true
        operationResult = 0.00;
        
        var resultStr = "";
        
        // Removes the meaningless .0 if appears after whole number
        if(leftOperand.truncatingRemainder(dividingBy: 1) == 0)
        {
            resultStr = String(Int(leftOperand));
        }else {
            resultStr = String(leftOperand);
        }
        var resultSubstr = ""
        
        if(resultStr.count > 15)
        {
            // Clip the irrational number (or recurring decimal result) to only 15 digits
            resultSubstr = String(resultStr.prefix(upTo: resultStr.index(resultStr.startIndex, offsetBy: 15)))
        } else {
            resultSubstr = resultStr
        }
    print(resultSubstr)
        ResultLabel.text! = resultSubstr
    }
}

