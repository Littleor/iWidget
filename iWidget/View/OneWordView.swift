//
//  OneWordView.swift
//  iWidget
//
//  Created by Littleor on 2020/6/27.
//

import SwiftUI

struct OneWordView: View {
    var content:String = "每日一言"
    var body: some View {
        Text(content)
    }
}

struct OneWordView_Previews: PreviewProvider {
    static var previews: some View {
        OneWordView(content: "PlaceHolder")
    }
}
