//
//  PayTools.swift
//  MainWidgetExtension
//
//  Created by Littleor on 2020/6/27.
//

import WidgetKit
import SwiftUI
import Intents

struct PayToolsProvider: IntentTimelineProvider {
    typealias Entry = SimpleEntry
    public func snapshot(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let entry = SimpleEntry(date: currentDate)
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

struct PayToolsEntryView : View {
    //这里是Widget的类型判断
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: PayToolsProvider.Entry
    
    @ViewBuilder
    var body: some View {
        PayToolsMediumView()
    }
}

struct PayToolsWidget: Widget {
    private let kind: String = "PayToolsWidget"
    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: PayToolsProvider(), placeholder: PayToolsMediumView()) { entry in
            PayToolsEntryView(entry: entry)
        }
        .configurationDisplayName("支付助手")
        .description("快捷启动扫一扫和支付码")
        .supportedFamilies([.systemMedium])
        
    }
}
