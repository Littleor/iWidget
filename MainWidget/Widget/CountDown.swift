//
//  CountDown.swift
//  MainWidgetExtension
//
//  Created by Littleor on 2020/7/2.
//
import WidgetKit
import SwiftUI
import Intents

/**
 扩展Date
 daysBetweenDate: 计算两天差距天数
 */
extension Date {
    func daysBetweenDate(toDate: Date) -> Int {
        let now = Date()
        let nowTimeStamp = Int(now.timeIntervalSince1970)
        let toDateTimeStamp = Int(toDate.timeIntervalSince1970)
        let difference:Double = Double(abs(nowTimeStamp - toDateTimeStamp))
        if(nowTimeStamp < toDateTimeStamp){
            return Int(floor( difference / (86400))) + 1
        }
        else{
            return Int(floor( difference / (86400)))
        }
        
    }
    func dateToString(_ date:Date,dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
         formatter.locale = Locale.init(identifier: "zh_CN")
         formatter.dateFormat = dateFormat
         let date = formatter.string(from: date)
         return date
    }
    func getRelateiveDate(unitsStyle: RelativeDateTimeFormatter.UnitsStyle)->String{
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = unitsStyle
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

struct CountDownProvider: IntentTimelineProvider {
    //    typealias Entry = CountDownEntry
    public func snapshot(for configuration: CountDownIntent, with context: Context, completion: @escaping (CountDownEntry) -> ()) {
        let entry = CountDownEntry(date: Date(),data: CountDown(date: Date(),title: "爱上iWidget"))
        completion(entry)
    }
    
    public func timeline(for configuration: CountDownIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 30, to: currentDate)!
        //Widget输入的日期默认为中午12点
        let configureDate = (configuration.date?.date  ?? Date()) - 12 * 3600
        let entry = CountDownEntry(date: currentDate,data: CountDown(day: Date().daysBetweenDate(toDate: configureDate),date: configureDate,title: configuration.title ?? "请配置标题" ))
        print(configureDate)
        let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
        completion(timeline)
    }
}
struct CountDown {
    var day:Int = 0
    var date:Date
    var title:String
}

struct CountDownEntry: TimelineEntry {
    public let date: Date
    public let data: CountDown
}

struct CountDownEntryView : View {
    //这里是Widget的类型判断
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: CountDownProvider.Entry
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall: CountDownView(title: entry.data.title,day: entry.data.day)
        case .systemMedium: CountDownView(title: entry.data.title,day: entry.data.day)
        default: CountDownView(title: entry.data.title,day: entry.data.day)
        }
    }
    
}

struct CountDownPlaceholderView : View {
    //这里是PlaceholderView - 提醒用户选择部件功能
    var body: some View {
        CountDownView(title: "爱上iWidget",day: 0)
    }
}

struct CountDownWidget: Widget {
    private let kind: String = "CountDownWidget"
    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: CountDownIntent.self, provider: CountDownProvider()) { entry in
            CountDownEntryView(entry: entry)
        }
        .configurationDisplayName("倒计时")
        .description("重要事情随时提醒")
        .supportedFamilies([.systemSmall])
        
    }
}
