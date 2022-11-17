//
//  CharacterDetailView.swift
//  BreakingBadSwiftUI
//
//  Created by Rakshith on 11/15/22.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @ObservedObject var viewInteractor: CharacterDetailViewInteractor
    
    init(characterUIModel: CharacterUIModel) {
        self.viewInteractor = CharacterDetailViewInteractor(selectedCharacterUIModel: characterUIModel)
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 5) {
                Spacer(minLength: 2)
                
                AsyncImage(
                    url: viewInteractor.characterImageUrl,
                    content: { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(maxWidth: UIScreen.main.bounds.size.width - 10, maxHeight: 350)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(viewInteractor.characterName)
                            .font(.custom("Arial", size: 20))
                            .fontWeight(.semibold)

                        Text(viewInteractor.characterPortrayedBy)
                            .font(.custom("Arial", size: 12))
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
        }.onAppear {
            viewInteractor.viewDidLoad()
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(characterUIModel: CharacterUIModel(id: 0,
                                                               name: "",
                                                               liked: true,
                                                               disliked: true))
    }
}
