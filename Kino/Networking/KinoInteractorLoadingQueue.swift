//
//  KinoInteractorLoadingQueue.swift
//  Kino
//
//  Created by Matti on 03/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

protocol KinoInteractorLoadingQueueDelegate: class {
    func didStartLoading(queue: KinoInteractorLoadingQueue)
    func didFinishLoading(queue: KinoInteractorLoadingQueue)
}

class KinoInteractorLoadingQueue {
    enum LoadingTask {
        case popularMovies
        case trendingMovies
    }

    private weak var delegate: KinoInteractorLoadingQueueDelegate?
    private var queue: [LoadingTask]

    init(delegate: KinoInteractorLoadingQueueDelegate? = nil) {
        queue = [LoadingTask]()
        self.delegate = delegate
    }

    func add(_ task: LoadingTask) {
        if queue.isEmpty {
            delegate?.didStartLoading(queue: self)
        }
        queue.append(task)
    }

    func remove(task: LoadingTask) {
        queue.removeAll { (loadingTask) -> Bool in
            return loadingTask == task
        }
        if queue.isEmpty {
            delegate?.didFinishLoading(queue: self)
        }
    }
}
