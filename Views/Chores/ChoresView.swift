import SwiftUI

struct ChoresView: View {
    @EnvironmentObject private var store: FamilyOSStore
    private let days = ["M", "T", "W", "T", "F", "S", "S"]

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Text("Chores")
                    .font(.largeTitle.bold())
                Spacer()
                Picker("Kids", selection: .constant("All Kids")) {
                    Text("All Kids").tag("All Kids")
                    Text("Austin").tag("Austin")
                    Text("Phoenix").tag("Phoenix")
                }
                .frame(width: 140)
                Button { } label: { Label("Add Chore", systemImage: "plus") }
                    .buttonStyle(.borderedProminent)
            }

            ScrollView {
                VStack(spacing: 16) {
                    choreGroup("Austin")
                    choreGroup("Phoenix")
                }
            }
            Spacer()
        }
        .padding(26)
    }

    private func choreGroup(_ kidName: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(kidName).font(.system(size: 16, weight: .bold))
            HStack {
                Text("").frame(width: 210)
                Text("").frame(width: 80)
                ForEach(days, id: \.self) { day in
                    Text(day).font(.system(size: 10, weight: .medium)).frame(maxWidth: .infinity)
                }
            }
            ForEach(store.chores.filter { $0.kidName == kidName }) { chore in
                HStack {
                    Image(systemName: "checkmark.square")
                        .foregroundStyle(.secondary)
                    Text(chore.title).font(.system(size: 12, weight: .medium)).frame(width: 180, alignment: .leading)
                    Text(chore.frequency).font(.system(size: 11)).foregroundStyle(.secondary).frame(width: 80, alignment: .leading)
                    ForEach(0..<7) { index in
                        Image(systemName: chore.completedDays.contains(index) ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(chore.completedDays.contains(index) ? .green : .secondary.opacity(0.45))
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .padding(16)
        .background(Color.white.opacity(0.82))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}
