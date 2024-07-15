import SwiftUI

struct CustomDivider: View {
	enum Direction {
		case horizontal, vertical
	}
	
	var direction: Direction = .horizontal
	var color: Color = .blue
	
	@State private var isScaled = false
	
	var body: some View {
		GeometryReader { geometry in
			if direction == .horizontal {
				HStack {
					Spacer()
					Rectangle()
						.fill(colorGradient)
						.frame(width: geometry.size.width * 0.7, height: 2)
						.scaleEffect(isScaled ? 1 : 0, anchor: .center)
						.animation(.easeInOut(duration: 1), value: isScaled)
						.onAppear { isScaled = true }
					Spacer()
				}
			} else {
				VStack {
					Spacer()
					Rectangle()
						.fill(colorGradient)
						.frame(width: 2, height: geometry.size.height * 0.7)
						.scaleEffect(isScaled ? 1 : 0, anchor: .center)
						.animation(.easeInOut(duration: 1), value: isScaled)
						.onAppear { isScaled = true }
					Spacer()
				}
			}
		}
	}
	
	private var colorGradient: LinearGradient {
		LinearGradient(
			gradient: Gradient(colors: [Color.clear, color, Color.clear]),
			startPoint: direction == .horizontal ? .leading : .top,
			endPoint: direction == .horizontal ? .trailing : .bottom
		)
	}
}

#Preview {
    CustomDivider()
}
