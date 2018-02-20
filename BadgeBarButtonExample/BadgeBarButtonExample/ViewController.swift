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
    @IBOutlet var textField: UITextField!
    
    var imageButton:NGSBadgeBarButton!
    var textButton:NGSBadgeBarButton!
    var customButton:NGSBadgeBarButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Image Bar Button
        let image = UIImage(named:"burger")!
        let insets = UIEdgeInsetsMake(0, 5, 0, -5)
        self.imageButton = NGSBadgeBarButton(badgeButtonWithImage: image, target: self, selector: #selector(self.burgerPressed(_:)), insets:insets)
        self.imageButton.badgeLabel.font = UIFont.systemFont(ofSize: 10)
        
        
        // Text Bar Button
        self.textButton = NGSBadgeBarButton(badgeButtonWithTitle: "Customers", target: self, selector: #selector(self.burgerPressed(_:)))
        
        self.navigationItem.leftBarButtonItems = [self.imageButton, self.textButton]
        
        // Custom Bar Button with repositioned badge
        let button = UIButton(type: .custom)
        button.setTitle("Custom", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.setTitleColor(UIColor.red, for: .highlighted)
        
        let reposition = CGPoint(x: 10, y: -10)
        self.customButton = NGSBadgeBarButton(badgeButtonWithCustomView: button, position:reposition)
        self.navigationItem.rightBarButtonItem = self.customButton
        self.customButton.badgeBackgroundColor = UIColor.green
        self.customButton.badgeLabel.textColor = UIColor.blue
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.textField.becomeFirstResponder()
    }
    
    @objc func burgerPressed(_ sender:Any)
    {
        //empty implementation
        self.dismiss(animated: true, completion: nil)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        self.imageButton.badgeLabel.text = text
        self.textButton.badgeLabel.text = text
        self.customButton.badgeLabel.text = text
        return true
    }
    
    
    
}

