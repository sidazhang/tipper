//
//  SettingsViewController.swift
//  Tipper
//
//  Created by sida zhang on 4/23/15.
//  Copyright (c) 2015 sidney zhang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var tipDefaultControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var defaults = NSUserDefaults.standardUserDefaults()
        var tipIndexChosen = defaults.integerForKey("default_tip_index")
        tipDefaultControl.selectedSegmentIndex = tipIndexChosen
    }
    
    @IBAction func onDefaultEdit(sender: AnyObject) {
        var defaultTipChosen = tipDefaultControl.selectedSegmentIndex
        println("User Editting default \(defaultTipChosen)")
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTipChosen, forKey: "default_tip_index")
        defaults.synchronize()
    }

    @IBAction func dissmissView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
