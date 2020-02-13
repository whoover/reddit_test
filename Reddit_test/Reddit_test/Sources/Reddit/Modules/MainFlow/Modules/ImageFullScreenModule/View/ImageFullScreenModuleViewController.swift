//
//  ImageFullScreenModuleViewController.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

class ImageFullScreenModuleViewController: UIViewController, ViewControllerProtocol {
    fileprivate static let sourceImageUrlRestorableKey = "sourceImageUrlRestorableKey"

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var sourceImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var saveOperationActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    
    var output: ImageFullScreenModuleViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        output?.viewDidLoad()
    }
}

// MARK: - Configure
extension ImageFullScreenModuleViewController: ImageFullScreenModuleViewInput {
    private func setupSubviews() {
        
    }
}

// MARK: View Input
extension ImageFullScreenModuleViewController {
    func set(title: String) {
        self.title = title
    }
}

// MARK: Button Action
extension ImageFullScreenModuleViewController {
    
}
