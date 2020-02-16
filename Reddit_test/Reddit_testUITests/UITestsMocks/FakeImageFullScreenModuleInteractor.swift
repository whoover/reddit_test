//
//  FakeImageFullScreenModuleInteractor.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 16.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCoreServices

class FakeImageFullScreenModuleInteractor: ImageFullScreenModuleInteractorInput {
    func downloadImage(_ url: URL, _ completionBlock: BlockObject<LoadedImage?, Void>) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            completionBlock.execute(LoadedImage(image: UIImage(named: "testImage",
                                                               in: Bundle(for: type(of: self)),
                                                               compatibleWith: nil), imageSource: .network))
        }
    }
    
    func saveImageToCameraRoll(successBlock: EmptyBlock, errorBlock: BlockObject<Error, Void>) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            successBlock.execute(())
        }
    }
    
    func cancelImageDownloadingIfNeeded() {
        
    }
}
