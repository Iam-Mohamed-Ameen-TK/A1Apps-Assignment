//
//  PersonCardView.swift
//  A1Apps Assignment
//
//  Created by Mohamed Ameen on 20/09/25.
//

import SwiftUI

struct PersonCard: View {
    let person: Person
    
    // Helper to format the DOB
    private var formattedDOB: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: person.dob) {
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
        return person.dob
    }
    
    // Star rating based on age
    private var starRating: Int {
        switch person.age {
        case ..<25: return 1
        case 26...50: return 2
        case 51...75: return 3
        case 76...100: return 4
        default: return 5
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Background with gradient shadow glow
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: Color.purple.opacity(0.4), radius: 6, x: 0, y: 3)
                .shadow(color: Color.pink.opacity(0.3), radius: 8, x: 0, y: 5)
            
            HStack(alignment: .top, spacing: 12) {
                // Person Image popping out
                AsyncImage(url: URL(string: person.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 90, height: 120)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 90, height: 120)
                            .clipped()
                            .cornerRadius(6)
                            .offset(y: -25)
                    case .failure:
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 90, height: 120)
                            .foregroundColor(.gray)
                            .offset(y: -25)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                // Person Details
                VStack(alignment: .leading, spacing: 4) {
                    Text(person.name)
                        .font(.headline)
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .truncationMode(.tail)

                    Text("Email \(person.email)")
                        .font(.caption)
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text("DOB: \(formattedDOB)")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text("\(person.age) years")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    
                    // Star Rating
                    HStack(spacing: 2) {
                        ForEach(0..<5, id: \.self) { index in
                            Image(systemName: index < starRating ? "star.fill" : "star")
                                .foregroundColor(.red)
                                .font(.caption2)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(10)
            
            ShopButton()
                .padding(20)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 16)
    }
}
