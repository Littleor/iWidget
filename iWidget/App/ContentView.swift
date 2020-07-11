//
//  ContentView.swift
//  iWidget
//
//  Created by Littleor on 2020/6/25.
//

import SwiftUI

struct ContentView: View {
    @State var showWidget = false
    @GestureState private var dragOffset: CGFloat = 0
    @State private var position = CGSize.zero
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("iWidget")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.all)
                }
                .blur(radius: showWidget ? 20 : 0)
                Spacer()
                
                ZStack(alignment: Alignment(horizontal: .center, vertical: .center)){
                    WidgetCardView(kind: "RSSReader")
                        .offset(x: 0, y: showWidget ? (-450.0 + dragOffset + position.height)  : -60.0)
                        .scaleEffect(0.85)
//                        .rotationEffect(Angle(degrees: showWidget ? 4 : 0))
                        .animation(.easeIn)
                    
                    WidgetCardView(kind: "Idiom")
                        .offset(x: 0, y: showWidget ? (-300.0 + dragOffset + position.height)  : -40.0)
                        .scaleEffect(0.90)
//                        .rotationEffect(Angle(degrees: showWidget ? 3 : 0))
                        .animation(.easeIn)
                    
                    WidgetCardView(kind: "oneWord")
                        .offset(x: 0, y: showWidget ? (-150.0 + dragOffset + position.height) : -20.0)
                        .scaleEffect(0.95)
//                        .rotationEffect(Angle(degrees: showWidget ? 2 : 0))
                        .animation(.easeIn)
                    
                    WidgetCardView()
                        .offset(x: 0, y: showWidget ? (0 + dragOffset + position.height) : 0)
//                        .rotationEffect(Angle(degrees: showWidget ? 1 : 0))
                        .animation(.spring())
                        .onTapGesture {
                            self.showWidget.toggle()
                            self.position = CGSize.zero
                        }
                }
                
                Spacer()
                
                VStack{
                    Text("一款简单开源的小部件工具箱")
                        .font(.footnote)
                        .onTapGesture {
                            UIApplication.shared.open(URL(string: "https://github.com/Littleor/iWidget")!)
                        }
                    HStack{
                        Text("Coded By")
                            .padding(.all, 0)
                            .font(.footnote)
                        Text("Littleor")
                            .padding(.all, 0)
                            .font(.footnote)
                            .foregroundColor(.blue)
                            .onTapGesture {
                                UIApplication.shared.open(URL(string: "https://github.com/Littleor")!)
                            }
                    }
                }.blur(radius: showWidget ? 20 : 0)
                
            }
        }
        
        .gesture(
            DragGesture()
                .updating($dragOffset) { (value, gestureState, transaction) in
                    let delta = value.location.y - value.startLocation.y
                    gestureState = delta
                }
                .onEnded {
                    self.position.height = $0.translation.height
                }
        )
        .onOpenURL(perform: { (url) in
            UIApplication.shared.open(url)
        })
        
    }
}


struct WidgetCardView: View {
    var kind = "payTools"
    var body: some View {
        ZStack {
            HStack{
                Spacer()
                switch kind {
                case "payTools":PayToolsMediumView()
                case "oneWord":OneWordView(content: "一言部件,放置后每小时自动刷新")
                case "Idiom": IdiomView(idiom: Idiom(word: "诚惶诚恐", pinyin: "chéng huáng chéng kǒng", explanation: "诚实在，的确；惶害怕；恐畏惧。非常小心谨慎以至达到害怕不安的程度。", derivation: "汉·杜诗《乞退郡疏》奉职无效，久窃禄位，令功臣怀愠，诚惶诚恐。", example: "一些成了惊弓之鸟的部员们算也～地先后把那段危险的地面通过了。★郭沫若《北伐途中》二十一"))
                case "RSSReader":
                    RSSReaderView(title: "iWidget", itemTitle: "iOS14首款小部件集合软件-iWidget", itemDesc: "iOS14首款小部件集合软件-iWidget", itemPubDate: "刚刚", url: "https://github.com/Littleor/iWidget/")
                default:PayToolsMediumView()
                }
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.all)
            .frame(height: 200, alignment: .center)
            .background(Color.gray)
            .cornerRadius(20)
            .shadow(radius: 12)
        }
        .padding(.all)
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
