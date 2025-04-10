//
//  ContentView.swift
//  PremiumCard
//
//  Created by Shota Sakoda on 2025/04/10.
//

import SwiftUI
struct PremiumCard: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let color1: Color
    let color2: Color
    let features: [String]
}

let cards = [
    PremiumCard(
        title: "ベーシック",
        icon: "star.fill",
        color1: .purple,
        color2: .indigo,
        features: ["5プロジェクト", "容量3GB", "電話対応"]
    ),
    PremiumCard(
        title: "プレミアム",
        icon: "crown.fill",
        color1: .blue,
        color2: .cyan,
        features: ["50プロジェクト", "容量10GB", "24時間電話対応", "分析ツール"]
    ),
    PremiumCard(
        title: "ビジネス",
        icon: "diamond.fill",
        color1: .pink,
        color2: .purple,
        features: ["無制限", "容量50GB", "24時間電話対応", "分析ツール", "コンサルティング"]
    )
]

struct HorizontalScrollComponent: View {
    
    var body: some View {
        ZStack {
            Color.color1.ignoresSafeArea()
            VStack(alignment: .leading) {
                // Section title
                Text("プラン一覧")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(cards) { card in
                            CardView(card: card)
                                .containerRelativeFrame(.horizontal, count: 2, span: 1, spacing: 20)
                                .scrollTransition { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1 : 0.8)
                                        .scaleEffect(phase.isIdentity ? 1 : 0.9)
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .safeAreaPadding(.horizontal, 20)
                .frame(height: 400)

                Text("コンテンツをご利用になるにはプランの更新が必要です")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }
}


struct CardView: View {
    let card: PremiumCard
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: card.icon)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                
                Spacer()
                
                Text(card.title)
                    .font(.title3.bold())
                    .foregroundStyle(.white)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(card.features, id: \.self) { feature in
                    HStack(spacing: 10) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.white)
                        
                        Text(feature)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.9))
                    }
                }
            }
            .padding(.top)
            
            Spacer()
            
            Button(action: {}) {
                Text("Choose")
                    .font(.callout.bold())
                    .foregroundStyle(
                        LinearGradient(
                            colors: [card.color1, card.color2],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [card.color1, card.color2]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .shadow(color: card.color1.opacity(0.4), radius: 5, x: 0, y: 10)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .animation(.smooth, value: card.features)
    }
}

struct ContentView: View {
    var body: some View {
        HorizontalScrollComponent()
    }
}

#Preview {
    ContentView()
}

