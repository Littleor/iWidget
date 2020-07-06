//
//  IdiomView.swift
//  iWidget
//
//  Created by Littleor on 2020/7/6.
//

import SwiftUI
struct IdiomView: View {
    let idiom: Idiom
    var pinyins: [String]
    var words: [String]
    init(idiom:Idiom){
        self.idiom = idiom
        self.pinyins = self.idiom.pinyin.components(separatedBy:" ")
        self.words = self.idiom.word.map({ String($0) })
    }
    var body: some View {
        
        //        VStack(alignment: .center, spacing: 6.0) {
        //            HStack{
        //                ForEach(Range(uncheckedBounds: (0,pinyins.count))){ i in
        //                    VStack {
        //                        Text(pinyins[i])
        //                            .font(.title2)
        //                            .bold()
        //                        Text(words[i])
        //                            .font(.title2)
        //                            .bold()
        //                    }.frame(minWidth: 56 )
        //                }
        //            }
        //            Text(idiom.explanation)
        //                .font(.body)
        //                .lineLimit(3)
        //            Text(idiom.derivation)
        //                .font(.footnote)
        //                .foregroundColor(.gray)
        //                .lineLimit(2)
        //        }.padding(.all)
        //    }
        
        VStack(alignment: .leading, spacing: 10.0) {
            HStack(alignment: .bottom){
                Text("“\(idiom.word)”")
                    .font(.title)
                    .fontWeight(.light)
                Text(idiom.pinyin)
                    .font(.footnote)
                    .fontWeight(.light)
            }
            Text(idiom.explanation)
                .font(.title3)
                .fontWeight(.bold)
                .lineLimit(3)
            Text(idiom.derivation)
                .font(.footnote)
                .foregroundColor(.gray)
                .lineLimit(2)
        }.padding(.all)
    }
}

struct IdiomView_Previews: PreviewProvider {
    static var previews: some View {
        IdiomView(idiom: Idiom(word: "诚惶诚恐", pinyin: "chéng huáng chéng kǒng", explanation: "诚实在，的确；惶害怕；恐畏惧。非常小心谨慎以至达到害怕不安的程度。", derivation: "汉·杜诗《乞退郡疏》奉职无效，久窃禄位，令功臣怀愠，诚惶诚恐。", example: "一些成了惊弓之鸟的部员们算也～地先后把那段危险的地面通过了。★郭沫若《北伐途中》二十一"))
    }
}
