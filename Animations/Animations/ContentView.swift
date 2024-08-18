//
//  ContentView.swift
//  Animations
//
//  Created by Akshat Gandhi on 18/08/24.
//

import SwiftUI

struct CorenerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CorenerRotateModifier(amount: -90, anchor: .topLeading), identity: CorenerRotateModifier(amount: 0, anchor: .topLeading))
    }
    
}

struct ContentView: View {
    @State private var animationAmount = 0.0
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    @State private var isShowingResult = false
    
    let letters = Array("Hello Priyank")
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            
            
            if isShowingResult {
                Rectangle()
                    .fill(.orange)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingResult.toggle()
            }
        }
    }
}

#Preview {
    ContentView()
}

//Button("Touch Me") {
//   animationAmount += 1
//}
//.padding(50)
//.background(.blue)
//.foregroundColor(.white)
//.clipShape(.circle)
//.scaleEffect(animationAmount)
//.blur(radius: (animationAmount - 1) * 3)
//.animation(.default, value: animationAmount)
//.animation(.linear, value: animationAmount)
//.animation(.spring(duration: 1, bounce: 0.9), value: animationAmount)


//Button("Touch Me") {
//   animationAmount += 1
//}
//.padding(50)
//.background(.blue)
//.foregroundColor(.white)
//.clipShape(.circle)
//.overlay(
//    Circle()
//        .stroke(.red)
//        .scaleEffect(animationAmount)
//        .opacity(2 - animationAmount)
//        .animation(.easeInOut(duration: 2)
//            .repeatForever(autoreverses: true),
//            value: animationAmount)
//)
//.onAppear{
//    animationAmount = 2
//}


//VStack {
//    Stepper("Scale Amount", value: $animationAmount.animation(
//        .easeInOut(duration: 1)
//        .repeatCount(3, autoreverses: true)), in: 1...10)
//
//    Spacer()
//
//    Button("Tap Me") {
//        animationAmount += 1
//    }
//    .padding(40)
//    .background(.blue)
//    .foregroundColor(.white)
//    .clipShape(Circle())
//    .scaleEffect(animationAmount)
//}

//Button("Tap Me") {
//    withAnimation(.spring(duration: 1, bounce: 0.5)) {
//        animationAmount += 360
//    }
//}
//.padding(50)
//.background(.orange)
//.foregroundColor(.white)
//.clipShape(Circle())
//.rotation3DEffect(.degrees(animationAmount), axis: (x: 0.0, y: 1.0, z: 0.0)
//)

//Button("Tap Me") {
//    enabled.toggle()
//}
//.frame(width: 200, height: 200)
//.background(enabled ? .pink : .orange)
//.foregroundColor(.white)
//.animation(.default, value: enabled)
//.clipShape(.rect(cornerRadius: enabled ? 100.0 : 0.0))
//.animation(.spring(duration:1, bounce: 0.9), value: enabled)

//LinearGradient(colors: [.blue, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
//    .frame(width: 300, height: 200)
//    .clipShape(.rect(cornerRadius: 10.0))
//    .offset(dragAmount)
//    .gesture(
//        DragGesture()
//            .onChanged {dragAmount = $0.translation }
//            .onEnded {_ in
//                withAnimation(.bouncy) {
//                    dragAmount = .zero
//                }
//            }
//    )

//HStack(spacing: 0) {
//    ForEach(0..<letters.count, id: \.self) { index in
//        Text(String(letters[index]))
//            .padding(5)
//            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//            .background(.orange)
//            .foregroundStyle(.white)
//            .offset(dragAmount)
//            .animation(.linear.delay(Double(index)/10), value: dragAmount)
//    }
//}
//.gesture(
//    DragGesture()
//        .onChanged { dragAmount = $0.translation }
//        .onEnded { _ in dragAmount = .zero}
//)
