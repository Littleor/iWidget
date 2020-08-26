//
//  Idiom.swift
//  iWidget
//
//  Created by Littleor on 2020/7/6.
//

import WidgetKit
import SwiftUI
import Intents

struct IdiomProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> IdiomEntry {
        return IdiomEntry(date: Date(),data: Idiom( word: "诚惶诚恐", pinyin: "chéng huáng chéng kǒng", explanation: "诚实在，的确；惶害怕；恐畏惧。非常小心谨慎以至达到害怕不安的程度。", derivation: "汉·杜诗《乞退郡疏》奉职无效，久窃禄位，令功臣怀愠，诚惶诚恐。", example: "一些成了惊弓之鸟的部员们算也～地先后把那段危险的地面通过了。★郭沫若《北伐途中》二十一"))
    }
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (IdiomEntry) -> Void) {
        let entry = IdiomEntry(date: Date(),data: Idiom( word: "诚惶诚恐", pinyin: "chéng huáng chéng kǒng", explanation: "诚实在，的确；惶害怕；恐畏惧。非常小心谨慎以至达到害怕不安的程度。", derivation: "汉·杜诗《乞退郡疏》奉职无效，久窃禄位，令功臣怀愠，诚惶诚恐。", example: "一些成了惊弓之鸟的部员们算也～地先后把那段危险的地面通过了。★郭沫若《北伐途中》二十一"))
        completion(entry)
    }
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 60, to: currentDate)!
        //逃逸闭包传入匿名函数 当调用completion时调用该匿名函数刷新Widget
        IdiomLoader.fetch { result in
            let idiom: Idiom
            if case .success(let fetchedData) = result {
                idiom = fetchedData
            } else {
                idiom = Idiom( word: "更新失败", pinyin: "gèng xīn shī bài ", explanation: "更新，刷新数据；失败，不成功。刷新今日成语时失败。", derivation: "不详", example: "无")
            }
            let entry = IdiomEntry(date: currentDate,data: idiom)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
        }
    }
}

struct IdiomEntry: TimelineEntry {
    public let date: Date
    public let data: Idiom
}

struct IdiomPlaceholderView : View {
    //这里是PlaceholderView - 提醒用户选择部件功能
    var body: some View {
        IdiomView(idiom: Idiom( word: "诚惶诚恐", pinyin: "chéng huáng chéng kǒng", explanation: "诚实在，的确；惶害怕；恐畏惧。非常小心谨慎以至达到害怕不安的程度。", derivation: "汉·杜诗《乞退郡疏》奉职无效，久窃禄位，令功臣怀愠，诚惶诚恐。", example: "一些成了惊弓之鸟的部员们算也～地先后把那段危险的地面通过了。★郭沫若《北伐途中》二十一"))
    }
}

struct IdiomEntryView : View {
    //这里是Widget的类型判断
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: IdiomProvider.Entry
    
    @ViewBuilder
    var body: some View {
        IdiomView(idiom: entry.data)
    }
}

struct IdiomWidget: Widget {
    private let kind: String = "IdiomWidget"
    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: IdiomProvider()) { entry in
            IdiomEntryView(entry: entry)
        }
        .configurationDisplayName("每日成语")
        .description("每天学习一个成语")
        .supportedFamilies([.systemMedium])
        
    }
}
