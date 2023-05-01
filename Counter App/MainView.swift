//
//  ContentView.swift
//  Counter App
//
//  Created by Lucia Pettway on 4/30/23.
//

import SwiftUI
import AVFoundation
extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}

var player: AVAudioPlayer?


func playSound() {
    let systemSoundID: SystemSoundID = 1104  // the tweet sound. You can experiment with others
    AudioServicesPlaySystemSound (systemSoundID) // // to play sound
}

struct MainView: View {
    @State private var count: Double = 0
    @State private var showText = false
    @State private var minValue: Double = 0
    @State private var maxValue: Double = 100.0
    @State private var selectedTabIndex = 0
    @ObservedObject private var viewModel = uiDataViewModel()
    @ObservedObject private var countModel = countDataViewModel()

    func changeCount(direction: String) {
        
        if direction == "+" {
            if count < 100 {
                count += 1.0
            }
        } else {
            if(count > 0) {
                count -= 1.0
            }
        }
        
        playSound()
        checkVisible()
        updateDatabase()
    }
    
    func updateDatabase() {
        countModel.updateData(value: count)
    }
    
    func checkVisible(){
        if count == 100.00 {
            showText = true
        } else {
            showText = false
        }
    }
    
    func resetCounter() {
        count = 0
        playSound()
    }
    

    var body: some View {
        TabView() {
            VStack {
                VStack(alignment: .center) {
                    
                    Text("Counter")
                        .font(.system(size: 33))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 0.0)
                    
                    Spacer()
                    
                    Image("Dog").opacity(showText ? 1 : 0)
                    
                    Text("Wow you really pressed this \(Int(count)) times?")
                        .font(.system(size: 33))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal).opacity(showText ? 1 : 0)
                        
                    Text(String((count).removeZerosFromEnd()))
                        .font(.system(size: 100))
                        .padding(.horizontal)
                    

                    Gauge(value: count, in: minValue...maxValue) {
                        Text("Progress")
                    } currentValueLabel: {
                        Text("\(Int(count))%")
                    } minimumValueLabel: {
                        Text("\(Int(minValue))%")
                    } maximumValueLabel: {
                        Text("\(Int(maxValue))%")
                    }
                    .padding(.horizontal)
                    
                    Spacer()

                    HStack(alignment: .center) {
                        Button("Increment +1", action: {changeCount(direction: "+")} )
                            .buttonStyle(.borderedProminent)
                        Button("Decrement -1", action: {changeCount(direction: "-")} )
                            .buttonStyle(.borderedProminent)
                        Button("Reset", action: {resetCounter()} )
                            .buttonStyle(.borderedProminent)
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                .padding()
                .onAppear(perform: checkVisible)
                .onAppear(perform: self.viewModel.fetchData)
                .onAppear(perform: self.countModel.fetchData)
                .onReceive(countModel.$countData) { data in
                    if data.count > 0  {
                        count = Double(data[0].count)
                        print(data[0].count)
                    }
                }
                
                
            }
            .tag(0)
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            VStack(alignment: .center) {
                
                Text("About")
                    .font(.system(size: 33))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 0.0)

                Spacer()
                    .frame(height: 50.0)
                
                VStack {
                        ForEach(viewModel.uiTextNodes) { uiTextNode in
                            Text(uiTextNode.description).font(.title).multilineTextAlignment(.leading).padding([.top, .leading], 10.0)
                        }
                }
                

                
                Spacer()

            }
            .tag(1)
            .tabItem {
                Label("About", systemImage: "gearshape")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
