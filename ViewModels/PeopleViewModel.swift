//
//  PersonViewModel.swift
//  A1Apps Assignment
//
//  Created by Mohamed Ameen on 20/09/25.
//

import Foundation
import SwiftUI

@MainActor
class PeopleViewModel: ObservableObject {
    @Published var people: [Person] = []
    @Published var displayedPeople: [Person] = []
    @Published var isLoading: Bool = false
    @Published var currentPage: Int = 0
    
    private let pageSize: Int = 100
    private var totalPages: Int = 0
    
    func fetchData() async {
        guard !isLoading else { return }
        isLoading = true
        
        do {
            guard let url = URL(string: "https://core-apis.a1apps.co/ios/interview-details") else {
                isLoading = false
                return
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(APIResponse.self, from: data)
            
            people = response.data
            totalPages = (people.count + pageSize - 1) / pageSize
            loadPage(0) // Load first page
            isLoading = false
        } catch {
            print("Error fetching data: \(error)")
            isLoading = false
        }
    }
    
    func loadPage(_ page: Int) {
        let startIndex = page * pageSize
        let endIndex = min((page + 1) * pageSize, people.count)
        
        guard startIndex < people.count else { return }
        displayedPeople = Array(people[startIndex..<endIndex])
        currentPage = page
    }
    
    var availablePages: [Int] {
        Array(0..<totalPages)
    }
}
