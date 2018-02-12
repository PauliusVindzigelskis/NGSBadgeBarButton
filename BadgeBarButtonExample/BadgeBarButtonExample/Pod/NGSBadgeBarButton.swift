//
//  NGSBadgeBarButton.swift
//  BadgeBarButtonExample
//
//  Created by Vindzigelskis, Paulius on 2/12/18.
//  Copyright © 2018 New Guy Studio. All rights reserved.
//

import UIKit

open class NGSBadgeBarButton : UIBarButtonItem
{
    private static let defaultBadgeInset:CGFloat = 5
    
    public private(set) weak var badgeLabel:UILabel! = nil
    public var badgeInsets:UIEdgeInsets = UIEdgeInsets(top: defaultBadgeInset,
                                                left: defaultBadgeInset,
                                                bottom: -defaultBadgeInset,
                                                right: -defaultBadgeInset)
    
    private var badgeInsetConstraints:[NSLayoutConstraint] = []
    private weak var badgeContainer:UIView! = nil
    
    public convenience init(badgeButtonWithImage image:UIImage, target:Any, selector:Selector)
    {
        let view = UIView()
        let fontSize:CGFloat = 12.0
        let badgeFont = UIFont.systemFont(ofSize: fontSize)
        
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.addTarget(target, action: selector, for: .touchUpInside)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            // stick to container's bottom left
            button.leftAnchor.constraint(equalTo: view.leftAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let badgeView = UIView()
        badgeView.backgroundColor = UIColor.red
        badgeView.layer.masksToBounds = true
        
        let badge = UILabel()
        badge.textAlignment = .center
        badge.textColor = UIColor.white
        badge.font = badgeFont
        badgeView.addSubview(badge)
        badge.translatesAutoresizingMaskIntoConstraints = false
        
        let defaultInset = NGSBadgeBarButton.defaultBadgeInset
        let badgeInsetConstraints = [
            badge.topAnchor.constraint(equalTo: badgeView.topAnchor, constant: defaultInset),
            badge.bottomAnchor.constraint(equalTo: badgeView.bottomAnchor, constant: -defaultInset),
            badge.leftAnchor.constraint(equalTo: badgeView.leftAnchor, constant: defaultInset),
            badge.rightAnchor.constraint(equalTo: badgeView.rightAnchor, constant: -defaultInset)
        ]
        badgeView.addConstraints(badgeInsetConstraints)
        
        view.addSubview(badgeView)
        badgeView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            // stick badge on button's right top corner
            badgeView.centerXAnchor.constraint(equalTo: button.rightAnchor),
            badgeView.centerYAnchor.constraint(equalTo: button.topAnchor),
            // close container with badge edges
            badgeView.rightAnchor.constraint(equalTo: view.rightAnchor),
            badgeView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        //min width
        badgeView.addConstraint(badgeView.widthAnchor.constraint(greaterThanOrEqualToConstant: fontSize*2))
        
        //round corners
        badgeView.layer.cornerRadius = fontSize
        
        view.layoutIfNeeded()
        
        self.init(customView: view)
        self.badgeLabel = badge
        self.badgeContainer = badgeView
        self.badgeContainer.isHidden = true
        self.badgeInsetConstraints = badgeInsetConstraints
        self.setupObservers()
    }
    
    private func setupObservers()
    {
        self.badgeLabel.addObserver(self, forKeyPath: "text", options: .new, context: nil)
        self.addObserver(self, forKeyPath: "badgeInsets", options: .new, context: nil)
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "text"
        {
            let newValue = self.badgeLabel.text
            if let value = newValue
            {
                self.badgeContainer.isHidden = value.isEmpty
            } else {
                self.badgeContainer.isHidden = true
            }
            self.badgeLabel.layoutIfNeeded()
        } else if keyPath == "badgeInsets"
        {
            self.badgeContainer.removeConstraints(self.badgeInsetConstraints)
            let insets = self.badgeInsets
            let newInsets:[NSLayoutConstraint] = [
                badgeLabel.topAnchor.constraint(equalTo: badgeContainer.topAnchor, constant: insets.top),
                badgeLabel.bottomAnchor.constraint(equalTo: badgeContainer.bottomAnchor, constant: insets.bottom),
                badgeLabel.leftAnchor.constraint(equalTo: badgeContainer.leftAnchor, constant: insets.left),
                badgeLabel.rightAnchor.constraint(equalTo: badgeContainer.rightAnchor, constant: insets.right)
            ]
            self.badgeInsetConstraints = newInsets
            self.badgeContainer.addConstraints(self.badgeInsetConstraints)
            
        }
    }
}
