//
//  QuoteView.swift
//  BBQUOTES
//
//  Created by Vishwas Sharma on 22/03/24.
//

import SwiftUI

struct QuoteView: View {
    @StateObject private var viewModel = ViewModel(controller: FetchController())
    let show: String
    @State private var showCharacterInfo = false
    var body: some View {
        GeometryReader {
            geo in
            ZStack {
                Image(show.lowerNoSpaces)
                    .resizable()
                    .frame(width: geo.size.width * 2.7 , height: geo.size.height * 1.2)
                VStack {
                    VStack(spacing: 30) {
                        
                        switch viewModel.status {
                                
                            case .fetching:
                                ProgressView()
                            case .success(let data):
                                Text("\"\(data.quote.quote)\"")
                                    .minimumScaleFactor(0.5)
                                    .multilineTextAlignment(.center)
                                    .tint(.white)
                                    .padding()
                                    .background(.black.opacity(0.5))
                                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                    .padding(.horizontal)
                                
                                ZStack(alignment: .bottom) {
                                    AsyncImage(url: data.character.images.first) {
                                        image
                                        in
                                        image.resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.8)
                                    .onTapGesture {
                                        showCharacterInfo.toggle()
                                    }
                                    .sheet(isPresented: $showCharacterInfo) {
                                        CharacterView(show: show, character: data.character)
                                    }
                                    
                                    Text(data.character.name)
                                        .tint(.white)
                                        .padding(.bottom, 10)
                                        .frame(maxWidth: .infinity)
                                        .background(.ultraThinMaterial)
                                }
                                .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.8)
                                .clipShape(RoundedRectangle(cornerRadius: 80 ))
                            default:
                                EmptyView()
                                
                                
                                
                        }
                        
                    }
                    Button() {
                        
                        Task {
                            await viewModel.getData(for: show)
                        }
                        
                    } label: {
                        Text("Get Random Quote")
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color("\(show.noSpaces)Button"))
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                            .shadow(color: Color("\(show.noSpaces)Shadow"), radius: 2)
                    }
                    
                    
                }.frame(width: geo.size.width)
                
                
                
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    QuoteView(show: Constants.bbName)
        .preferredColorScheme(.dark)
}
