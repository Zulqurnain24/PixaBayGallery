//
//  FancyLoader.swift
//  PixaBayGallery
//
//  Created by Mohammad Zulqurnain on 12/12/2021.
//

import UIKit

class FancyLoaderView: UIView {
    let kCONTENT_XIB_NAME = "FancyLoaderView"
    var view: UIView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var label: UILabel!
    
    @IBInspectable var titleLabelText: String {
         set {
             self.label.text = newValue
         }
         get {
             return label.text ?? ""
         }
     }

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        xibSetup()
        configUI()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        xibSetup()
        configUI()
        setupView()
    }

    func configUI() {
        label.center = self.center
        activityIndicator.center = self.center
    }
    
    func setupView() {
        activityIndicator.startAnimating()
        label.sizeToFit()
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        view.frame = bounds
        
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
       addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of:self))
        let nib = UINib(nibName: kCONTENT_XIB_NAME, bundle: bundle)
        
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
}
