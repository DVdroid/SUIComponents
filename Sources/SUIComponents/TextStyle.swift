//
//  TextStyle.swift
//  BiCycler
//
//  Created by Vikash Anand on 14/06/22.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, *)
struct TextStyle {
    init(font: Font, color: Color) {
        self.font = font
        self.color = color
    }
    
    let font: Font
    let color: Color
}
