//
//  MainWidget.swift
//  MainWidget
//
//  Created by Littleor on 2020/6/25.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    public func snapshot(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

enum WidgetKind {
    case placeHolder
    case payTools
    case oneWord
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let kind: WidgetKind = WidgetKind.placeHolder
    public let configuration: ConfigurationIntent
}

struct PlaceholderView : View {
    //这里是PlaceholderView - 提醒用户选择部件功能
    var body: some View {
        Text("请长按我配置部件功能")
    }
}

struct smallWidget : View {
    //这里写小型部件
    var entry: Provider.Entry
    var body: some View {
        Text("I'm small widget")
    }
}
struct mediumWidget : View {
    //这里写中型部件
    var entry: Provider.Entry
    var body: some View {
        Text("I'm medium widget")
    }
}
struct largeWidget : View {
    //这里写大型部件
    var entry: Provider.Entry
    var body: some View {
        Text("I'm large widget")
    }
}
struct DataNotAvailable : View {
    //这里写Error的时候的部件
    var body: some View {
        Text("Data is not available,Please Refresh it.")
    }
}

struct MainWidgetEntryView : View {
    //这里是Widget的类型判断
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry
    @ViewBuilder
       var body: some View {
           switch family {
           case .systemSmall: smallWidget(entry:entry)
           case .systemMedium: mediumWidget(entry:entry)
           case .systemLarge: largeWidget(entry:entry)
           default: DataNotAvailable()
           }
       }
}

@main
struct MainWidget: Widget {
    private let kind: String = "MainWidget"
    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider(), placeholder: PlaceholderView()) { entry in
            MainWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("iWidget")
        .description("一款Widget百宝箱!")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
