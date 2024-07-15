import SwiftUI

struct MissionView: View {
	struct CrewMember{
		let role: String
		let astronaut: Astronaut
	}
	
	let mission: Mission
	let crew: [CrewMember]
//	let astronauts: [String: Astronaut]
	
	init(mission: Mission, astronauts: [String: Astronaut]) {
		self.mission = mission
		
		self.crew = mission.crew.map { member in
			if let astronaut = astronauts[member.name] {
				return CrewMember(role: member.role, astronaut: astronaut)
			} else {
				fatalError("Missing \(member.name)")
			}
		}
	}
	
    var body: some View {
		ScrollView {
			VStack {
				Image(mission.image)
					.resizable()
					.scaledToFit()
					.containerRelativeFrame(.horizontal) { width, axis in
						width * 0.6
					}
				Text(mission.formattedLaunchDate)
					.font(.caption)
				CustomDivider()
				VStack(alignment: .leading) {
					Text("Mission Highlights")
						.font(.title.bold())
						.padding(.bottom)
					Text(mission.description)
				}
				.padding(.horizontal)
			}
			CustomDivider()
			ScrollView(.horizontal, showsIndicators: false) {
				HStack{
					ForEach(crew, id: \.role) { crew in
						NavigationLink {
							AstronautView(astronaut: crew.astronaut)
						} label: {
							HStack {
								Image(crew.astronaut.id)
									.resizable()
									.scaledToFit()
									.frame(width: 104, height: 72)
									.clipShape(RoundedRectangle( cornerRadius: 15))
									.overlay(
										RoundedRectangle(cornerRadius: 15.0)
											.strokeBorder(.white, lineWidth: 1)
										)
								VStack(alignment: .leading) {
									Text(crew.astronaut.name)
										.foregroundStyle(.white)
										.font(.headline)
									Text(crew.role)
										.foregroundStyle(Color.white.opacity(0.6))
								}
								.padding(.trailing)
							}
						}
					}
				}
			}
		}
		.navigationTitle(mission.displayName)
		.navigationBarTitleDisplayMode(.inline)
		.background(.darkBackground)
	}
}

#Preview {
	let missions: [Mission] = Bundle.main.decode("missions.json")
	let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
	
	return MissionView(mission: missions[0],astronauts: astronauts)
		.preferredColorScheme(.dark)
}
