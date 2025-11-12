struct MainPitchView: View {
    @EnvironmentObject var viewModel: PitchRecognizerViewModel

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Circle()
                    .strokeBorder(lineWidth: viewModel.isListening ? 6 : 3)
                    .foregroundStyle(viewModel.isListening ? .green : .gray)
                    .frame(width: 140, height: 140)
                    .animation(.easeInOut(duration: 0.2), value: viewModel.isListening)

                VStack(spacing: 4) {
                    Text(viewModel.currentNote)
                        .font(.system(size: 40, weight: .bold, design: .rounded))

                    Text(viewModel.isListening ? "Listening…" : "Tap to start")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .contentShape(Circle())
            .onTapGesture {
                viewModel.toggleListening()
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Pitch")
        .toolbar {
            ToolbarItem(placement: .topTrailing) {
                NavigationLink {
                    SettingsView()
                } label {
                    Image(systemName: "gearshape")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MainPitchView()
            .environmentObject(PitchRecognizerViewModel())
    }
}
