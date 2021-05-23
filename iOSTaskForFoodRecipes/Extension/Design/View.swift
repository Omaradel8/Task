//
//  View.swift
//  iOSTask
//
//  Created by Omar on 14/05/2021.
//

import UIKit

@IBDesignable
extension UIView {
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 0, height: 3.0),
                   shadowOpacity: Float = 0.2,
                   shadowRadius: CGFloat = 5.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
    }
}

@IBDesignable extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
            self.setNeedsLayout()
            self.setNeedsDisplay()
            self.layoutSubviews()
            self.layoutIfNeeded()
        }
    }
    
}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 80
        return sizeThatFits
    }
}

@IBDesignable
extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[kCTForegroundColorAttributeName as NSAttributedString.Key: newValue!])
        }
    }
}
extension UIViewController{
    //Check E-mail Validation
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

}
extension UIResponder {
    /**
     * Returns the next responder in the responder chain cast to the given type, or
     * if nil, recurses the chain until the next responder is nil or castable.
     */
    func next<U: UIResponder>(of type: U.Type = U.self) -> U? {
        return self.next.flatMap({ $0 as? U ?? $0.next() })
    }
}
extension UITableViewCell {
    var tableView: UITableView? {
        return self.next(of: UITableView.self)
    }

    var indexPath: IndexPath? {
        return self.tableView?.indexPath(for: self)
    }
}
extension UICollectionViewCell {
    var collectionView: UICollectionView? {
        return self.next(of: UICollectionView.self)
    }

    var indexPath: IndexPath? {
        return self.collectionView?.indexPath(for: self)
    }
}

extension UINavigationController {
  func popViewControllers(viewsToPop: Int, animated: Bool = true) {
    if viewControllers.count > viewsToPop {
      let vc = viewControllers[viewControllers.count - viewsToPop - 1]
      popToViewController(vc, animated: animated)
    }
  }
}

extension UIView
{
    func applyGradient(colors: [CGColor],corner: CGFloat)
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.30, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = corner
        self.layer.insertSublayer(gradientLayer, at: 1)
    }
    
    func dotedBorder(){
        let yourViewBorder = CAShapeLayer()
        yourViewBorder.cornerRadius = 8
        yourViewBorder.masksToBounds = true
        yourViewBorder.strokeColor = #colorLiteral(red: 0.3921568627, green: 0.09411764706, blue: 0.9607843137, alpha: 0.4615426937)
        yourViewBorder.lineDashPattern = [5, 5]
        yourViewBorder.frame = self.bounds
        yourViewBorder.fillColor = nil
        yourViewBorder.path = UIBezierPath(rect: self.bounds).cgPath
        self.layer.addSublayer(yourViewBorder)
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

extension UIViewController{
    
    func presentFreshFeelsAlert(message : String, grayButtonTitle : String, secondButtonTitle : String, alertImage: UIImage, needSecondButton: Bool, first: @escaping (()->()), second: @escaping (()->()))  {
        let alerVC = FoodLandAlertVC(message: message, firstButtonTitle: grayButtonTitle, secondButtonTitle: secondButtonTitle, image: alertImage, needSecondButton: needSecondButton , first: first, second: second)
        alerVC.modalPresentationStyle = .overFullScreen
        alerVC.modalTransitionStyle = .crossDissolve
        self.present(alerVC,animated: true)
    }
}

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
