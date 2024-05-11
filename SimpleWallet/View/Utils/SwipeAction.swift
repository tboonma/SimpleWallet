//
//  SwipeAction.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 11/5/2567 BE.
//

import SwiftUI

struct SwipeAction<Content: View>: View {
    var cornerRadius: CGFloat = 0
    var direction: SwipeDirection = .trailing
    @ViewBuilder var content: Content
    @ActionBuilder var actions: [Action]
    // View Properties
    // View Unique ID
    let viewId = UUID()
    @State private var isEnabled: Bool = true
    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    content
                        // To Take Full Available Space
                        .containerRelativeFrame(.horizontal)
//                        .background {
//                            if let firstAction = actions.first {
//                                Rectangle()
//                                    .fill(firstAction.tint)
//                            }
//                        }
                        .id(viewId)
                    ActionButtons {
                        withAnimation(.snappy) {
                            scrollProxy.scrollTo(viewId, anchor: direction == .trailing ? .topLeading : .topTrailing)
                        }
                    }
                }
                .scrollTargetLayout()
                .visualEffect { content, geometryProxy in
                    content
                }
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .clipShape(.rect(cornerRadius: cornerRadius))
        }
        .allowsHitTesting(isEnabled)
    }
    
    // Action Buttons
    @ViewBuilder
    func ActionButtons(resetPosition: @escaping () -> ()) -> some View {
        // Each Button will have 100 width
        Rectangle()
            .fill(.clear)
            .frame(width: CGFloat(actions.count) * 100)
            .overlay(alignment: direction.alignment) {
                HStack(spacing: 0) {
                    ForEach(actions) {
                        action in
                        Button(action: {
                            Task {
                                isEnabled = false
                                resetPosition()
                                try? await Task.sleep(for: .seconds(0.25))
                                action.action()
                                try? await Task.sleep(for: .seconds(0.1))
                                isEnabled = true
                            }
                        }, label: {
                            Image(systemName: action.icon)
                                .font(action.iconFont)
                                .foregroundStyle(action.iconTint)
                                .frame(width: 100)
                                .frame(maxHeight: .infinity)
                                .contentShape(.rect)
                        })
                        .buttonStyle(.plain)
                        .background(action.tint)
                    }
                }
            }
    }
    
    func scrollOffset(_ proxy: GeometryProxy) -> CGFloat {
        let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
        return direction == .trailing ? (minX > 0 ? -minX : 0) : (minX < 0 ? -minX : 0)
    }
}

// Custom Transition
struct CustomTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .mask {
                GeometryReader {
                    let size = $0.size
                    
                    Rectangle()
                        .offset(y: phase == .identity ? 0 : -size.height)
                }
                .containerRelativeFrame(.horizontal)
            }
    }
}

// Swipe Direction
enum SwipeDirection {
    case leading
    case trailing
    
    var alignment: Alignment {
        switch self {
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
}

// Action Model
struct Action: Identifiable {
    private(set) var id: UUID = .init()
    var tint: Color
    var icon: String
    var iconFont: Font = .title
    var iconTint: Color = .white
    var isEnabled: Bool = true
    var action: () -> ()
}

@resultBuilder
struct ActionBuilder {
    static func buildBlock(_ components: Action...) -> [Action] {
        return components
    }
}
