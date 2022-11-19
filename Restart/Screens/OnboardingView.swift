//
//  OnboardingView.swift
//  Restart
//
//  Created by Adithyah Nair on 13/11/22.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - Properties

    @State private var buttonWidth = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0

    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true

    // MARK: - Views

    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)

            VStack(spacing: 20) {
                Spacer()

                VStack(spacing: 0) {
                    Text("Share.")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)

                    Text("""
                    It's not how much we give but
                    how much love we put into giving.
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                    Spacer()

                    ZStack {
                        CircleGroupView(circleColor: .white, circleOpacity: 0.2)
                        ZStack {
                            Image("character-1")
                                .resizable()
                                .scaledToFit()
                        }
                    }

                    Spacer()

                    ZStack {
                        // 1. Background (Static)

                        Capsule()
                            .fill(Color.white.opacity(0.2))
                        Capsule()
                            .fill(Color.white.opacity(0.2))
                            .padding(8)

                        // 2. Call-to-Action (Dynamic)

                        Text("Get started")
                            .foregroundColor(.white)
                            .font(.system(size: 20).weight(.bold))
                            .offset(x: 20)

                        // 3. Capsule (Dynamic Width)

                        HStack {
                            Capsule()
                                .fill(Color("ColorRed"))
                                .frame(width: buttonOffset > buttonWidth / 2 ? buttonOffset + 72 : buttonOffset + 80)

                            Spacer()
                        }

                        // 4. Circle (Draggable)

                        HStack {
                            ZStack {
                                Circle()
                                    .fill(Color("ColorRed"))
                                Circle()
                                    .fill(Color.black.opacity(0.15))
                                    .padding(8)
                                Image(systemName: "chevron.right.2")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24).weight(.bold))
                            }
                            .offset(x: buttonOffset)
                            .gesture(
                                DragGesture()
                                    .onChanged({ gesture in
                                        if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                            buttonOffset = gesture.translation.width
                                        }
                                    })
                                    .onEnded({ _ in
                                        if buttonOffset > buttonWidth / 2 {
                                            isOnboardingViewActive = false
                                        } else {
                                            buttonOffset = 0
                                        }
                                    })
                            )
                            .frame(width: 80, height: 80, alignment: .center)

                            Spacer()
                        }
                    }
                    .frame(width: buttonWidth, height: 80)
                    .padding()
                }
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
