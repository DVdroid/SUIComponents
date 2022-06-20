//
//  IconWithBodyAndFooterLabelVStackView.swift
//  BiCycler
//
//  Created by Vikash Anand on 14/06/22.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, *)
public class IconWithBodyAndFooterLabelVStackViewModel: ObservableObject {
    public init(iconName: String,
                bodyText: String,
                bodyTextStyle: TextStyle = .init(font: .footnote, color: .black),
                footerText: String,
                footerTextStyle: TextStyle = .init(font: .system(size: 60).weight(.bold), color: .green)) {
        self.iconName = iconName
        self.bodyText = bodyText
        self.bodyTextStyle = bodyTextStyle
        self.footerText = footerText
        self.footerTextStyle = footerTextStyle
    }
    
    let iconName: String
    let bodyText: String
    let bodyTextStyle: TextStyle
    let footerText: String
    let footerTextStyle: TextStyle
}


@available(iOS 13.0, macOS 10.15, *)
public struct IconWithBodyAndFooterLabelVStackView: View {
    
    @ObservedObject var model: IconWithBodyAndFooterLabelVStackViewModel
    public init(with model: IconWithBodyAndFooterLabelVStackViewModel) {
        self.model = model
    }
    
    public var body: some View {
        VStack {
            Image(model.iconName)
                .resizable()
                .frame(width: 24, height: 24)
            
            Text(model.bodyText)
                .font(model.bodyTextStyle.font)
                .foregroundColor(model.bodyTextStyle.color)
            
            Text(model.footerText)
                .font(model.footerTextStyle.font)
                .foregroundColor(model.footerTextStyle.color)
        }
    }
}

@available(iOS 13.0, macOS 10.15, *)
struct IconWithBodyAndFooterLabelVStackView_Previews: PreviewProvider {
    
    static var previews: some View {
        let model: IconWithBodyAndFooterLabelVStackViewModel = .init(
            iconName: "Lock",
            bodyText: "Available bikes",
            bodyTextStyle: .init(font: .footnote, color: .black),
            footerText: "7",
            footerTextStyle: .init(font: .system(size: 60).weight(.bold), color: .green)
        )
        
        IconWithBodyAndFooterLabelVStackView(with: model)
    }
}
