//
//  ContentView.swift
//  swift-calc
//
//  Created by Eric Dolecki on 2/22/20.
//  Copyright © 2020 Eric Dolecki. All rights reserved.
//

import SwiftUI

enum CalculatorButton: String {
    
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, multiply, divide, decimel
    case ac, plusMinus, percent
    
    var backgroundColor: Color {
        switch self {
        case .zero:
            return Color(.darkGray)
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimel:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.gray)
        default:
            return Color(.orange)
        }
    }
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .ac: return "AC"
        case .plus: return "+"
        case .multiply: return "x"
        case .minus: return "-"
        case .plusMinus: return "+/-"
        case .divide: return "/"
        case .percent: return "%"
        case .decimel: return "."
        case .equals: return "="
        }
    }
}

// Environment Object

class GlobalEnvironment: ObservableObject {
    
    // When this changes, stuff happens.
    @Published var display = ""
    
    func receivedInput(calculatorButton: CalculatorButton) {
        self.display = calculatorButton.title
    }
}

struct ContentView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    let buttons:[[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimel, .equals]
    ]
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                HStack {
                    Spacer()
                    Text(env.display)
                        .foregroundColor(.white)
                        .font(.system(size: 64))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                }.padding()
                
                ForEach(buttons, id:\.self) { row in
                    HStack {
                        ForEach(row, id:\.self) { button in
                            CalculatorButtonView(button: button)
                        }
                    }
                }
            }.padding(.bottom)
        }
    }
}

// Like a component.
struct CalculatorButtonView: View
{
    var button: CalculatorButton
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        Button(action: {
            print(self.button)
            if self.button != .ac && self.button != .plusMinus && self.button != .percent && self.button != .divide && self.button != .multiply && self.button != .minus && self.button != .plus && self.button != .equals {
                    self.env.receivedInput(calculatorButton: self.button)
            }
            
        }) {
            Text(button.title)
            .frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4)
            .foregroundColor(.white)
            .font(.system(size: 32, weight: .bold))
            .background(button.backgroundColor)
            .cornerRadius(self.buttonWidth(button: button))
        }
    }
    
    private func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 5 * 12) / 4 * 2
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvironment())
    }
}
