//
//  ContentView.swift
//  TryCreateAlertView
//
//  Created by Weerawut Chaiyasomboon on 4/2/2568 BE.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                Button("Show Alert") {
                    showAlert.toggle()
                }
                .alert(isPresented: $showAlert) {
                    //Alert View
//                    VStack(spacing: 15) {
//                        Text("Hello I am Alert")
//                            .fontWeight(.semibold)
//                            .underline()
//                        
//                        Button("Dismiss") {
//                            showAlert.toggle()
//                        }
//                        .buttonStyle(.borderedProminent)
//                        .tint(.blue)
//                        .buttonBorderShape(.roundedRectangle(radius: 10))
//                    }
//                    .padding(15)
//                    .background(.background, in: .rect(cornerRadius: 10))
//                    .transition(.blurReplace.combined(with: .push(from: .bottom)))
                    
                    //CustomDialog
                    CustomDialog(
                        title: "Folder Name",
                        content: "Enter a file name",
                        image: .init(content: "folder.fill.badge.plus", tint: .blue, foreground: .white),
                        button1: .init(content: "Save Folder", tint: .blue, foreground: .white, action: { folder in
                            print(folder)
                            showAlert = false
                        }),
                        button2: .init(content: "Cancel", tint: .red, foreground: .white, action: { _ in
                            showAlert = false
                        }),
                        addTextField: true,
                        textFieldHint: "Personal documents"
                    )
                    .transition(.blurReplace.combined(with: .push(from: .bottom)))
                    
                } background: {
                    //Background View
                    Rectangle()
                        .fill(.primary.opacity(0.3))
                }

            }
            .navigationTitle("Custom Alert")
        }
    }
}

#Preview {
    ContentView()
}

struct CustomDialog: View {
    var title: String
    var content: String?
    var image: Config
    var button1: Config
    var button2: Config?
    var addTextField: Bool = false
    var textFieldHint: String = ""
    
    @State private var text: String = ""
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: image.content)
                .font(.title)
                .foregroundStyle(image.foreground)
                .frame(width: 65, height: 65)
                .background(image.tint.gradient, in: .circle)
                .background {
                    Circle()
                        .stroke(.background, lineWidth: 8)
                }
            
            Text(title)
                .font(.title3.bold())
            
            if let content {
                Text(content)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .foregroundStyle(.gray)
                    .padding(.vertical,4)
            }
            
            if addTextField {
                TextField(textFieldHint, text: $text)
                    .padding(.horizontal,15)
                    .padding(.vertical,12)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray.opacity(0.1))
                    )
                    .padding(.bottom,5)
            }
            
            ButtonView(button1)
            
            if let button2 {
                ButtonView(button2)
                    .padding(.top,-5)
            }
        }
        .padding([.horizontal, .bottom], 15)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.background)
                .padding(.top,30)
        )
        .frame(maxWidth: 310)
        .compositingGroup()
    }
    
    //Button View
    @ViewBuilder
    private func ButtonView(_ config: Config) -> some View {
        Button {
            config.action(addTextField ? text : "")
        } label: {
            Text(config.content)
                .fontWeight(.bold)
                .foregroundStyle(config.foreground)
                .padding(.vertical,10)
                .frame(maxWidth: .infinity)
                .background(
                    config.tint.gradient, in: .rect(cornerRadius: 10)
                )
        }

    }
    
    struct Config {
        var content: String
        var tint: Color
        var foreground: Color
        var action: (String) -> () = { _ in }
    }
}
