//
//  ViewController.swift
//  BadgeBarButtonExample
//
//  Created by Vindzigelskis, Paulius on 2/12/18.
//  Copyright © 2018 New Guy Studio. All rights reserved.
//

import UIKit
import NGSBadgeBarButton

class ViewController: UIViewController, UITextFieldDelegate {

    var barButton:NGSBadgeBarButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named:"burger")!
        self.barButton = NGSBadgeBarButton(badgeButtonWithImage: image, target: self, selector: #selector(self.burgerPressed(_:)))
        
        self.navigationItem.leftBarButtonItem = self.barButton
    }
    
    @objc func burgerPressed(_ sender:Any)
    {
        
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        self.barButton.badgeLabel.text = text
        return true
    }
    
    
    
}

