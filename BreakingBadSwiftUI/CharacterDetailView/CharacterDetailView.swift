//
//  CharacterDetailView.swift
//  BreakingBadSwiftUI
//
//  Created by Rakshith on 11/15/22.
//

import SwiftUI

struct CharacterDetailView: View {
    let arrayItems = ["Amitab", "Aftaab", "Sonali Bendre"]
    
    @ObservedObject var viewInteractor: CharacterDetailViewInteractor = CharacterDetailViewInteractor()
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 5) {
                Spacer(minLength: 2)
                Image("bannerImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.size.width - 10,
                           height: 350,
                           alignment: .center)
                    .background(.black)
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Character Name")
                            .font(.custom("Arial", size: 20))
                            .fontWeight(.semibold)

                        Text("Played by:")
                            .font(.custom("Arial", size: 10))
                            .fontWeight(.light)
                            .padding(.bottom, 3)
                    }.padding(.leading, 10)
                    
                    Spacer()
                }.frame(width: UIScreen.main.bounds.size.width)
                
                List(viewInteractor.listAuthorQuotes, id: \.id) { authorItem in
                    Text(authorItem.quote)
                        .padding()
                }.onAppear(perform: {
                    UITableView.appearance().contentInset.top = -20
                })
            }
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView()
    }
}
