//
//  ImageLoader.swift
//  CachedAsyncImageView
//
//  Created by Vikash Anand on 06/11/23.
//

import SwiftUI

actor ImageLoader {
    private var images: [URLRequest: LoaderStatus] = [:]
    public func fetch(_ url: URL) async throws -> UIImage {
        let request = URLRequest(url: url)
        return try await fetch(request)
    }
    
    public func fetch(_ urlRequest: URLRequest) async throws -> UIImage {
        if let status: LoaderStatus = images[urlRequest], case .inProgress(let task) = status {
            return try await task.value
        }
        
        let task: Task<UIImage, Error> = Task {
            let (imageData, _) = try await URLSession.shared.data(for: urlRequest)
            let image = UIImage(data: imageData)!
            return image
        }
        
        images[urlRequest] = .inProgress(task)
        let image = try await task.value
        images.removeValue(forKey: urlRequest)
        return image
    }
    
    private enum LoaderStatus {
        case inProgress(Task<UIImage, Error>)
    }
}
