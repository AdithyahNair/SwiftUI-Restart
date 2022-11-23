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
    @State private var imageOffset = 0

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            ZStack {
                CircleGroupView(circleColor: .gray, circleOpacity: 0.1)

                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(Animation
                        .easeIn(duration: 3)
                        .repeatForever()
                        , value: isAnimating)
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
                withAnimation(Animation.easeOut(duration: 3)) {
                    isOnboardingViewActive = true
                }
               
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                isAnimating = true
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
