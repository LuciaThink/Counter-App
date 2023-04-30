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
        
        if count == 100 {
            showText.toggle()
        }
    }

    
    var body: some View {
        VStack {
            if showText {
                Text("Wow you really clicked this 100 times?")
                    .font(.system(size: 33))
                    .multilineTextAlignment(.center)
            }
            
            Gauge(value: count, in: minValue...maxValue) {
                Text("Progress")
            } currentValueLabel: {
                Text("\(Int(count))%")
            } minimumValueLabel: {
                Text("\(Int(minValue))%")
            } maximumValueLabel: {
                Text("\(Int(maxValue))%")
            }


            Text(String((count).removeZerosFromEnd()))
                .font(.system(size: 100))

            HStack {
                Button("Increment +1", action: {changeCount(direction: "+")} )
                    .buttonStyle(.borderedProminent)
                Button("Decrement -1", action: {changeCount(direction: "-")} )
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
