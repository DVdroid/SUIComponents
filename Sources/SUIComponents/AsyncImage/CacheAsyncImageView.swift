//
//  CacheAsyncImageView.swift
//  CacheAsyncImageView
//
//  Created by Vikash Anand on 05/11/23.
//

import SwiftUI

enum AsyncImagePhase_Backported : Sendable {
    case empty
    case success(Image)
    case failure(Error)
}

struct CacheAsyncImageView<Content>: View where Content: View {
    
    init(url: URL, 
         scale: CGFloat = 1.0,
         transaction: Transaction = .init(),
         @ViewBuilder content: @escaping (AsyncImagePhase_Backported) -> Content) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase_Backported) -> Content
    
    var body: some View {
        if let cachedImage = ImageCache[url] {
            content(.success(cachedImage))
        } else {
            getContent()
        }
    }
    
    @ViewBuilder
    private func getContent() -> some View {
        if #available(iOS 15, *) {
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction
            ) { cacheAndRender(phase: $0) }
        } else {
            AsyncImage_Backported(
                url: url,
                scale: scale,
                transaction: transaction
            ) { cacheAndRender_backPorted(phase: $0) }
        }
    }
    
    @available(iOS 13, *)
    private func cacheAndRender_backPorted(phase: AsyncImagePhase_Backported) -> some View {
        switch phase {
        case .empty:
            return content(.empty)
        case .success(let image):
            ImageCache[url] = image
            return content(.success(image))
        case .failure(let error):
            return content(.failure(error))
        }
    }
    
    @available(iOS 15, *)
    private func cacheAndRender(phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            return content(.empty)
        case .success(let image):
            ImageCache[url] = image
            return content(.success(image))
        case .failure(let error):
            return content(.failure(error))
        @unknown default:
            return content(.empty)
        }
    }
}

fileprivate class ImageCache {
    static private var cache: [URL: Image] = [:]
    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        } set {
            ImageCache.cache[url] = newValue
        }
    }
}
