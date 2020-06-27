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
        let entry = SimpleEntry(date: Date(), data: WidgetData(kind: .payTools))
        completion(entry)
    }
    
    public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)!
        let entry = SimpleEntry(date: currentDate, data: WidgetData(kind: configuration.kind))
        let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
        completion(timeline)
    }
}

struct WidgetData {
    public let kind:WidgetKind
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let data: WidgetData
}

struct PlaceholderView : View {
    //这里是PlaceholderView - 提醒用户选择部件功能
    var body: some View {
        Text("请长按我配置部件功能")
    }
}

struct MainWidgetEntryView : View {
    //这里是Widget的类型判断
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry
    
    @ViewBuilder
    var body: some View {
        switch entry.data.kind {
        case .payTools:
            switch family {
                case .systemSmall: PayToolsSmallView()
                case .systemMedium: PayToolsMediumView()
                default: PayToolsMediumView()
            }
        case .oneWord:
            OneWordView()
        default:
            OneWordView()
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
        .supportedFamilies([.systemSmall, .systemMedium])
        
    }
}



struct MainWidget_Previews: PreviewProvider {
    static var previews: some View {
        MainWidgetEntryView(entry: SimpleEntry(date: Date(), data: WidgetData(kind: .payTools)))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
