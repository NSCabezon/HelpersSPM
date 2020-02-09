import Foundation
import UIKit

@IBDesignable
public class UIPlaceHolderTextView: UITextView {
    var placeholderLabel: UILabel!
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        commonInit()
        
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
        
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override public var text: String! {
        didSet {
            self.textChanged(nil)
        }
    }
    
    @IBInspectable var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
            placeholderLabel.sizeToFit()
            self.sendSubviewToBack(placeholderLabel)
            
            if placeholder.isEmpty == false && text.isEmpty {
                placeholderLabel.alpha = 1
            } else {
                placeholderLabel.alpha = 0
            }
        }
    }
    
    @IBInspectable var placeholderColor: UIColor = UIColor.lightGray {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    // MARK: - Private methods
    
    private func commonInit() {
        if placeholderLabel == nil {
            placeholderLabel = UILabel(frame: CGRect(x: 4, y: 8, width: bounds.size.width - 8, height: 0))
            placeholderLabel.lineBreakMode = .byCharWrapping
            placeholderLabel.numberOfLines = 0
            placeholderLabel.font = font
            placeholderLabel.backgroundColor = UIColor.clear
            placeholderLabel.textColor = placeholderColor
            placeholderLabel.alpha = 0
            addSubview(placeholderLabel!)
        }
    }
    
    @objc
	private func textChanged(_ notification: Notification?) {
        if placeholder.isEmpty {
            return
        }
        
        if text.isEmpty {
            placeholderLabel.alpha = 1
        } else {
            placeholderLabel.alpha = 0
        }
    }
}
