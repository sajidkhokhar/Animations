//
//  AppearAnimation.swift
//  Translate AI
//
//  Created by Sajid on 25/04/25.
//

import SwiftUI

// MARK: - Animation Types for View Appearance

enum AppearAnimation {
    // Simple effects
    case fade
    case scale(from: CGFloat = 0.5)
    case center(scale: CGFloat = 0.8, fade: Bool = true)

    // Directional entrance animations
    case fromTop
    case fromBottom
    case fromLeft
    case fromRight

    // Combined effects with direction and scale
    case slide(from: Edge)
    case combined(from: Edge, scale: CGFloat = 0.8)

    // Fancy/custom animations
    case bottomBounce
    case bottomPop(scale: CGFloat = 0.9)
    case bottomFadeRise
    case bottomDrop(bounceHeight: CGFloat = 100)
}

// MARK: - ViewModifier for AppearAnimation

struct AppearAnimationModifier: ViewModifier {
    let animation: AppearAnimation
    let delay: Double
    let duration: Double
    let curve: Animation

    @State private var isVisible = false

    func body(content: Content) -> some View {
        // Apply the selected animation effect and animate changes to `isVisible`
        let animatedView = applyAnimationEffect(to: content)
            .animation(curve.delay(delay), value: isVisible)

        return animatedView
            .onAppear {
                // Trigger the animation after the specified delay
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    isVisible = true
                }
            }
            .onDisappear {
                // Reset visibility on disappear (optional)
                isVisible = false
            }
    }

    // MARK: - Apply animation effects based on selected case

    private func applyAnimationEffect(to content: Content) -> some View {
        let screen = UIScreen.main.bounds

        switch animation {
        // Directional entrance animations with offset, scale, and opacity
        case .fromTop:
            return AnyView(
                content
                    .offset(y: isVisible ? 0 : -40)
                    .scaleEffect(isVisible ? 1 : 0.95)
                    .opacity(isVisible ? 1 : 0)
            )
        case .fromBottom:
            return AnyView(
                content
                    .offset(y: isVisible ? 0 : 40)
                    .scaleEffect(isVisible ? 1 : 0.95)
                    .opacity(isVisible ? 1 : 0)
            )
        case .fromLeft:
            return AnyView(
                content
                    .offset(x: isVisible ? 0 : -30)
                    .scaleEffect(isVisible ? 1 : 0.95)
                    .opacity(isVisible ? 1 : 0)
            )
        case .fromRight:
            return AnyView(
                content
                    .offset(x: isVisible ? 0 : 30)
                    .scaleEffect(isVisible ? 1 : 0.95)
                    .opacity(isVisible ? 1 : 0)
            )

        // Simple fade animation
        case .fade:
            return AnyView(content.opacity(isVisible ? 1 : 0))

        // Scale from a given value to 1
        case .scale(let from):
            return AnyView(content.scaleEffect(isVisible ? 1 : from))

        // Center animation with optional fade
        case .center(let scale, let fade):
            return AnyView(
                content
                    .scaleEffect(isVisible ? 1 : scale)
                    .opacity((isVisible || !fade) ? 1 : 0)
            )

        // Slide in from specified edge (no animation applied here, can be enhanced)
        case .slide(let edge):
            return AnyView(content.offset(offset(for: edge)))

        // Combined slide and scale with fade in
        case .combined(let edge, let scale):
            return AnyView(
                content
                    .offset(offset(for: edge))
                    .scaleEffect(isVisible ? 1 : scale)
                    .opacity(isVisible ? 1 : 0)
            )

        // Custom bottom-based animations
        case .bottomBounce:
            return AnyView(content.offset(y: isVisible ? 0 : screen.height))

        case .bottomPop(let scale):
            return AnyView(
                content
                    .offset(y: isVisible ? 0 : screen.height)
                    .scaleEffect(isVisible ? 1 : scale)
            )

        case .bottomFadeRise:
            return AnyView(
                content
                    .offset(y: isVisible ? 0 : 40)
                    .opacity(isVisible ? 1 : 0)
            )

        case .bottomDrop(let bounceHeight):
            return AnyView(
                content
                    .offset(y: isVisible ? 0 : -bounceHeight)
                    .scaleEffect(isVisible ? 1 : 1.1)
            )
        }
    }

    // MARK: - Calculate offset based on edge and visibility

    private func offset(for edge: Edge) -> CGSize {
        let screen = UIScreen.main.bounds
        switch edge {
        case .top: return CGSize(width: 0, height: isVisible ? 0 : -screen.height)
        case .bottom: return CGSize(width: 0, height: isVisible ? 0 : screen.height)
        case .leading: return CGSize(width: isVisible ? 0 : -screen.width, height: 0)
        case .trailing: return CGSize(width: isVisible ? 0 : screen.width, height: 0)
        }
    }
}

// MARK: - View extension to apply appear animation easily

extension View {
    /// Applies an appearance animation to the view with specified parameters.
    func appearAnimated(
        _ animation: AppearAnimation,
        delay: Double = 0,
        duration: Double = 0.4,
        curve: Animation = .easeInOut
    ) -> some View {
        self.modifier(
            AppearAnimationModifier(
                animation: animation,
                delay: delay,
                duration: duration,
                curve: curve.speed(1 / duration)
            )
        )
    }
}

// MARK: - TouchScaleEffect: Scale view on tap with animation

struct TouchScaleEffect: ViewModifier {
    var scale: CGFloat
    var animation: Animation

    @State private var isPressed = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? scale : 1.0)
            .animation(animation, value: isPressed)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isPressed {
                            isPressed = true
                        }
                    }
                    .onEnded { _ in
                        isPressed = false
                    }
            )
    }
}

// MARK: - View extension for tap scaling effect

extension View {
    /// Adds a tap gesture that scales the view briefly.
    func onTapToScale(
        scale: CGFloat = 0.88,
        animation: Animation = .easeInOut(duration: 0.15)
    ) -> some View {
        self.modifier(TouchScaleEffect(scale: scale, animation: animation))
    }
}

// MARK: - OffsetDirection enum for flexible offset values

enum OffsetDirection {
    case up(CGFloat)
    case down(CGFloat)
    case left(CGFloat)
    case right(CGFloat)
    case custom(up: CGFloat = 0, down: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0)
}

// MARK: - View extension for applying offsets based on OffsetDirection

extension View {
    /// Applies an offset to the view based on OffsetDirection.
    func offset(_ direction: OffsetDirection) -> some View {
        switch direction {
        case .up(let distance):
            return self.offset(x: 0, y: -distance)
        case .down(let distance):
            return self.offset(x: 0, y: distance)
        case .left(let distance):
            return self.offset(x: -distance, y: 0)
        case .right(let distance):
            return self.offset(x: distance, y: 0)
        case .custom(let up, let down, let left, let right):
            let xOffset = right - left
            let yOffset = down - up
            return self.offset(x: xOffset, y: yOffset)
        }
    }
}

//
//  Header.swift
//  Playlist Manager
//
//  Created by Sajid on 11/11/24.
//

import SwiftUI

struct StretchableHeader: View {
    var image: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / 2.8 + geometry.frame(in: .global).minY : UIScreen.main.bounds.height / 2.8)
                    .clipped()
                    .offset(y: geometry.frame(in: .global).minY > 0 ? -geometry.frame(in: .global).minY : 0)
            }
        }
        .frame(height: UIScreen.main.bounds.height / 2.8)
        .allowsHitTesting(false)
    }
}

