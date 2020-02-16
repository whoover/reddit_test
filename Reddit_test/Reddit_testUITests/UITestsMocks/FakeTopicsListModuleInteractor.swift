//
//  FakeTopicsListModuleInteractor.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCoreServices

class FakeTopicsListModuleInteractor: TopicsListModuleInteractorInput {
    var firstTime = true
    func loadImage(_ imageURL: URL, _ completionBlock: BlockObject<LoadedImage?, Void>) -> CancellableProtocol? {
        if firstTime {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                completionBlock.execute(LoadedImage(image: UIImage(named: "fake_image"), imageSource: .network))
            }
            firstTime = false
        } else {
            completionBlock.execute(LoadedImage(image: UIImage(named: "fake_image"), imageSource: .network))
        }
        return nil
    }
    
    func reloadTopics(progressBlock: BlockObject<TopicsScreenState, Void>) {
        loadTopics(progressBlock: progressBlock)
    }
    
    func onStart(completionBlock: BlockObject<[RedditTopicCellModel], Void>) {
        completionBlock.execute([])
    }
    
    var loaded = false
    func loadTopics(progressBlock: BlockObject<TopicsScreenState, Void>) {
        guard !loaded else {
            return
        }
        var fakeTopics: [RedditTopicModel] = []
        for i in 1...10 {
            let thumbnailURLString = "https://external-preview.redd.it/xak3uQ76ELtHVRBsKuBfknG92rXk5xeQa9BsbzcjhQk.png?auto=webp&s=4218fe5f8ffdd86f043fe3b4840c6e4db78d24a3"
            let previewURLString = "https://test/some.png"
            let model = RedditTopicModel(title: "Some fake title \(i)", author: "Some fake author \(i)", created: Date().timeIntervalSince1970, commentsNumber: 42, score: 42, name: "Some fake name \(i)", thumbnailURL: thumbnailURLString, previewURL: previewURLString)
            fakeTopics.append(model)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            progressBlock.execute(.dataLoaded(CellViewModelAddapterService().convert(fakeTopics)))
        }
        loaded = true
    }
}
