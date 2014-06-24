//
//  ViewController.swift
//  Calculater
//
//  Created by Jason on 2014/6/20.
//  Copyright (c) 2014年 Zoaks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var _dotButton : UIButton;
    @IBOutlet var _equalButton : UIButton;
    @IBOutlet var _plusButton : UIButton;
    @IBOutlet var _minusButton : UIButton;
    @IBOutlet var _multiplyButton : UIButton;
    @IBOutlet var _divideButton : UIButton;
    @IBOutlet var _percentButton : UIButton;
    @IBOutlet var _reverseButton : UIButton;
    @IBOutlet var _clearButton : UIButton;
    @IBOutlet var _valueLabel : UILabel;
    
    var valueStr : String = "0";
    var tempValueStr : String = "0";
    var isFunctionButton : Bool = false;
    var isEqualButton : Bool = false;
    var selectedOperatorButton : UIButton?;

    override func viewDidLoad() {
        super.viewDidLoad()
        _valueLabel.text = valueStr;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numberButtonClicked(button : UIButton) {
        if (isEqualButton == true) {
            valueStr = "0";
        }
        
        isEqualButton = false;
        
        animationButtonColor(button);
        
        if (isFunctionButton == false) {
            if (button.currentTitle == ".") {
                if (valueStr.bridgeToObjectiveC().containsString(".")) {
                    return;
                }
            }
            if (button.currentTitle == "0") {
                if (valueStr == "0") {
                    return;
                }
            }
            else {
                if (valueStr.hasPrefix("0")) {
                    valueStr = "";
                }
            }
            valueStr = valueStr + button.currentTitle;
            
            _valueLabel.text = valueStr;
        }
        else {
            if (button.currentTitle == ".") {
                if (tempValueStr.bridgeToObjectiveC().containsString(".")) {
                    return;
                }
            }
            if (button.currentTitle == "0") {
                if (tempValueStr == "0") {
                    return;
                }
            }
            else {
                if (tempValueStr.hasPrefix("0")) {
                    tempValueStr = "";
                }
            }
            tempValueStr = tempValueStr + button.currentTitle;
            
            _valueLabel.text = tempValueStr;
        }
    }
    
    @IBAction func functionButtonClicked(button : UIButton) {
        clearButtonBorderWidth();
        isEqualButton = false;
        if (isFunctionButton == false) {
            if (button == _clearButton) {
                valueStr = "0";
                tempValueStr = "0";
                isFunctionButton = false;
            }
            if (button == _reverseButton) {
                let tempStr : NSString = "-";
                if (valueStr == "0") {
                    return;
                }
                if (!valueStr.bridgeToObjectiveC().containsString(tempStr)) {
                    valueStr = tempStr.stringByAppendingString(valueStr);
                }
                else {
                    var tempArr : NSArray = valueStr.componentsSeparatedByString(tempStr);
                    valueStr = tempArr.lastObject as NSString;
                }
            }
            if (button == _percentButton) {
                var tempValue : Double = valueStr.bridgeToObjectiveC().doubleValue;
                valueStr = String(tempValue / 100);
            }
            _valueLabel.text = valueStr;
        }
        else {
            if (button == _clearButton) {
                valueStr = "0";
                tempValueStr = "0";
                isFunctionButton = false;
            }
            if (button == _reverseButton) {
                let tempStr : NSString = "-";
                if (tempValueStr == "0") {
                    return;
                }
                if (!tempValueStr.bridgeToObjectiveC().containsString(tempStr)) {
                    tempValueStr = tempStr.stringByAppendingString(tempValueStr);
                }
                else {
                    var tempArr : NSArray = tempValueStr.componentsSeparatedByString(tempStr);
                    tempValueStr = tempArr.lastObject as NSString;
                }
            }
            if (button == _percentButton) {
                var tempValue : Double = tempValueStr.bridgeToObjectiveC().doubleValue;
                tempValueStr = String(tempValue / 100);
            }
            _valueLabel.text = tempValueStr;
        }
    }
    
    @IBAction func operatorButtonClicked(button : UIButton) {
        if (button == _plusButton || button == _minusButton || button == _multiplyButton || button == _divideButton) {
            clearButtonBorderWidth();
            
            isEqualButton = false;
            selectedOperatorButton = button;
            isFunctionButton = true;
            tempValueStr = "0";
            
            button.layer.borderColor = UIColor.whiteColor().CGColor;
            button.layer.borderWidth = 2.0;
        }
        if (button == _equalButton) {

            isEqualButton = true;
            // 加減乘除運算
            var number : Double = valueStr.bridgeToObjectiveC().doubleValue;
            var tempNumber : Double = tempValueStr.bridgeToObjectiveC().doubleValue;
            
            if (selectedOperatorButton == _plusButton) {
                valueStr = String(number + tempNumber);
            }
            if (selectedOperatorButton == _minusButton) {
                valueStr = String(number - tempNumber);
            }
            if (selectedOperatorButton == _multiplyButton) {
                valueStr = String(number * tempNumber);
            }
            if (selectedOperatorButton == _divideButton) {
                valueStr = String(number / tempNumber);
            }
            
            isFunctionButton = false;
            
            let tempStr : NSString = ".0";
            if (valueStr.hasSuffix(tempStr)) {
                var tempArr : NSArray = valueStr.componentsSeparatedByString(tempStr);
                valueStr = tempArr.firstObject as NSString;
            }
            
            _valueLabel.text = valueStr;
        }
    }
    
    func clearButtonBorderWidth() {
        _plusButton.layer.borderWidth = 0.0;
        _minusButton.layer.borderWidth = 0.0;
        _multiplyButton.layer.borderWidth = 0.0;
        _divideButton.layer.borderWidth = 0.0;
    }
    
    func animationButtonColor(button : UIButton) {
        button.alpha = 0.5;
        UIView.animateWithDuration(0.1, animations: {
            button.alpha = 1.0;
            })
    }
}

