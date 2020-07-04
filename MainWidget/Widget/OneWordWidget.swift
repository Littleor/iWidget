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
    public func snapshot(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (OneWordEntry) -> ()) {
        let entry = OneWordEntry(date: Date(),data: OneWord(content: "人类的悲欢并不相通，我只觉得他们吵闹", length: 18))
        completion(entry)
    }
    
    public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 60, to: currentDate)!
          
        OneWordLoader.fetch { result in
            let oneWord: OneWord
            if case .success(let fetchedData) = result {
                oneWord = fetchedData
            } else {
                oneWord = OneWord(content: "人类的悲欢并不相通，我只觉得他们吵闹。", length: 19)
            }
            let entry = OneWordEntry(date: currentDate,data: oneWord)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
        }
    }
}

struct OneWordEntry: TimelineEntry {
    public let date: Date
    public let data: OneWord
}

struct OneWordPlaceholderView : View {
    //这里是PlaceholderView - 提醒用户选择部件功能
    var body: some View {
        Text("人类的悲欢并不相通，我只觉得他们吵闹.")
    }
}

struct OneWordEntryView : View {
    //这里是Widget的类型判断
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: OneWordProvider.Entry
    
    @ViewBuilder
    var body: some View {
        OneWordView(content: entry.data.content)
    }
}

struct OneWordWidget: Widget {
    private let kind: String = "OneWordWidget"
    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: OneWordProvider(), placeholder: OneWordPlaceholderView()) { entry in
            OneWordEntryView(entry: entry)
        }
        .configurationDisplayName("一言")
        .description("每小时刷新一言")
        .supportedFamilies([.systemSmall, .systemMedium])
        
    }
}
