//
//  ContentView.swift
//  SwiftUIElements
//
//  Created by Alexey Turulin on 9/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var sliderValue = Double.random(in: 0...255)
    @State private var userName = ""
    @State private var displayedName = ""
    @State private var alertPresented = false
    
    var body: some View {
        ZStack {
            Color(red: 0.95, green: 0.95, blue: 0.95)
                .ignoresSafeArea()
            VStack(spacing: 40) {
                Text("\(lround(sliderValue))")
                    .font(.largeTitle)
                UserNameView(name: displayedName)
                ColorSliderView(value: $sliderValue)
                TextField("Enter your name", text: $userName)
                    .bordered()
                Text("Welcome to SwiftUI")
                    .font(.system(size: 60))
                    .bold()
                    .foregroundColor(.red)
                    .padding()
                    .background(.blue)
                    .cornerRadius(20)
                
                Spacer()
                Button("Done", action: checkUserName)
                    .alert("Wrong Format", isPresented: $alertPresented, actions: {}) {
                        Text("Enter your name")
                    }
            }
            .padding()
        }
    }
    
    private func checkUserName() {
        if let _ = Double(userName) {
            userName = ""
            alertPresented.toggle()
            return
        }
        displayedName = userName
        userName = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorSliderView: View {
    @Binding var value: Double
    
    var body: some View {
        HStack {
            Text("0").foregroundColor(.red)
            Slider(value: $value, in: 0...255, step: 1)
            Text("255").foregroundColor(.red)
        }
    }
}

struct UserNameView: View {
    let name: String
    var body: some View {
        HStack {
            HStack(alignment: .firstTextBaseline) {
                Text("USER NAME: ").frame(height: 60)
                Text(name)
                    .font(.largeTitle)
            }
            Spacer()
        }
    }
}

struct BorderedViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.blue)
            )
            .shadow(color: .gray.opacity(0.4), radius: 3, x: 1, y: 2)
    }
}

extension TextField {
    func bordered() -> some View {
        modifier(BorderedViewModifier())
    }
}
