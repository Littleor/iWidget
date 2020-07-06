//
//  RSSData.swift
//  iWidget
//
//  Created by Littleor on 2020/7/5.
//

import Foundation
import FeedKit

//extension String {
//    func string2Date(_ string:String, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Date {
//        let formatter = DateFormatter()
//        formatter.locale = Locale.init(identifier: "zh_CN")
//        formatter.dateFormat = dateFormat
//        let date = formatter.date(from: string)
//        return date!
//    }
//}

/**
 RSSItem: 保存每个Item的关键信息
 */
struct RSSItem {
    var title: String
    var link: String
    var description: String
    var pubDate: Date?
}
/**
 RSSChannel : 保存RSS订阅信息
 */
struct RSSChannel {
    var title:String
    var link:String
    var description:String
}
/**
 保存一个RSS的信息
 */
struct RSS {
    var url: String?
    var channel: RSSChannel?
    var items: [RSSItem]?
}

struct RSSLoader {
    static func fetch(url:String,completion: @escaping (Result<RSS, Error>) -> Void) {
        var rss = RSS(url: url)
        let feedURL = URL(string: url)!
        let parser = FeedParser(URL: feedURL)
        let result = parser.parse()
        switch result {
        case .success(let feed):
            // Grab the parsed feed directly as an optional rss, atom or json feed object
//            feed.rssFeed
            // Or alternatively...
            switch feed {
            case let .rss(feed):
                // Really Simple Syndication Feed Model
                let channel = RSSChannel(title: feed.title ?? "title", link: feed.link ?? "link", description: feed.description ?? "desc")
                var items:[RSSItem]? = []
                for feedItem in feed.items ?? [] {
                    let item = RSSItem(title: feedItem.title ?? "title", link: feedItem.link ?? "link", description: feedItem.description ?? "desc", pubDate: feedItem.pubDate)
                    items?.append(item)
                }
                rss.items = items
                rss.channel = channel
                completion(.success(rss))
                break
            default:
                completion(.success(rss))
            }
        case .failure(let error):
            completion(.failure(error))
        }
        
    }
}
