//
//  TitleSubTitleVStackView.swift
//  BiCycler
//
//  Created by Vikash Anand on 14/06/22.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, *)
public class TitleSubTitleLabelVStackModel: ObservableObject {
    public init(titleText: String,
                titleTextStyle: TextStyle = .init(font: .system(size: 25).weight(.bold), color: .black),
                subTitleText: String,
                subTitleTextStyle: TextStyle = .init(font: .footnote, color: .black)) {
        self.titleText = titleText
        self.titleTextStyle = titleTextStyle
        self.subTitleText = subTitleText
        self.subTitleTextStyle = subTitleTextStyle
    }
    
    let titleText: String
    let titleTextStyle: TextStyle
    let subTitleText: String
    let subTitleTextStyle: TextStyle
}

@available(iOS 13.0, macOS 10.15, *)
public struct TitleSubTitleLabelVStackView: View {
    
    @ObservedObject var model: TitleSubTitleLabelVStackModel
    public init(with model: TitleSubTitleLabelVStackModel) {
        self.model = model
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(model.titleText)
                .font(model.titleTextStyle.font)
                .foregroundColor(model.titleTextStyle.color)
            
            Text(model.subTitleText)
                .font(model.subTitleTextStyle.font)
                .foregroundColor(model.subTitleTextStyle.color)
        }
    }
}

@available(iOS 13.0, macOS 10.15, *)
struct TitleSubTitleVStackView_Previews: PreviewProvider {
    
    static var previews: some View {
        let model: TitleSubTitleLabelVStackModel = .init(
            titleText: "047 Ofiar Dabia",
            titleTextStyle: .init(font: .system(size: 25).weight(.bold), color: .black),
            subTitleText: "600m - Bike Station",
            subTitleTextStyle: .init(font: .footnote, color: .black)
        )
        
        return TitleSubTitleLabelVStackView(with: model)
    }
}
