//
//  AsyncImage_Backported.swift
//  CachedAsyncImageView
//
//  Created by Vikash Anand on 06/11/23.
//

import SwiftUI

struct ImageLoaderKey: EnvironmentKey {
    static let defaultValue = ImageLoader()
}

extension EnvironmentValues {
    var imageLoader: ImageLoader {
        get { self[ImageLoaderKey.self] }
        set { self[ImageLoaderKey.self ] = newValue}
    }
}

enum AsyncImage_BackportedLoadingState {
    case loading
    case finished(uiImage: UIImage)
    case error(Error)
}

struct AsyncImage_Backported<Content>: View where Content: View {
    
    @State private var image: UIImage?
    @Environment(\.imageLoader) private var imageLoader
    @State private var loadingState: AsyncImage_BackportedLoadingState = .loading
    @State private var animation: CGFloat = 0.9
    
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
        Group {
            switch loadingState {
            case .loading:
                content(.empty)
            case .finished(let uiImage):
                content(.success(Image(uiImage: uiImage)))
            case .error(let error):
                content(.failure(error))
            }
        }
        .scaleEffect(animation)
        .animation(
            .spring(duration: 0.2, bounce: 0.5), value: animation
        )
        .task {
            await loadImage(at: URLRequest(url: url))
        }
    }
    
    func loadImage(at source: URLRequest) async {
        do {
            let image = try await imageLoader.fetch(source)
            self.loadingState = .finished(uiImage: image)
        } catch {
            self.loadingState = .error(error)
        }
    }
}
