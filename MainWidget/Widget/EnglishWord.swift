//
//  EnglishWord.swift
//  iWidget
//
//  Created by Littleor on 2020/7/13.
//

import WidgetKit
import SwiftUI
import Intents

struct EnglishWordProvider: IntentTimelineProvider {
    let englishWordExample = EnglishWord(word: "abandon", tran: ["v. 遗弃;离开;放弃;终止;陷入","n. 放任,狂热"], ch_example: "他声称他的父母抛弃了他。", en_example: "He claimed that his parents had abandoned him.", exam: ["TOEFL","高中","SAT","IELTS","CET6","GRE","CET4","商务英语","考研"], uspronunciation: "əˈbændən", ukpronunciation: "əˈbændən", type: "CET4")
    public func snapshot(for configuration: EnglishWordIntent, with context: Context, completion: @escaping (EnglishWordEntry) -> ()) {
        let entry = EnglishWordEntry(date: Date(),data: [englishWordExample,englishWordExample,englishWordExample])
        completion(entry)
    }
    
    public func timeline(for configuration: EnglishWordIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 60, to: currentDate)!
        //逃逸闭包传入匿名函数 当调用completion时调用该匿名函数刷新Widget
        EnglishWordLoader.fetch(type: configuration.type) { result in
            let EnglishWords: [EnglishWord]
            if case .success(let fetchedData) = result {
                EnglishWords = fetchedData
            } else {
                EnglishWords = [englishWordExample,englishWordExample,englishWordExample]
            }
            let entry = EnglishWordEntry(date: currentDate,data: EnglishWords)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
        }
    }
}

struct EnglishWordEntry: TimelineEntry {
    public let date: Date
    public let data: [EnglishWord]
}

struct EnglishWordPlaceholderView : View {
    //这里是PlaceholderView
    var body: some View {
        EnglishWordView(word: EnglishWord(word: "abandon", tran: ["v. 遗弃;离开;放弃;终止;陷入","n. 放任,狂热"], ch_example: "他声称他的父母抛弃了他。", en_example: "He claimed that his parents had abandoned him.", exam: ["TOEFL","高中","SAT","IELTS","CET6","GRE","CET4","商务英语","考研"], uspronunciation: "əˈbændən", ukpronunciation: "əˈbændən", type: "CET4"))
    }
}

struct EnglishWordEntryView : View {
    //这里是Widget的类型判断
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: EnglishWordProvider.Entry
    let index = Int((Int(Date().timeIntervalSince1970) % (3600 * 24)) / 1800) % 3
    @ViewBuilder
    var body: some View {
        EnglishWordView(word: entry.data[index])
    }
}

struct EnglishWordWidget: Widget {
    private let kind: String = "EnglishWordWidget"
    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: EnglishWordIntent.self, provider: EnglishWordProvider(), placeholder: EnglishWordPlaceholderView()) { entry in
            EnglishWordEntryView(entry: entry)
        }
        .configurationDisplayName("每日单词")
        .description("每天学习三个单词")
        .supportedFamilies([.systemMedium]) 
    }
}
//struct MainWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        EnglishWordEntryView(entry:EnglishWordEntry(date: Date(),data: [EnglishWord(word: "abandon", tran: ["v. 遗弃;离开;放弃;终止;陷入","n. 放任,狂热"], ch_example: "他声称他的父母抛弃了他。", en_example: "He claimed that his parents had abandoned him.", exam: ["TOEFL","高中","SAT","IELTS","CET6","GRE","CET4","商务英语","考研"], uspronunciation: "əˈbændən", ukpronunciation: "əˈbændən", type: "CET4"),EnglishWord(word: "abandon", tran: ["v. 遗弃;离开;放弃;终止;陷入","n. 放任,狂热"], ch_example: "他声称他的父母抛弃了他。", en_example: "He claimed that his parents had abandoned him.", exam: ["TOEFL","高中","SAT","IELTS","CET6","GRE","CET4","商务英语","考研"], uspronunciation: "əˈbændən", ukpronunciation: "əˈbændən", type: "CET4"),EnglishWord(word: "abandon", tran: ["v. 遗弃;离开;放弃;终止;陷入","n. 放任,狂热"], ch_example: "他声称他的父母抛弃了他。", en_example: "He claimed that his parents had abandoned him.", exam: ["TOEFL","高中","SAT","IELTS","CET6","GRE","CET4","商务英语","考研"], uspronunciation: "əˈbændən", ukpronunciation: "əˈbændən", type: "CET4")]))
//            .previewContext(WidgetPreviewContext(family: .systemMedium))
//    }
//}
