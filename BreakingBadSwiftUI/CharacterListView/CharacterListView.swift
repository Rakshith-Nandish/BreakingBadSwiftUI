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
            if case .loading = viewModel.viewState {
                getLoader()
            }
            else if case .display = viewModel.viewState {
                List(viewModel.listCharacterUIModels, id: \.id) {
                    character in
                    Navigator.navigate(route: .detail(characterUIModel: character)) {
                        getListItemView(characterUIModel: character)
                    }
                }
                .listStyle(.automatic)
                .navigationTitle("Characters")
            }
            else if case .error = viewModel.viewState {
                Text("Looks like something went wrong!!")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(Color.white)
            }
        }.navigationViewStyle(.stack)
            .onAppear {
                viewModel.viewDidLoad()
            }
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
    
    private func getLoader() -> some View {
        ProgressView()
            .scaleEffect(1, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
