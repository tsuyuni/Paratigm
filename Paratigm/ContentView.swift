//
//  ContentView.swift
//  Paratigm
//
//  Created by Tsuchikawa Yuri on 2023/05/26.
//

import SwiftUI

enum ContentState {
    case pausing
    case playing
}

struct CountTimer {
    var time: TimeInterval = 0
    var state: ContentState = .pausing
    var timer: Timer!
}

var timer: Timer!

struct ContentView: View {
    
    @State var timersArray: [CountTimer] = [CountTimer(), CountTimer(), CountTimer(), CountTimer(), CountTimer()]
    
    func intToTime(time: TimeInterval) -> String {
        let dateFormatter = DateComponentsFormatter()
        dateFormatter.unitsStyle = .positional
        dateFormatter.allowedUnits = [.hour, .minute, .second]
        return(dateFormatter.string(from: time)!)
    }
    
    var body: some View {
        List {
            
            ForEach (0 ..< timersArray.count, id: \.self) { index in
                HStack {
                    switch timersArray[index].state {
                    case .playing:
                        PauseView(state: $timersArray[index].state, timer: $timersArray[index].timer)
                    case .pausing:
                        PlayView(state: $timersArray[index].state, timer: $timersArray[index].timer, time: $timersArray[index].time)
                    }

                    Text(intToTime(time: timersArray[index].time))
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
    @Binding var timer: Timer?
    @Binding var time: TimeInterval
    var body: some View {
        Image(systemName: "play.fill")
            .resizable()
            .renderingMode(.template)
            .foregroundColor(.green)
            .frame(width: 30.0, height: 30.0)
            .onTapGesture {
                state = .playing
                timer = Timer.init(timeInterval: 1.0, repeats: true) { _ in
                    time += 1
                }
                RunLoop.current.add(timer!, forMode: .common)
            }
    }
}

struct PauseView: View {
    @Binding var state: ContentState
    @Binding var timer: Timer?
    var body: some View {
        Image(systemName: "pause.fill")
            .resizable()
            .renderingMode(.template)
            .foregroundColor(.green)
            .frame(width: 30.0, height: 30.0)
            .onTapGesture {
                state = .pausing
                timer!.invalidate()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
