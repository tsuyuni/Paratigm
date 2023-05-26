//
//  ContentView.swift
//  Paratigm
//
//  Created by Tsuchikawa Yuri on 2023/05/26.
//

import SwiftUI

enum ContentState {
    case first
    case second
}

struct ContentView: View {
    
    @State var statusArray: [ContentState] = [.first, .first, .first, .first, .first]
    
    
    var body: some View {
        List {
            
            ForEach (0 ..< statusArray.count, id: \.self) { index in
                HStack {
                    switch statusArray[index] {
                    case .first:
                        PlayView(state: $statusArray[index])
                    case .second:
                        PauseView(state: $statusArray[index])
                    }
                    Text("0")
                    Spacer()
                }
                .contentShape(Rectangle())
                .accessibilityIdentifier("content")
            }
        }
    }
}

struct PlayView: View {
    @Binding var state: ContentState
    var body: some View {
        Image(systemName: "play.fill")
            .resizable()
            .renderingMode(.template)
            .foregroundColor(.green)
            .frame(width: 30.0, height: 30.0)
            .onTapGesture {
                state = .second
                print(state)
            }
    }
}

struct PauseView: View {
    @Binding var state: ContentState
    var body: some View {
        Image(systemName: "pause.fill")
            .resizable()
            .renderingMode(.template)
            .foregroundColor(.green)
            .frame(width: 30.0, height: 30.0)
            .onTapGesture {
                state = .first
                print(state)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
