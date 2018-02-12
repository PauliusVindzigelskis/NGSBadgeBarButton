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
        // Custom view
        let view = UIView()
        let fontSize:CGFloat = 10.0
        let badgeFont = UIFont.systemFont(ofSize: fontSize)
        
        // Button disguised as UIBarButton
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
        
        // Badge red container.
        let badgeView = UIView()
        badgeView.backgroundColor = UIColor.red
        badgeView.layer.masksToBounds = true
        
        // Label to store badge text
        let badge = UILabel()
        badge.textAlignment = .center
        badge.textColor = UIColor.white
        badge.font = badgeFont
        badgeView.addSubview(badge)
        badge.translatesAutoresizingMaskIntoConstraints = false
        
        // Badge container stretches with label by x axis. Default insets provided
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
            badgeView.rightAnchor.constraint(equalTo: button.rightAnchor, constant: fontSize),
            badgeView.centerYAnchor.constraint(equalTo: button.topAnchor),
            // close container with badge edges
            badgeView.rightAnchor.constraint(equalTo: view.rightAnchor),
            badgeView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        // Round corners
        badge.text = "0"
        let compressedSize = badgeView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        badgeView.layer.cornerRadius = compressedSize.height / 2
        badge.text = nil
        
        // Setup min width to be round by default with short text
        badgeView.addConstraint(badgeView.widthAnchor.constraint(greaterThanOrEqualToConstant: compressedSize.height))
        
        
        // Initialize as custom bar button
        self.init(customView: view)
        
        // Setup properties
        self.badgeLabel = badge
        self.badgeContainer = badgeView
        self.badgeContainer.isHidden = true
        self.badgeInsetConstraints = badgeInsetConstraints
        
        self.setupObservers()
    }
    
    private func setupObservers()
    {
        // Track Badge Value setter
        self.badgeLabel.addObserver(self, forKeyPath: "text", options: .new, context: nil)
        
        // Track Badge Insets setter
        self.addObserver(self, forKeyPath: "badgeInsets", options: .new, context: nil)
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "text"
        {
            // Badge Value
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
            // Badge Label insets in red container
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
