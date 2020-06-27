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



struct SimpleEntry: TimelineEntry {
    public let date: Date
}

struct PlaceholderView : View {
    //这里是PlaceholderView - 提醒用户选择部件功能
    var body: some View {
        Text("请长按我配置部件功能")
    }
}

struct mediumWidget : View {
    //这里写中型部件
    var entry: Provider.Entry
    var body: some View {
        HStack(spacing: 3.0) {
                IconWidgetItem(icon:"qrcode",bottomIcon: "alipay",size: 70)
                IconWidgetItem(icon: "pay",bottomIcon: "alipay",size: 70,url: "alipay://platformapi/startapp?appId=20000056")
            IconWidgetItem(icon: "qrcode",bottomIcon: "wechat",size: 70, url: "weixin://scanqrcode")
            IconWidgetItem(icon: "pay",bottomIcon: "wechat",size: 70, url: "weixin://")
        }
    }
}

struct smallWidget : View {
    //这里写小型部件
    var entry: Provider.Entry
    var body: some View {
        VStack {
            HStack {
                IconWidgetItem(icon:"qrcode",bottomIcon: "alipay")
                IconWidgetItem(icon: "pay",bottomIcon: "alipay",url: "alipay://platformapi/startapp?appId=20000056")
            }
            .padding([.top, .leading, .trailing])
            HStack{
                IconWidgetItem(icon: "qrcode",bottomIcon: "wechat",url: "weixin://scanqrcode")
                IconWidgetItem(icon: "pay",bottomIcon: "wechat",url: "weixin://")
            }
            .padding(/*@START_MENU_TOKEN@*/[.leading, .bottom, .trailing]/*@END_MENU_TOKEN@*/)
        }
    }
}
struct largeWidget : View {
    //这里写大型部件
    var entry: Provider.Entry
    var body: some View {
        IconWidgetItem()
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

struct IconWidgetItem:View {
    var icon:String = "qrcode"
    var bottomIcon:String = "alipay"
    var size: CGFloat = 60
    var url: String  = "alipayqr://platformapi/startapp?saId=10000007"
    var body: some View {
        Link(destination: URL(string: "https://baidu.com")!) {
            ZStack {
                ZStack {
                    Image(icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: size, height: size, alignment: .center)
                .zIndex(1)
                HStack() {
                    Spacer()
                    VStack {
                        Spacer()
                        HStack {
                            Image(bottomIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .opacity(1)
                            
                        }
                        .frame(width: size/3, height: size/3, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(size/6)
                        .shadow(radius: 1)
                    }
                    
                }
                .zIndex(2)
                
            }.frame(width: size, height: size, alignment: .center)
        }
    }
}


struct MainWidget_Previews: PreviewProvider {
    static var previews: some View {
        MainWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
