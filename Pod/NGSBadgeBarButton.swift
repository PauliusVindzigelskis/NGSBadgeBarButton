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
    //MARK:- Public accessible Properties
    public static let kDefaultBadgeInsets = UIEdgeInsetsMake(5, 5, -5, -5)
    public private(set) weak var badgeLabel:UILabel! = nil
    
    //MARK:- Private Properties
    private var badgeSizeConstraints:[NSLayoutConstraint] = []
    private weak var badgeContainer:UIView! = nil
    
    //MARK:- Public API
    
    public convenience init(badgeButtonWithImage image:UIImage, target:Any, selector:Selector, insets:UIEdgeInsets = NGSBadgeBarButton.kDefaultBadgeInsets)
    {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.addTarget(target, action: selector, for: .touchUpInside)
        self.init(badgeButtonWithCustomView: button, insets:insets)
    }
    public convenience init(badgeButtonWithTitle text:String, target:Any, selector:Selector, insets:UIEdgeInsets = NGSBadgeBarButton.kDefaultBadgeInsets)
    {
        let button = UIButton(type: .custom)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .highlighted)
        button.setTitle(text, for: .normal)
        button.addTarget(target, action: selector, for: .touchUpInside)
        self.init(badgeButtonWithCustomView: button, insets:insets)
    }
    
    public convenience init(badgeButtonWithCustomView customView:UIView, insets:UIEdgeInsets = NGSBadgeBarButton.kDefaultBadgeInsets)
    {
        // Custom view
        let view = UIView()
        let fontSize:CGFloat = 12.0
        let badgeFont = UIFont.systemFont(ofSize: fontSize)
        
        // Button disguised as UIBarButton
        view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            // stick to container's bottom left
            customView.leftAnchor.constraint(equalTo: view.leftAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
        let badgeInsetConstraints = [
            badge.topAnchor.constraint(equalTo: badgeView.topAnchor, constant: insets.top),
            badge.bottomAnchor.constraint(equalTo: badgeView.bottomAnchor, constant: insets.bottom),
            badge.leftAnchor.constraint(equalTo: badgeView.leftAnchor, constant: insets.left),
            badge.rightAnchor.constraint(equalTo: badgeView.rightAnchor, constant: insets.right)
        ]
        badgeView.addConstraints(badgeInsetConstraints)
        
        view.addSubview(badgeView)
        badgeView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            // stick badge on button's right top corner
            badgeView.rightAnchor.constraint(equalTo: customView.rightAnchor, constant: fontSize),
            badgeView.centerYAnchor.constraint(equalTo: customView.topAnchor),
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
        let sizeConstraints = [
            badgeView.widthAnchor.constraint(greaterThanOrEqualToConstant: compressedSize.height),
            badgeView.heightAnchor.constraint(greaterThanOrEqualToConstant: compressedSize.height)
        ]
        badgeView.addConstraints(sizeConstraints)
        
        // Initialize as custom bar button
        self.init(customView: view)
        
        // Setup properties
        self.badgeLabel = badge
        self.badgeContainer = badgeView
        self.badgeContainer.isHidden = true
        self.badgeSizeConstraints = sizeConstraints
        
        self.setupObservers()
        
        // Let actions go through
        self.badgeLabel.isUserInteractionEnabled = false
        self.badgeContainer.isUserInteractionEnabled = false
    }
    
    //MARK:- Private methods
    
    func setupSizeConstraints(withFont font:UIFont)
    {
        let defaultValue = self.badgeLabel.text
        let badge = self.badgeLabel!
        let badgeView = self.badgeContainer!
        
        badgeView.removeConstraints(self.badgeSizeConstraints)
        // Round corners
        badge.text = "0"
        let compressedSize = badgeView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        badgeView.layer.cornerRadius = compressedSize.height / 2
        
        // Setup min width to be round by default with short text
        self.badgeSizeConstraints = [
            badgeView.widthAnchor.constraint(greaterThanOrEqualToConstant: compressedSize.height),
            badgeView.heightAnchor.constraint(greaterThanOrEqualToConstant: compressedSize.height)
        ]
        badgeView.addConstraints(self.badgeSizeConstraints)
        
        badge.text = defaultValue
    }
    
    private func setupObservers()
    {
        // Track Badge Label setter
        self.badgeLabel.addObserver(self, forKeyPath: "text", options: .new, context: nil)
        self.badgeLabel.addObserver(self, forKeyPath: "font", options: .new, context: nil)
        
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
        } else if keyPath == "font"
        {
            self.setupSizeConstraints(withFont: self.badgeLabel.font)
        }
    }
}
