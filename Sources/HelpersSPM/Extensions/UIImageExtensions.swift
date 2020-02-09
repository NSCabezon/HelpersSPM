import UIKit

public extension UIImage {
	convenience init?(with color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
		let rect = CGRect(origin: .zero, size: size)
		UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
		color.setFill()
		UIRectFill(rect)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		guard let cgImage = image?.cgImage else { return nil }
		self.init(cgImage: cgImage)
	}
	
	var rounded: UIImage? {
		let imageView = UIImageView(image: self)
		imageView.layer.cornerRadius = min(size.height / 4, size.width / 4)
		imageView.layer.masksToBounds = true
		UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
		guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
		imageView.layer.render(in: context)
		let result = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
        
		return result
	}
	
	var circle: UIImage? {
		let square = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
		let imageView = UIImageView(frame: CGRect(origin: .zero, size: square))
		imageView.contentMode = .scaleAspectFill
		imageView.image = self
		imageView.layer.cornerRadius = square.width / 2
		imageView.layer.masksToBounds = true
		UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
		guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
		imageView.layer.render(in: context)
		let result = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
        
		return result
	}
}
