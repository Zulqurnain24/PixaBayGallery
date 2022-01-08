//
//  HUBManager.swift
//  PixaBayGallery
//
//  Created by Mohammad Zulqurnain on 12/12/2021.
//

import UIKit

protocol HUDManagerProtocol: AnyObject {
    static func addActivityIndicator(_ title: String, _ viewController: UIViewController)
    static func removeHUD(_ viewController: UIViewController)
    static func showGeneralAlert(viewController: UIViewController, title: String, message: String, okCallback: (()->Void)?, cancelCallback: (()->Void)?)
}

/* HUDManager
 This contains the miscellaneous functionalities like presenting Alert and resizing the image
 */
final class HUDManager: HUDManagerProtocol {

    static func addActivityIndicator(_ title: String, _ viewController: UIViewController) {
        
        let fancyLoaderFrame = CGRect(origin: viewController.view.center, size: CGSize(width: FloatConstants.addActivityIndicatorWidthRatio.rawValue * viewController.view.frame.size.width, height: FloatConstants.addActivityIndicatorHeightRatio.rawValue * viewController.view.frame.size.height))
        
        let fancyLoaderView:FancyLoaderView = FancyLoaderView(frame: fancyLoaderFrame)
        fancyLoaderView.center = viewController.view.center
        fancyLoaderView.center.y = fancyLoaderView.center.y - FloatConstants.addActivityIndicatorYOffset.rawValue
        fancyLoaderView.titleLabelText = title
        
        fancyLoaderView.startAnimating()

        viewController.view.addSubview(fancyLoaderView)
        viewController.view.bringSubviewToFront(fancyLoaderView)
    }

    static func removeHUD(_ viewController: UIViewController) {
        viewController.view.subviews.filter({$0 is FancyLoaderView || $0 is GeneralAlertView}).forEach({ view in
            view.removeFromSuperview()
        })
    }
   
    static func showGeneralAlert(viewController: UIViewController, title: String, message: String, okCallback: (()->Void)? = nil, cancelCallback: (()->Void)? = nil)
    {
        let generalAlertViewFrame = CGRect(origin: viewController.view.frame.origin, size: CGSize(width: viewController.view.frame.size.width, height: FloatConstants.generalAlertHeightRatio.rawValue * viewController.view.frame.size.height))
        
        let generalAlertViewView:GeneralAlertView =  GeneralAlertView(frame: generalAlertViewFrame)
        generalAlertViewView.promptTitleLabel.text = title
        generalAlertViewView.promptDescriptionLabel.text = message
        generalAlertViewView.submitButtonCallback = okCallback
        generalAlertViewView.center = CGPoint(x: viewController.view.center.x, y: viewController.view.center.y - generalAlertViewView.frame.height)
 
       viewController.view.addSubview(generalAlertViewView)
    }
}



