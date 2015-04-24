//
//  ViewController.swift
//  Tipper
//
//  Created by sida zhang on 4/22/15.
//  Copyright (c) 2015 sidney zhang. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var total2Label: UILabel!
    @IBOutlet weak var total3Label: UILabel!
    @IBOutlet weak var total4Label: UILabel!
    @IBOutlet weak var topPane: UIView!
    
    var opened = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        println("User editing bill")
        updateLabels()
        
        if (billField.text == "") {
            close()
        } else {
            open()
        }
    }
    
    func updateLabels() {
        var billAmount = (billField.text as NSString).doubleValue
        println(billAmount)
        var tipPercentages = [0.18,0.2,0.22]
        var tip = billAmount * tipPercentages[tipControl.selectedSegmentIndex]
        var total = billAmount + tip
        println(tip)
        tipLabel.text = formatCurrency(tip)
        totalLabel.text = formatCurrency(total)
        total2Label.text = formatCurrency(total/2)
        total3Label.text = formatCurrency(total/3)
        total4Label.text = formatCurrency(total/4)
    }

    func close() {
        if (!opened) {
            return
        }
        
        UIView.animateWithDuration(0.7, animations: {
            self.tipControl.alpha = 0
            var topFrame = self.topPane.frame
            topFrame.origin.y += 90
            
            self.topPane.frame = topFrame
            self.opened = false
        })
    }
    
    func open() {
        if (opened) {
            return
        }
        UIView.animateWithDuration(0.7, animations: {
            self.tipControl.alpha = 1
            var topFrame = self.topPane.frame
            topFrame.origin.y -= 90
            
            self.topPane.frame = topFrame
            self.opened = true
        })
    }
    
    
    func formatCurrency(value: Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        
        var numberFromField = value
        return formatter.stringFromNumber(numberFromField)!
    }
    
    func saveBillAmount() {
        var billAmount = (billField.text as NSString).doubleValue
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(billAmount, forKey: "bill_amount")
        defaults.setObject(NSDate(), forKey: "bill_amount_saved_at")
        defaults.synchronize()
    }
    
    func showBillAmount() {
        var defaults = NSUserDefaults.standardUserDefaults()
        var billAmount = defaults.doubleForKey("bill_amount")
        var savedAt = defaults.objectForKey("bill_amount_saved_at")
        
        if (savedAt == nil) {
            println("No amount saved")
        } else {
            var savedAt = savedAt as! NSDate
            
            var tenMinutesAfterSave = savedAt.dateByAddingTimeInterval(NSTimeInterval(10*60))
            if isAfter(tenMinutesAfterSave, date2: NSDate()) {
                println("Still within ten minutes show the amount")
                billField.text = String(format:"%.2f",billAmount)
                open()
            }
            
        }
        
        defaults.synchronize()
    }
    
    func isAfter(date1: NSDate, date2: NSDate) -> Bool {
        if date1.compare(date2) == NSComparisonResult.OrderedDescending
        {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var defaults = NSUserDefaults.standardUserDefaults()
        var tipIndexChosen = defaults.integerForKey("default_tip_index")
        tipControl.selectedSegmentIndex = tipIndexChosen
        
        showBillAmount()
        updateLabels()
        
        println("view will appear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        billField.becomeFirstResponder()
        
        println("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        saveBillAmount()
        println("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println("view did disappear")
    }
}


