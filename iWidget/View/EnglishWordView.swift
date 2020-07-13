//
//  EnglishWordView.swift
//  iWidget
//
//  Created by Littleor on 2020/7/13.
//

import SwiftUI

struct EnglishWordView: View {
    let word: EnglishWord
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            HStack(alignment: .lastTextBaseline) {
                Text(word.word)
                    .font(.title)
                    .bold()
                Text("UK " + "[" + word.ukpronunciation + "]")
                    .font(.footnote)
                Text("UK " + "[" +  word.uspronunciation + "]")
                    .font(.footnote)
                Spacer()
            }
            Spacer()
            VStack(alignment: .leading) {
                ForEach(word.tran,id: \.self){(tran) in
                    Text(tran)
                        .font(.body)
                        .lineLimit(1)
                }
            }
            Spacer()
            VStack(alignment: .leading) {
                Text(word.en_example)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                Text(word.ch_example)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            Spacer()
        }
        .padding(.all)
        .frame(minWidth: 0,maxWidth: .infinity, minHeight: 0,maxHeight: .infinity, alignment: .center)
    }
}

