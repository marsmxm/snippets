//
//  ViewController.swift
//  TrafficSegues
//
//  Created by CL10102-M on 2022/5/9.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var segueSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func yellowButotnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "Yellow", sender: nil)
    }
    
    
    @IBAction func greenButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "Green", sender: nil)
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        false
    }
}


