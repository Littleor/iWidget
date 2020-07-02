//
//  MainWidget.swift
//  MainWidget
//
//  Created by Littleor on 2020/6/25.
//

import WidgetKit
import SwiftUI
import Intents




struct SimpleEntry: TimelineEntry {
    public let date: Date
}

struct PlaceholderView : View {
    //这里是PlaceholderView - 提醒用户选择部件功能
    var body: some View {
        Text("Place Holder")
    }
}


@main
struct Widgets: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        OneWordWidget()
        PayToolsWidget()
        CountDownWidget()
    }
}


//struct MainWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        CountDownEntryView(entry:CountDownEntry(date: Date(),data: CountDown(day: 1, date: Date(), title: "成年")))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
