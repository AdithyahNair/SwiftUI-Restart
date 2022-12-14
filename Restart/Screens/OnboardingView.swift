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
    @State private var imageOffset: CGSize = .zero
    @State private var opacityIndicator: Double = 1.0
    @State private var titleText: String = "Share."
    @State private var isAnimating: Bool = false
    
    let hapticFeedback = UINotificationFeedbackGenerator()

    // MARK: - Functions

    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true

    // MARK: - Views

    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)

            VStack(spacing: 20) {
                Spacer()

                VStack(spacing: 0) {
                    Text(titleText)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)

                    Text(" It's not how much we give but how much love we put into giving.")
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeIn(duration: 1), value: isAnimating)

                ZStack {
                    CircleGroupView(circleColor: .white, circleOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width) / 5)
                        .animation(.easeOut(duration: 1), value: imageOffset)

                    ZStack {
                        Image("character-1")
                            .resizable()
                            .scaledToFit()
                            .opacity(isAnimating ? 1 : 0)
                            .animation(.easeOut(duration: 1), value: isAnimating)
                            .offset(x: imageOffset.width, y: 0)
                            .rotationEffect(.degrees(Double(imageOffset.width / 24)))
                            .gesture(
                                DragGesture()
                                    .onChanged({ gesture in
                                        if abs(gesture.translation.width) <= 180 {
                                            imageOffset = gesture.translation
                                            opacityIndicator = 0
                                            titleText = "Give."
                                        }
                                    })
                                    .onEnded({ _ in
                                        withAnimation(Animation.linear(duration: 1)) {                   imageOffset = .zero
                                            opacityIndicator = 1
                                            titleText = "Share."
                                        }
                                    })
                            )
                    }
                    .overlay(
                        Image(systemName: "arrow.left.and.right.circle")
                            .foregroundColor(.white)
                            .font(.system(size: 40, weight: .ultraLight))
                            .offset(y: 20)
                            .opacity(isAnimating ? 1 : 0)
                            .opacity(opacityIndicator)
                            .animation(.easeIn(duration: 1).delay(1), value: isAnimating)
                        , alignment: .bottom
                    )
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
                                    withAnimation(Animation.easeOut(duration: 0.5)) {
                                        if buttonOffset > buttonWidth / 2 {
                                            playSound(sound: "chimeup", type: "mp3")
                                            hapticFeedback.notificationOccurred(.success)
                                            isOnboardingViewActive = false
                                        } else {
                                            hapticFeedback.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
                                    }
                                })
                        )
                        .frame(width: 80, height: 80, alignment: .center)

                        Spacer()
                    }
                }
                .frame(width: buttonWidth, height: 80)
                .padding()
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            }
        }
        .onAppear {
            isAnimating = true
        }
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
