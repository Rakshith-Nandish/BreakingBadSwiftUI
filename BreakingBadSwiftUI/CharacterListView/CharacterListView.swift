//
//  CharacterListView.swift
//  BreakingBadSwiftUI
//
//  Created by Rakshith on 11/15/22.
//

import SwiftUI

struct CharacterListView: View {
        
    @ObservedObject var viewModel = CharacterListInteractor()
    
    var body: some View {
        NavigationView {
            List(viewModel.listCharacterUIModels, id: \.id) {
                character in
                Navigator.navigate(route: .detail(characterUIModel: character)) {
                    getListItemView(characterUIModel: character)
                }
            }
            .listStyle(.automatic)
            .navigationTitle("Characters")
        }.navigationViewStyle(.stack)
    }
    
    private func getListItemView(characterUIModel: CharacterUIModel) -> some View {
        return HStack {
            Text(characterUIModel.name)
            Spacer()
            if characterUIModel.liked {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            }
            if characterUIModel.disliked {
                Image(systemName: "hand.thumbsdown.fill")
                    .foregroundColor(.black)
            }
        }.frame(height: 54)
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
