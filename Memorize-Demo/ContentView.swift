//
//  ContentView.swift
//  Memorize-Demo
//
//  Created by Pradipat Jareanporn on 10/10/2566 BE.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["🍊","🍋","🍌","🍇","🍑","🍎","🍏","🍓","🧅","🫐"] + ["🍊","🍋","🍌","🍇","🍑","🍎","🍏","🍓","🧅","🫐"]
    @State var cardCount = 5
    
    var body: some View {
        VStack{
            ScrollView{
                cards
            }
                cardCountAdjuster
        }
        .foregroundColor(.blue)
        .padding()
    }
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))]){
            ForEach(0..<cardCount, id: \.self){index in
                CardView(content: emojis[index] ,isFaceUp: true)
            }
        }
    }
    
    var cardCountAdjuster : some View{
        HStack{
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster (by offset: Int , symbol: String) -> some View{
        Button(action: {
            cardCount += offset
        }) {
            Image(systemName: symbol)
        }
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    var cardRemover: some View{
        cardCountAdjuster(by :-1 , symbol:
                            "rectangle.stack.fill.badge.minus")
    }
    
    var cardAdder: some View{
        cardCountAdjuster(by : 1 , symbol:
                            "rectangle.stack.fill.badge.plus")
    }
}

struct CardView : View {
    let content: String
    @State var isFaceUp: Bool = false
        
    var body: some View {
        ZStack{
            
            if isFaceUp{
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 2)
                    .foregroundColor(.blue)
                Text(content).font(.largeTitle)
                    .padding(30)
                    .opacity(1)
            } else{
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.blue)
                Text(content).font(.largeTitle)
                    .padding(30)
                    .opacity(0)
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
