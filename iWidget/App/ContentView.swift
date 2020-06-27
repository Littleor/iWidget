//
//  ContentView.swift
//  iWidget
//
//  Created by Littleor on 2020/6/25.
//

import SwiftUI

struct ContentView: View {
    @State var showWidget = false
    @State var viewState = CGSize.zero
    var body: some View {
        //        NavigationView {
        
        VStack {
            HStack {
                Text("iWidget")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.all)
            }
            .blur(radius: showWidget ? 20 : 0)
            Spacer()
            ZStack{
                WidgetCardView(kind: "oneWord")
                    .offset(x: 0, y: showWidget ? -200.0 : -20.0)
                    .scaleEffect(0.95)
                    .rotationEffect(Angle(degrees: showWidget ? 10 : 0))
                    .animation(.easeIn)
                WidgetCardView()
                    .rotationEffect(Angle(degrees: showWidget ? 5 : 0))
                    .animation(.spring())
                    .onTapGesture {
                        self.showWidget.toggle()
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
        
        //        }
        //        .onOpenURL(perform: { (url) in
        //            UIApplication.shared.open(url)
        //        })
        
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
