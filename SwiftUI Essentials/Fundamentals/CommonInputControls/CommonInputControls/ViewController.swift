//
//  ViewController.swift
//  CommonInputControls
//
//  Created by CL10102-M on 2022/4/7.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var toggle: UISwitch!
    @IBOutlet var slider: UISlider!
    @IBOutlet var button: UIButton!
    @IBOutlet var label: UILabel!
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button.addTarget(self, action: #selector(bottonTapped(_:)), for: .touchUpInside)
        
    }
    
    @IBAction func respondToTapGesture(_ sender: UITapGestureRecognizer) {
        let loc = sender.location(in: view)
        print(loc)
    }
    
    @IBAction func bottonTapped(_ sender: UIButton) {
        print("Button was tapped!")

        if toggle.isOn {
            print("The switch is on!")
        } else {
            print("The switch is off.")
        }

        print("The slider is set to \(slider.value)")
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        if sender.isOn {
            print("\(sender.tag) is on.")
        } else {
            print("\(sender.tag) is off.")
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print(sender.value)
    }
    
    @IBAction func keyboardReturnKeyTapped(_ sender: UITextField) {
        if let text = sender.text, !text.isEmpty {
            print("\(text)")
        }
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        if let text = sender.text {
            print("\(text)")
        }
    }
    
    @IBAction func setTextButtonTapped(_ sender: UIButton) {
        label.text = textField.text
    }
    @IBAction func clearTextButtonTapped(_ sender: UIButton) {
        label.text = ""
        textField.text = ""
    }
}

