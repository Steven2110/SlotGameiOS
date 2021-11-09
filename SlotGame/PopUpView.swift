//
//  PopUpView.swift
//  SlotGame
//
//  Created by Steven Wijaya on 06.11.2021.
//

import SwiftUI

struct PopUpView: View {
    @Binding var  isShowing: Bool
    @State private var isDragging = false
    
    @State private var curHeight: CGFloat = 400
    let minHeight: CGFloat = 400
    let maxHeight: CGFloat = 600
    
    let startOpacity: Double = 0.4
    let endOpacity: Double = 0.8
    
    var dragPercentage: Double {
        let res = Double(curHeight - minHeight)/(maxHeight - minHeight)
        return max(0, min(1,res))
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            if isShowing {
                Color
                    .black
                    .opacity(startOpacity + (endOpacity - startOpacity) * dragPercentage)
                    .ignoresSafeArea()
                    .onTapGesture { isShowing = false }
                mainView
                .transition(.move(edge:.bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut)
    }
    var mainView: some View{
        VStack{
            ZStack{
                Capsule()
                    .frame(width: 70, height: 4)
                    .padding()
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.00001))
            .gesture(dragGesture)
            ZStack{
                VStack{
                    Text("Sorry, but it seems you have ran out of credits.\nBuy more credits!")
                        .font(.system(size: 24, weight: .regular))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 30)
                }
                .padding(.bottom, 30)
            }
            .frame(maxHeight:.infinity)
        }
        .frame(height: curHeight)
        .frame(maxWidth: .infinity)
        .background(
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                Rectangle()
                    .frame(height: curHeight/2)
            }
                .foregroundColor(.white)
        )
        .animation(isDragging ? nil : .easeInOut(duration: 0.45))
    }
    
    @State private var prevDragTranslation = CGSize.zero
    
    var dragGesture: some Gesture{
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged{
                val in
                if !isDragging {
                    isDragging = true
                }
                let dragAmount = val.translation.height - prevDragTranslation.height
                if curHeight > maxHeight || curHeight < minHeight {
                    curHeight -= dragAmount/6
                } else {
                    curHeight -= dragAmount
                }
                prevDragTranslation = val.translation
            }
            .onEnded{
                val in
                prevDragTranslation = .zero
                isDragging = false
                if curHeight > maxHeight {
                    curHeight = maxHeight
                } else if curHeight < minHeight {
                    curHeight = minHeight
                }
            }
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
