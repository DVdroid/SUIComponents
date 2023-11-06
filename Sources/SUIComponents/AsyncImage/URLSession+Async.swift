//
//  URLSession+Async.swift
//  CachedAsyncImageView
//
//  Created by Vikash Anand on 06/11/23.
//

import Foundation

@available(iOS, deprecated: 15.0, message: "Useful when targeting iOS versions earlier than 15")
public extension URLSession {
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        try await data(for: URLRequest(url: url))
    }
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        var dataTask: URLSessionDataTask?
        let onCancel = { dataTask?.cancel() }
        
        return try await withTaskCancellationHandler(
            operation: {
                
                try await withCheckedThrowingContinuation { continuation in
                    dataTask = self.dataTask(with: request) { data, response, error in
                        guard let data = data, let response = response else {
                            let error = error ?? URLError(.badServerResponse)
                            return continuation.resume(throwing: error)
                        }
                        
                        continuation.resume(returning: (data, response))
                    }
                    
                    dataTask?.resume()
                }
            },
            onCancel: {
                onCancel()
            }
        )
    }
}
