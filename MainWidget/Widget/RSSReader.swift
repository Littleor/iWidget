//
//  RSSReader.swift
//  MainWidgetExtension
//
//  Created by Littleor on 2020/7/6.
//

import WidgetKit
import SwiftUI
import Intents

struct RSSReaderProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> RSSReaderEntry {
        return RSSReaderEntry(date: Date(),data: RSS())
    }
    func getSnapshot(for configuration: RSSReaderIntent, in context: Context, completion: @escaping (Entry) -> Void) {
        let entry = RSSReaderEntry(date: Date(),data: RSS())
        completion(entry)
    }
    func getTimeline(for configuration: RSSReaderIntent, in context: Context, completion: @escaping (Timeline<RSSReaderEntry>) -> Void) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 60, to: currentDate)!
        let url = configuration.url ?? "https://sixming.com/index.php/feed/"
        let errorItem = RSSItem(title: "更新失败请检查RSS源或网络", link: "https://sixming.com/", description: "更新失败", pubDate: Date())
        let errorRSS = RSS(url: url, channel: RSSChannel(title: "iWidget", link: "https://github.com/Littleor/iWidget/", description: "iOS14首款小部件集合软件-iWidget"), items: [errorItem,errorItem,errorItem])
        //逃逸闭包传入匿名函数 当调用completion时调用该匿名函数刷新Widget
        RSSLoader.fetch(url: url) { result in
            let rss: RSS
            if case .success(let rssData) = result {
                rss = rssData
            } else {
                rss = errorRSS
            }
            let entry = RSSReaderEntry(date: currentDate,data: rss)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
        }
    }
}

struct RSSReaderEntry: TimelineEntry {
    public let date: Date
    public let data: RSS
}

struct RSSReaderPlaceholderView : View {
    //这里是PlaceholderView - 提醒用户选择部件功能
    var body: some View {
        RSSReaderView(title: "iWidget", itemTitle: "iOS14首款小部件集合软件发布-iWidget", itemDesc: "iOS14首款小部件集合软件发布-iWidget", itemPubDate: "1分钟前",url:"https://sixming.com")
    }
}

struct RSSReaderEntryView : View {
    //这里是Widget的类型判断
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: RSSReaderProvider.Entry
    
    @ViewBuilder
    var body: some View {
        switch(family){
        case .systemMedium:
            RSSReaderView(title: entry.data.channel?.title ?? "iWidget", itemTitle: entry.data.items?.first?.title ?? "iOS14首款小部件集合软件发布-iWidget", itemDesc: entry.data.items?.first?.description ?? "iOS14首款小部件集合软件发布-iWidget", itemPubDate: (entry.data.items?.first?.pubDate ?? Date()).getRelateiveDate(unitsStyle: .short),url: entry.data.items?.first?.link ?? "https://sixming.com")
        case .systemLarge:
            VStack(){
                RSSReaderView(title: entry.data.channel?.title ?? "iWidget", itemTitle: entry.data.items?[0].title ?? "iOS14首款小部件集合软件发布-iWidget", itemDesc: entry.data.items?[0].description ?? "iOS14首款小部件集合软件发布-iWidget", itemPubDate: (entry.data.items?[0].pubDate ?? Date()).getRelateiveDate(unitsStyle: .short),url: entry.data.items?[0].link ?? "https://sixming.com")
                if((entry.data.items ?? []).count > 1){
                    RSSReaderView(title: entry.data.channel?.title ?? "iWidget", itemTitle: entry.data.items?[1].title ?? "iOS14首款小部件集合软件发布-iWidget", itemDesc: entry.data.items?[1].description ?? "iOS14首款小部件集合软件发布-iWidget", itemPubDate: (entry.data.items?[1].pubDate ?? Date()).getRelateiveDate(unitsStyle: .short),url: entry.data.items?[1].link ?? "https://sixming.com")
                }
                if((entry.data.items ?? []).count > 2){
                    RSSReaderView(title: entry.data.channel?.title ?? "iWidget", itemTitle: entry.data.items?[2].title ?? "iOS14首款小部件集合软件发布-iWidget", itemDesc: entry.data.items?[2].description ?? "iOS14首款小部件集合软件发布-iWidget", itemPubDate: (entry.data.items?[2].pubDate ?? Date()).getRelateiveDate(unitsStyle: .short),url: entry.data.items?[2].link ?? "https://sixming.com")
                }
            }
        default:
            RSSReaderView(title: entry.data.channel?.title ?? "iWidget", itemTitle: entry.data.items?.first?.title ?? "iOS14首款小部件集合软件发布-iWidget", itemDesc: entry.data.items?.first?.description ?? "iOS14首款小部件集合软件发布-iWidget", itemPubDate: (entry.data.items?.first?.pubDate ?? Date()).getRelateiveDate(unitsStyle: .short),url: entry.data.items?.first?.link ?? "https://sixming.com")
        }
    }
}

struct RSSReaderWidget: Widget {
    private let kind: String = "RSSReaderWidget"
    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: RSSReaderIntent.self, provider: RSSReaderProvider()){entry in
            RSSReaderEntryView(entry: entry)
        }
        .configurationDisplayName("RSS订阅")
        .description("快捷获取你关心的最新信息")
        .supportedFamilies([.systemMedium,.systemLarge])
        
    }
}

