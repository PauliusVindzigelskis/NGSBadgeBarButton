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

    var imageButton:NGSBadgeBarButton!
    var textButton:NGSBadgeBarButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named:"burger")!
        let insets = UIEdgeInsetsMake(0, 5, 0, -5)
        self.imageButton = NGSBadgeBarButton(badgeButtonWithImage: image, target: self, selector: #selector(self.burgerPressed(_:)), insets:insets)
        self.imageButton.badgeLabel.font = UIFont.systemFont(ofSize: 10)
        self.navigationItem.leftBarButtonItem = self.imageButton
        
        
        self.textButton = NGSBadgeBarButton(badgeButtonWithTitle: "Customers", target: self, selector: #selector(self.burgerPressed(_:)))
        self.navigationItem.rightBarButtonItem = self.textButton
    }
    
    @objc func burgerPressed(_ sender:Any)
    {
        //empty implementation
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        self.imageButton.badgeLabel.text = text
        self.textButton.badgeLabel.text = text
        return true
    }
    
    
    
}

