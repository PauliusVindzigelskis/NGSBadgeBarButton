# NGSBadgeBarButton


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
