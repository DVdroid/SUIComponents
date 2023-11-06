//
//  View+Async.swift
//  CachedAsyncImageView
//
//  Created by Vikash Anand on 06/11/23.
//

import SwiftUI

@available(iOS, deprecated: 15.0, message: "Useful when targeting iOS versions earlier than 15")
extension View {
    func task(
        priority: TaskPriority = .userInitiated,
        _ action: @escaping () async -> Void
    ) -> some View {
        modifier(TaskModifier(
            priority: priority,
            action: action
        ))
    }
}

private struct TaskModifier: ViewModifier {
    var priority: TaskPriority
    var action: () async -> Void

    @State private var task: Task<Void, Never>?
    func body(content: Content) -> some View {
        content
            .onAppear {
                task = Task(priority: priority) {
                    await action()
                }
            }
            .onDisappear {
                task?.cancel()
                task = nil
            }
    }
}
