//
//  ContentView.swift
//  SlotGame
//
//  Created by Steven Wijaya on 06.11.2021.
//

import SwiftUI

struct ContentView: View {
    @State var slot1 = "apple"
    @State var slot2 = "apple"
    @State var slot3 = "apple"
    @State var credits = 100
    @State private var showPopUp = false
    let pic = ["apple", "cherry", "star"]
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.teal, Color.white ]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea().shadow(radius: 1000)
            VStack{
                Text("SwiftUI Slots")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                Spacer()
                HStack{
                    Text("Credits:")
                        .font(.title2)
                        .fontWeight(.regular)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                    Text(String(credits))
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                HStack{
                    Spacer()
                    Image(slot1).resizable().aspectRatio(contentMode: .fit).frame(width: 120.0, height: 120.0)
                    Image(slot2)
                        .resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 120.0, height: 120.0)
                    Image(slot3)
                        .resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 120.0, height: 120.0)
                    Spacer()
                }
                Spacer()
                Button(action: {
                    //Change credits
                    if credits >= 100{
                        credits -= 100
                        //Change slot pic
                        let slot1Rand = pic.randomElement()!
                        let slot2Rand = pic.randomElement()!
                        let slot3Rand = pic.randomElement()!
                        slot1 = slot1Rand
                        slot2 = slot2Rand
                        slot3 = slot3Rand
                        if (slot1 == slot2) && (slot2 == slot3) && (slot1 == slot3) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                credits += 200
                            }
                        }
                    }
                    else{
                        showPopUp = true
                    }
                })
                {
                    Text("Spin")
                        .font(.title2)
                        .foregroundColor(Color.white)
                        .padding()
                        .frame(width: 110, height: 40)
                        .background(Color.indigo)
                        .cornerRadius(120)
                        .padding(3)
                        .overlay(RoundedRectangle(cornerRadius: 100, style: .continuous).stroke(Color.purple, lineWidth: 2))
                }
                Spacer()
            }
                       PopUpView(isShowing: $showPopUp)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
