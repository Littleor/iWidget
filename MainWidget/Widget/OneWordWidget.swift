//
//  OneWordWidget.swift
//  iWidget
//
//  Created by Littleor on 2020/6/27.
//

import WidgetKit
import SwiftUI
import Intents

struct OneWordProvider: IntentTimelineProvider {
    public func snapshot(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)!
        let entry = SimpleEntry(date: currentDate)
        let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
        completion(timeline)
    }
}

struct OneWordEntryView : View {
    //这里是Widget的类型判断
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: OneWordProvider.Entry
    
    @ViewBuilder
    var body: some View {
        OneWordView(content: "一言")
    }
}

struct OneWordWidget: Widget {
    private let kind: String = "OneWordWidget"
    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: OneWordProvider(), placeholder: PlaceholderView()) { entry in
            OneWordEntryView(entry: entry)
        }
        .configurationDisplayName("iWidget")
        .description("一款Widget百宝箱!")
        .supportedFamilies([.systemSmall, .systemMedium])
        
    }
}
