//
//  ContentView.swift
//  A1Apps Assignment
//
//  Created by Mohamed Ameen on 20/09/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PeopleViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                //  Gradient for the background (top 1/3)
                GeometryReader { geo in
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.85, green: 0.0, blue: 0.3), // pinkish red
                            Color(red: 0.4, green: 0.0, blue: 0.3)   // deep purple
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(height: geo.size.height / 3)
                    .ignoresSafeArea(edges: .top)
                }
                
                VStack(spacing: 0) {
                    //  Top bar
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .medium))
                            
                            Spacer()
                            
                            Image(systemName: "ellipsis")
                                .rotationEffect(.degrees(90))
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .medium))
                        }
                        .padding(.horizontal)
                        
                        Text("Interview Details")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        Text("\(viewModel.people.count) Profiles")
                            .font(.system(size: 16))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                    // Scrollable cards
                    ScrollView {
                        LazyVStack(spacing: 25) {
                            ForEach(viewModel.displayedPeople) { person in
                                PersonCard(person: person)
                            }
                            
                            if viewModel.isLoading {
                                ProgressView()
                                    .padding()
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 30)
                    }
                    
                    // Pagination
                    if viewModel.availablePages.count > 1 {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(viewModel.availablePages, id: \.self) { page in
                                    Button(action: {
                                        viewModel.loadPage(page)
                                    }) {
                                        Text("\(page + 1)")
                                            .font(.caption2)
                                            .frame(width: 30, height: 30)
                                            .background(viewModel.currentPage == page ? Color.red : Color.gray.opacity(0.2))
                                            .foregroundColor(viewModel.currentPage == page ? .white : .black)
                                            .cornerRadius(6)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 4)
                        }
                        .background(Color.white.opacity(0.9))
                    }
                    
                    // Bottom Tab Bar
                    HStack {
                        Spacer()
                        Image(systemName: "house.fill")
                            .font(.title2)
                            .foregroundColor(.red)
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .foregroundColor(.gray)
                        Spacer()
                        Image(systemName: "person.circle")
                            .font(.title2)
                            .foregroundColor(.gray)
                        Spacer()
                        Image(systemName: "bell")
                            .font(.title2)
                            .foregroundColor(.gray)
                        Spacer()
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: -2)
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                Task {
                    await viewModel.fetchData()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
