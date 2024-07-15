import SwiftUI

struct ContentView: View {
	let astronauts:[String: Astronaut] = Bundle.main.decode("astronauts.json")
	let missions: [Mission] = Bundle.main.decode("missions.json")
	
	let columns = [
		GridItem(.adaptive(minimum: 150))
	]
	let columnsList = [
		GridItem(.flexible(minimum: 150, maximum: .infinity))
	]
	
	@State private var isShowingAsGrid = true
	
    var body: some View {
		NavigationStack{
			ScrollView {
				LazyVGrid(columns: (isShowingAsGrid ? columns : columnsList)){
					ForEach(missions) {mission in
						NavigationLink {
							MissionView(mission: mission, astronauts: astronauts)
						} label: {
							VStack{
								Image(mission.image)
									.resizable()
									.scaledToFit()
									.frame(width:100,height: 100)
									.padding(isShowingAsGrid ? 0 : 15)
								VStack{
									Text(mission.displayName)
										.font(.headline)
										.foregroundStyle(.white)
									Text(mission.formattedLaunchDate)
										.font(.caption)
										.foregroundStyle(.white.opacity(0.7))
								}
								.padding(.vertical)
								.frame(maxWidth: .infinity)
								.background(.lightBackground)
							}
							.clipShape(.rect(cornerRadius: 10))
							.overlay(RoundedRectangle(cornerRadius: 10)
								.stroke(.lightBackground))
							
						}
					}
				}
				.padding([.horizontal, .bottom])
			}
			.navigationTitle("Moonshot")
			.background(.darkBackground)
			.preferredColorScheme(.dark)
			.toolbar {
				Button("List"){
					withAnimation{
						isShowingAsGrid.toggle()
					}
				}
			}
		}
    }
}

#Preview {
    ContentView()
}

