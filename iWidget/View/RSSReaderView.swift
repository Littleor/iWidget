//
//  RSSReaderView.swift
//  iWidget
//
//  Created by Littleor on 2020/7/6.
//

import SwiftUI

struct RSSReaderView: View {
    let title:String
    let itemTitle: String
    let itemDesc: String
    let itemPubDate: String
    let url: String
    var body: some View {
        Link(destination: URL(string: url)!)
            {
            VStack(alignment: .leading, spacing: 10.0){
                Text(itemTitle)
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(2)
                HStack(alignment: .bottom) {
                    Text(title)
                        .font(.body)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                    Spacer()
                    Text(itemPubDate)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
            }.padding(.all)
        }
    }
    
}
    
    struct RSSReaderView_Previews: PreviewProvider {
        static var previews: some View {
            RSSReaderView(title: "Title", itemTitle: "title", itemDesc: "This is a description.", itemPubDate: "1 day ago", url: "")
        }
    }
