//
//  ContentView.swift
//  Bullseye
//
//  Created by Caleb Keyes on 6/3/20.
//  Copyright © 2020 Caleb Keyes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    @State var slidervalue: Double = 50.0
    @State var target: Int = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    
    struct Shadow: ViewModifier {
        func body (content: Content) -> some View {
        return content
            .shadow(color: .black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct LabelStyle: ViewModifier {
        func body (content: Content) -> some View {
        return content
            .modifier(Shadow())
            .foregroundColor(Color.white)
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonTextLargeStyle: ViewModifier {
        func body (content: Content) -> some View {
        return content
            .foregroundColor(Color.black)
            .font(Font.custom("Arial Rounded MT Bold", size: 14))
        }
    }
    struct ButtonTextSmallStyle: ViewModifier {
        func body (content: Content) -> some View {
        return content
            .foregroundColor(Color.black)
            .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body (content: Content) -> some View {
        return content
            .modifier(Shadow())
            .foregroundColor(Color.yellow)
            .font(Font.custom("Arial Rounded MT Bold", size: 23))
        }
    }
    
    func sliderValueRounded() -> Int{
        return Int(slidervalue.rounded())
    }
    
    func pointsForCurrentRound () -> Int {
        let points: Int = 100 - abs(target - sliderValueRounded())
        if points == 100 {
            return 200
        }
        else if points >= 97 {
            return points + 50
        }
        else {
            return points
        }
    }
    
    func popUpMessage () -> String {
        if pointsForCurrentRound () == 200 {
            return "🎊Perfect!🎊"}
        else if pointsForCurrentRound () >= 101 {
            return "You're pretty good at this!"}
        else if pointsForCurrentRound () >= 80 {
            return "Nice try!"}
        else {
            return "Oof that wasn't great. Try again for a better score."}
        }
    
    func restart () {
        score = 0
        round = 1
        target = Int.random(in: 1...100)
        slidervalue = 50.0
    }

    var body: some View {
        VStack {
            Spacer()
//target row
            HStack {
                Text("Put the bullseye as close as you can to:").modifier(LabelStyle())
                Text("\(target)").modifier(ValueStyle())
            }
            Spacer()
//slider row
            HStack {
                Text ("1").modifier(LabelStyle())
                Spacer()
                Slider(value: $slidervalue, in: 1...100)
                    .accentColor(.yellow)
                Spacer()
                Text ("100").modifier(LabelStyle())
            }
            Spacer()
//button row
            Button(action: {
                self.alertIsVisible = true
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit Me!"/*@END_MENU_TOKEN@*/).modifier(ButtonTextLargeStyle())
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                return Alert (title: Text("\(popUpMessage ())"), message: Text("The bullseye's value is \(sliderValueRounded()).\n You scored \(pointsForCurrentRound ()) points this round."), dismissButton: .default(Text("Let's go again!")) {self.score += self.pointsForCurrentRound()
                    self.target = Int.random(in: 1...100)
                    self.round += 1
                    })
            }
            .background(Image("Button")).modifier(Shadow())
            Spacer()
//score row
            HStack {
                Button (action: {
                    self.restart ()
                }) {
                    HStack {
                        Image("StartOverIcon")
                            .accentColor(.black)
                    Text ("Start Over").modifier(ButtonTextSmallStyle())
                    }
                }
                .background(Image("Button")).modifier(Shadow())
                Spacer()
                Text ("Your Score:").modifier(LabelStyle())
                Text ("\(score)").modifier(ValueStyle())
                Spacer()
                Text ("Round:").modifier(LabelStyle())
                Text ("\(round)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: InfoView()) {
                    HStack {
                        Image("InfoIcon")
                        .accentColor(.black)
                        Text ("Info").modifier(ButtonTextSmallStyle())
                    }
                .background(Image("Button")).modifier(Shadow())
            }
            .padding(.bottom, 20)
    }
        .background (Image("Background"), alignment: .center)
        .navigationBarTitle ("Bullseye")
    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}

