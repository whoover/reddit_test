//
//  ImageFullScreenModuleViewController.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

class ImageFullScreenModuleViewController: UIViewController, ViewControllerProtocol {
    static let imageUrlRestorableKey = "imageUrlRestorableKey"

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var sourceImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var saveOperationActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var output: ImageFullScreenModuleViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        output?.viewDidLoad()
        restorationIdentifier = "ImageFullScreenModuleViewControllerx"
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        coder.encode(output?.restorationImageURL?.absoluteString, forKey: type(of: self).imageUrlRestorableKey)
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        if let url = coder.decodeObject(forKey: type(of: self).imageUrlRestorableKey) as? String {
            output?.restorationImageURL = URL(string: url)
        }
        super.decodeRestorableState(with: coder)
    }
}

// MARK: - Configure
extension ImageFullScreenModuleViewController: ImageFullScreenModuleViewInput {
    func didSaveImage() {
        saveOperationActivityIndicator.stopAnimating()
        saveButton.isHidden = false
    }
    
    func errorOnSavingImage() {
        saveOperationActivityIndicator.stopAnimating()
        saveButton.isHidden = false
    }
    
    func setupImage(_ image: UIImage?) {
        activityIndicator.stopAnimating()
        guard let image = image else {
            errorLabel.isHidden = false
            return
        }
        sourceImageView.image = image
        saveButton.isEnabled = true
    }
    
    private func setupSubviews() {
        activityIndicator.startAnimating()
        saveButton.isEnabled = false
        saveButton.setImage(UIImage(named: "save")?.withTintColor(.white), for: .normal)
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
    @IBAction private func didTapClose() {
        output?.didTapCloseModule()
    }
    
    @IBAction private func didTapSave() {
        saveOperationActivityIndicator.startAnimating()
        saveButton.isHidden = true
        output?.didTapSaveImage()
    }
}
