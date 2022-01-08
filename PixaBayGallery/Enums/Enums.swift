//
//  Enums.swift
//  PixaBayGallery
//
//  Created by Mohammad Zulqurnain on 12/12/2021.
//

import UIKit

// swift result type
enum ResultType<T> {
    case Success(T)
    case Failure(e: Error?)
}

// Error for unknown case
enum JSONDecodingError: Error, LocalizedError {
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .unknownError:
            return NSLocalizedString("Unknown Error occured", comment: "")
        }
    }
}

//StringConstants Enum
enum StringConstants: String {
    typealias RawValue = String
    
    case permissionForPhotos = "You need to give me permission to save the photo."
    case permissionNeeded = "Permission Needed"
    case images = "Images"
    case loading = "Please Wait..."
    case openSettings = "1. Open Settings"
    case readAndWrite = "3. Select Read and Write"
    case tap = "2. Tap"
    case greaterThanPhotos = " > Photos"
    case dismiss = "Dismiss"
    case error = "Error"
    case empty = ""
    case networkErrorDescription = "It appears there is something wrong with your network connection. Please restore the network connection and try again"
}


//FloatConstants Enum
enum FloatConstants: CGFloat {
    typealias RawValue = CGFloat
    
    case generalAlertHeightRatio = 0.25
    case addActivityIndicatorWidthRatio = 0.35
    case addActivityIndicatorHeightRatio = 0.26
    case addActivityIndicatorYOffset = 100
}
