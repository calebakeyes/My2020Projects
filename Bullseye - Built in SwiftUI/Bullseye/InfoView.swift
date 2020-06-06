//
//  InfoView.swift
//  Bullseye
//
//  Created by Caleb Keyes on 6/5/20.
//  Copyright © 2020 Caleb Keyes. All rights reserved.
//

import SwiftUI

struct TextStyle: ViewModifier {
    func body (content: Content) -> some View {
    return content
        .foregroundColor(Color.white)
        .font(Font.custom("Arial Rounded MT Bold", size: 18))
        .shadow(color: .black, radius: 5, x: 2, y: 2)
    }
}
var backgroundColor: Color = Color(red: 220 / 255, green: 140 / 255, blue: 70 / 255)

struct InfoView: View {
    
    var body: some View {
        VStack {
            Text ("🎯Bullseye🎯").modifier(TextStyle())
                .padding(.bottom, 20)
            Text ("""
            Howdy, partner! \nWelcome to Bullseye, a game where you score points by correctly placing a slider.\nYour goal is simple (though it may not be as easy as it seems): place the slider as close as you can to the target value. The closer you are the more points you get. Good luck!
            """).modifier(TextStyle()).multilineTextAlignment(.center)
            .padding(.bottom, 20)
            .background(backgroundColor)
        }
    .navigationBarTitle ("About Bullseye")
    .background(backgroundColor)
    .background (Image("Background"), alignment: .center)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView().previewLayout(.fixed(width: 896, height: 414))
    }
}
