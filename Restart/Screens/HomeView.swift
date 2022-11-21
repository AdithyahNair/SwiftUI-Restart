//
//  HomeView.swift
//  Restart
//
//  Created by Adithyah Nair on 13/11/22.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties

    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    @State private var isAnimating: Bool = false
    
    private func reverseBool() -> Bool {
        return isAnimating ? false : true
    }

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            ZStack {
                CircleGroupView(circleColor: .gray, circleOpacity: 0.1)
                    .offset(y: isAnimating ? 40 : -40)
                    .animation(.easeIn(duration: 5), value: isAnimating)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
            }

            Spacer()

            Text("""
                I want the world to know our secret
                and understand the consequences of it.
            """)
            .foregroundColor(.secondary)
            .font(.title3)
            .multilineTextAlignment(.center)

            Spacer()

            Button {
                // Action
                isOnboardingViewActive = true
            } label: {
                Image(systemName: "restart.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }
        .onAppear() {
            isAnimating = reverseBool()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
