# NGSBadgeBarButton

Swift 3.2 and 4.0 compatible

## Install

### Cocoapod

    pod 'NGSBadgeBarButton'
    
### Manual

Import NGSBadgeBarButton.swift file into Your project

## Dependencies

None

## Usage

Note: 'insets' parameter can be omit to use default value

    // Set badge value and control label appearance
    public private(set) weak var badgeLabel:UILabel! = nil


    // Badge Bar Button with image
    init(badgeButtonWithImage image: UIImage, 
                              target: Any,
                              selector: Selector, 
                              insets: UIEdgeInsets = NGSBadgeBarButton.kDefaultBadgeInsets)
    
    // Badge Bar Button with title
    init(badgeButtonWithTitle text: String, 
                              target: Any, 
                              selector: Selector, 
                              insets: UIEdgeInsets = NGSBadgeBarButton.kDefaultBadgeInsets)
                              
    // Custom Badge Bar Button
    init(badgeButtonWithCustomView customView: UIView, 
                                   insets: UIEdgeInsets = NGSBadgeBarButton.kDefaultBadgeInsets)
                                   
 
## Demo

![ngsbadgebarbutton_demo](https://user-images.githubusercontent.com/2383901/36121468-e32e9756-100b-11e8-9e64-ddcd0d6e8514.gif)
