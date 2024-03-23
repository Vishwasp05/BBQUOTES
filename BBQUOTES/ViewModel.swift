//
//  ViewModel.swift
//  BBQUOTES
//
//  Created by Vishwas Sharma on 22/03/24.
//

import Foundation


@MainActor
class ViewModel: ObservableObject {
    enum Status {
        case notStarted
        case fetching
        case success(data: (quote: QuoteModel, character: CharacterModel))
        case failed(error: Error)
    }
    
    
    @Published private(set) var status: Status = .notStarted
    
    private let controller: FetchController
    
    init(controller: FetchController) {
         self.controller = controller
    }
    
    func getData(for show: String) async {
        status = .fetching
        
        do {
            let quote = try await controller.fetchQuote(from: show)
            
            let character = try await controller.fetchCharacter(quote.character)
            
            status = .success(data: (quote, character))
        } catch {
            status = .failed(error: error)
        }
    }
}
