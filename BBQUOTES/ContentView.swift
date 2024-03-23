//
//  ContentView.swift
//  BBQuotes
//
//  Created by Vishwas Sharma on 18/03/24.
//

import SwiftUI
 
/// ContentView View
struct ContentView: View {
    var body: some View {
        TabView {
            QuoteView(show: Constants.bbName)
                .tabItem {
                    Label("Breaking bad", systemImage: "tortoise")
                }
            QuoteView(show: Constants.bcsName)
                .tabItem {
                    Label("Better call Saul", systemImage: "briefcase")
                }
        }
        .onAppear {
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        }
        .preferredColorScheme(.dark)
        
        
    }
}

#Preview {
    ContentView()
}

