//
//  ContentView.swift
//  Counter App
//
//  Created by Lucia Pettway on 4/30/23.
//

import SwiftUI


extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}

struct ContentView: View {
    @State private var count: Double = 0
    @State private var showText = false
    @State private var minValue: Double = 0
    @State private var maxValue: Double = 100.0


    
    func changeCount(direction: String) {
        if direction == "+" {
            count += 1.0
        } else {
            count -= 1.0
        }
        
        checkVisible()
    }
    
    func checkVisible(){
        if count >= 100.00 {
            showText = true
        } else {
            showText = false
        }
    }
    
    func resetCounter() {
        count = 0
    }
    
    var body: some View {
        VStack {
            if showText {
                Text("Wow you really pressed this \(Int(count)) times?")
                    .font(.system(size: 33))
                    .multilineTextAlignment(.center)
            }
            
            Text(String((count).removeZerosFromEnd()))
                .font(.system(size: 100))
            
            Gauge(value: count, in: minValue...maxValue) {
                Text("Progress")
            } currentValueLabel: {
                Text("\(Int(count))%")
            } minimumValueLabel: {
                Text("\(Int(minValue))%")
            } maximumValueLabel: {
                Text("\(Int(maxValue))%")
            }

            HStack {
                Button("Increment +1", action: {changeCount(direction: "+")} )
                    .buttonStyle(.borderedProminent)
                Button("Decrement -1", action: {changeCount(direction: "-")} )
                    .buttonStyle(.borderedProminent)
                Button("Reset", action: {resetCounter()} )
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .onAppear(perform: checkVisible)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
