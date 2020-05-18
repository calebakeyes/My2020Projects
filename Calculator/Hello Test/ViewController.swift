//
//  ViewController.swift
//  Calculator
//
//  Created by Caleb Keyes on 4/27/20.
//  Copyright © 2020 Caleb Keyes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var labelValue: Double = 0
    var previousValue: Double = 0;
    var performingOperator = false;
    var operation = 0
    var decimalPresent = false
    
    @IBOutlet var Label: UILabel!
    
    @IBOutlet var decimalPoint: UIButton!
    
    @IBAction func addPoint(_ sender: UIButton) {
        let charset = CharacterSet(charactersIn: Label.text!)
        if charset.contains(".")
        {
            decimalPresent = true
        }
        if performingOperator == true && Label.text != "x" && Label.text != "/" && Label.text != "-" && Label.text != "+" && decimalPresent == false
        {
            Label.text = String(".")
            labelValue = Double(Label.text!)!
            performingOperator = false;
        }
        else if Label.text != "x" && Label.text != "/" && Label.text != "-" && Label.text != "+" && decimalPresent == false
        {
        Label.text = Label.text! + String(".")
        labelValue = Double(Label.text!)!
        }
    }

    @IBAction func numbers(_ sender: UIButton) {
        if performingOperator == true
        {
            Label.text = String(sender.tag-1)
            labelValue = Double(Label.text!)!
            performingOperator = false;
        }
        else
        {
        Label.text = Label.text! + String(sender.tag-1)
        labelValue = Double(Label.text!)!
        }
    }
    
    @IBAction func otherButtons(_ sender: UIButton) {
        if Label.text != "" && sender.tag != 11 && sender.tag != 18
        {
            previousValue = Double(Label.text!)!
            
            if sender.tag == 12 //negative
            {
                Label.text = String(previousValue * -1)
            }
            else if sender.tag == 13 //percent
            {
                 Label.text = String(previousValue / 100)
            }
            else if sender.tag == 14 //divide
            {
              Label.text = "/"
            }
            else if sender.tag == 15 //multiply
            {
              Label.text = "x"
            }
            else if sender.tag == 16 // subtract
            {
              Label.text = "-"
            }
            else if sender.tag == 17 //add
            {
                Label.text = "+"
            }
            operation = sender.tag
            performingOperator = true;
        }
       else if  sender.tag == 18
        {
            if operation == 12
            {
                Label.text = String(previousValue * -1)
            }
            if operation == 14
            {
                Label.text = String(previousValue / labelValue)
            }
            else if operation == 15
            {
                Label.text = String(previousValue * labelValue)
            }
            else if operation == 16
            {
                Label.text = String(previousValue - labelValue)
            }
            else if operation == 17
            {
                Label.text = String(previousValue + labelValue)
            }
        }
        else if sender.tag == 11
        {
            Label.text = ""
            previousValue = 0
            labelValue = 0
            operation = 0
            decimalPresent = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
