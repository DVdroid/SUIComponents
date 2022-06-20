//
//  BikeStationInfoCardView.swift
//  BiCycler
//
//  Created by Vikash Anand on 14/06/22.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, *)
public class BikeStationInfoCardModel: ObservableObject, Identifiable {
    
    public init(titleText: String,
         titleTextStyle: TextStyle = .init(font: .system(size: 25).weight(.bold), color: .black),
         subTitleText: String,
         subTitleTextStyle: TextStyle = .init(font: .footnote, color: .black),
         leftBodyText: String = "Available bikes",
         leftBodyTextStyle: TextStyle = .init(font: .footnote, color: .black),
         rightBodyText: String = "Available places",
         rightBodyTextStyle: TextStyle = .init(font: .footnote, color: .black),
         leftCounterText: String,
         leftCounterTextStyle: TextStyle = .init(font: .system(size: 60).weight(.bold), color: .green),
         rightCounterText: String,
         rightCounterTextStyle: TextStyle = .init(font: .system(size: 60).weight(.bold), color: .black),
         cornerRadius: CGFloat = 8,
         latitude: Double = 16.911623,
         longitude: Double = 52.402831) {
        self.id = UUID()
        self.titleText = titleText
        self.titleTextStyle = titleTextStyle
        self.subTitleText = subTitleText
        self.subTitleTextStyle = subTitleTextStyle
        self.leftBodyText = leftBodyText
        self.leftBodyTextStyle = leftBodyTextStyle
        self.rightBodyText = rightBodyText
        self.rightBodyTextStyle = rightBodyTextStyle
        self.leftCounterText = leftCounterText
        self.leftCounterTextStyle = leftCounterTextStyle
        self.rightCounterText = rightCounterText
        self.rightCounterTextStyle = rightCounterTextStyle
        self.cornerRadius = cornerRadius
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public let id: UUID
    public let titleText: String
    let titleTextStyle: TextStyle
    let subTitleText: String
    let subTitleTextStyle: TextStyle
    let leftBodyText: String
    let leftBodyTextStyle: TextStyle
    let rightBodyText: String
    let rightBodyTextStyle: TextStyle
    public let leftCounterText: String
    let leftCounterTextStyle: TextStyle
    let rightCounterText: String
    let rightCounterTextStyle: TextStyle
    let cornerRadius: CGFloat
    public let latitude: Double
    public let longitude: Double
}


@available(iOS 13.0, macOS 10.15, *)
public struct BikeStationInfoCardView: View {
    
    @ObservedObject var model: BikeStationInfoCardModel
    public init(with model: BikeStationInfoCardModel) {
        self.model = model
    }
    
    var headerView: some View {
        let headerModel: TitleSubTitleLabelVStackModel = .init(
            titleText: model.titleText,
            titleTextStyle: model.titleTextStyle,
            subTitleText: model.subTitleText,
            subTitleTextStyle: model.subTitleTextStyle
        )
        return TitleSubTitleLabelVStackView(with: headerModel)
    }
    
    var leftBodyView: some View {
        let leftBodyViewModel: IconWithBodyAndFooterLabelVStackModel = .init(
            iconName: "Bike",
            bodyText: model.leftBodyText,
            bodyTextStyle: model.leftBodyTextStyle,
            footerText: model.leftCounterText,
            footerTextStyle: model.leftCounterTextStyle
        )
        return IconWithBodyAndFooterLabelVStackView(with: leftBodyViewModel)
    }
    
    var rightBodyView: some View {
        let rightBodyViewModel: IconWithBodyAndFooterLabelVStackModel = .init(
            iconName: "Lock",
            bodyText: model.rightBodyText,
            bodyTextStyle: model.rightBodyTextStyle,
            footerText: model.rightCounterText,
            footerTextStyle: model.rightCounterTextStyle
        )
        return IconWithBodyAndFooterLabelVStackView(with: rightBodyViewModel)
    }
    
    public var body: some View {
        
        VStack(alignment: .leading, spacing: 30) {
            HStack {
                headerView
                Spacer()
            }
        
            HStack(spacing: 70) {
                leftBodyView
                rightBodyView
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: model.cornerRadius))
        .shadow(color: .white, radius: 2, x: 0, y: 0)
        .padding(.horizontal, 20)
    }
}


@available(iOS 13.0, macOS 10.15, *)
struct BikeStationInfoCardView_Previews: PreviewProvider {
    
    static var previews: some View {
        let model: BikeStationInfoCardModel = .init(
            titleText: "047 Ofiar Dabia",
            titleTextStyle: .init(font: .system(size: 25).weight(.bold), color: .black),
            subTitleText: "600m - Bike Station",
            subTitleTextStyle: .init(font: .footnote, color: .black),
            leftBodyText: "Available bikes",
            leftBodyTextStyle: .init(font: .footnote, color: .black),
            rightBodyText: "Available places",
            rightBodyTextStyle: .init(font: .footnote, color: .black),
            leftCounterText: "7",
            leftCounterTextStyle: .init(font: .system(size: 60).weight(.bold), color: .green),
            rightCounterText: "21",
            rightCounterTextStyle: .init(font: .system(size: 60).weight(.bold), color: .black),
            cornerRadius: 8
        )
        
        return BikeStationInfoCardView(with: model)
    }
}
