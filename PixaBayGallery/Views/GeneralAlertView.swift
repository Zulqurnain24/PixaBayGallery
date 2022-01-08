//
//  GeneralAlertView.swift
//  PixaBayGallery
//
//  Created by Mohammad Zulqurnain on 12/12/2021.
//

import UIKit

protocol GeneralAlertViewDelegate {
 
    func xibSetup()
    
    func loadViewFromNib() -> UIView

    func submitButtonPressed(_ sender: Any)
    
}

class GeneralAlertView: BaseView, GeneralAlertViewDelegate {
    let kCONTENT_XIB_NAME = "GeneralAlertView"
    
    var view: UIView!

    @IBOutlet weak var promptDescriptionLabel: UILabel!
    @IBOutlet weak var promptTitleLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!

    var submitButtonCallback: (()->Void)?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)

        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        xibSetup()
    }

    func xibSetup() {
        view = loadViewFromNib()
        
        view.frame = bounds
        
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        if let topController = keyWindow?.rootViewController {
            let blurEffect = UIBlurEffect(style: .regular)
            let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
            blurVisualEffectView.frame = topController.view.frame
            blurVisualEffectView.center = view.center
            blurVisualEffectView.tag = 111
            addSubview(blurVisualEffectView)
            addSubview(view)
        }
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of:self))
        let nib = UINib(nibName: kCONTENT_XIB_NAME, bundle: bundle)
        
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

    @IBAction func submitButtonPressed(_ sender: Any) {
        submitButtonCallback?()
        removeFromSuperview()
    }

}
