//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Gayan Kalinga on 5/9/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showScore = false
    @State private var score = 0
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 1...3)
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 1
        }else {
            scoreTitle = "Wrong that is the flag of \(countries[number])"
            score -= 1
        }
        
        showScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30){
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3){ number in
                    Button(action: {
                        flagTapped(number)
                        
                    }) {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                
                Spacer()
                
                Text("Score \(score)")
                    .foregroundColor(.white)
            }
            
            .alert(isPresented: $showScore){
                Alert(title: Text(scoreTitle), message: Text("Your score is: \(score) "), dismissButton: .default(Text("Ok")){
                    askQuestion()
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
