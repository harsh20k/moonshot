import SwiftUI

struct MissionView: View {
	struct CrewMember: Hashable {
		let role: String
		let astronaut: Astronaut
	}
	
	let mission: Mission
	let crew: [CrewMember]
	
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
					.frame(width: 200)
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
				HStack {
					ForEach(crew, id: \.self) { crewMember in
						NavigationLink(value: crewMember.astronaut) {
							HStack {
								Image(crewMember.astronaut.id)
									.resizable()
									.scaledToFit()
									.frame(width: 104, height: 72)
									.clipShape(RoundedRectangle(cornerRadius: 15))
									.overlay(
										RoundedRectangle(cornerRadius: 15.0)
											.strokeBorder(.white, lineWidth: 1)
									)
								VStack(alignment: .leading) {
									Text(crewMember.astronaut.name)
										.foregroundStyle(.white)
										.font(.headline)
									Text(crewMember.role)
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
		.navigationDestination(for: Astronaut.self) { astronaut in
			AstronautView(astronaut: astronaut)
		}
	}
}
