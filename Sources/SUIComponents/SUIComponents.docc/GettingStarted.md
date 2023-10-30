# GettingStarted with SUIComponents

List of SwifttUI componets and how to use those componet.

## Overview

This documnet covers the various uicomponet and a code snippet of 'how to use' the uicomponent.

### BikeStationInfoCardView

``` swift
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
```
![An image that show's the layout of view.](BikeStationInfoCardView.png)
