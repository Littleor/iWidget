//
//  PayToolsView.swift
//  iWidget
//
//  Created by Littleor on 2020/6/27.
//

import SwiftUI

struct PayToolsSmallView: View {
    
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

struct PayToolsMediumView: View {
    var body: some View {
        HStack(spacing: 3.0) {
            IconWidgetItem(icon:"qrcode",bottomIcon: "alipay",size: 70)
            IconWidgetItem(icon: "pay",bottomIcon: "alipay",size: 70,url: "alipay://platformapi/startapp?appId=20000056")
                .padding([.top, .leading, .bottom])
            IconWidgetItem(icon: "qrcode",bottomIcon: "wechat",size: 70, url: "weixin://scanqrcode")
                .padding(.all)
            IconWidgetItem(icon: "pay",bottomIcon: "wechat",size: 70, url: "weixin://")
        }
    }
}



struct IconWidgetItem:View {
    var icon:String = "qrcode"
    var bottomIcon:String = "alipay"
    var size: CGFloat = 60
    var url: String  = "alipayqr://platformapi/startapp?saId=10000007"
    var body: some View {
        Link(destination: URL(string: url)!) {
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


