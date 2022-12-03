//
//  CharacterDetailView.swift
//  BreakingBadSwiftUI
//
//  Created by Rakshith on 11/15/22.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @ObservedObject var viewInteractor: CharacterDetailViewInteractor
    
    init(viewInteractor: CharacterDetailViewInteractor) {
        self.viewInteractor = viewInteractor
    }
    
    var body: some View {
        ZStack {
            if case .loading = viewInteractor.viewState {
                getLoader()
            }
            else if case .display = viewInteractor.viewState {
                VStack(alignment: .center, spacing: 5) {
                    Spacer(minLength: 2)
                    
                    AsyncImage(
                        url: viewInteractor.characterImageUrl,
                        content: { image in
                            image.resizable()
                                .scaledToFit()
                        },
                        placeholder: {
                        }
                    )
                        .frame(maxWidth: UIScreen.main.bounds.size.width - 10, maxHeight: 350)
                    
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
                        UITableView.appearance().contentInset.top = 10
                    })
                }
            }
            else if case .error(let errorMessage) = viewInteractor.viewState {
                Text(errorMessage)
                    .padding()
                    .background(.red)
                    .foregroundColor(.white)
            }
        }.onAppear {
            viewInteractor.viewDidLoad()
        }
    }
    
    private func getLoader() -> some View {
        ProgressView()
            .scaleEffect(1, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(viewInteractor: CharacterDetailViewInteractor(
            selectedCharacterUIModel: CharacterUIModel(id: 1, name: "", liked: true, disliked: true),
            getAllQuotesService: GetAuthorQuoteService(),
            getCharacterDetailService: GetCharacterDetailService()))
    }
}

//protocol ItemViewModel: ObservableObject {
//    var title: String { get set }
//    func foo()
//}
//struct ItemView<Model>: View where Model: ItemViewModel

//class ConcreteItemModel: ItemViewModel {
//    @Published var title: String
//
//    init(_ title: String) {
//        self.title = title
//    }
//}
