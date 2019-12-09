import SwiftUI

struct SettingsAbout: View {

    var body: some View {
        VStack {
            Text("""
                MonArgent 1.0.0

                Développé par Hugo Locurcio et Antoine Chabin
                dans le cadre de l'UE IF26.
                """)

            Button("Code source sur GitHub") {
                if let url = URL(string: "https://github.com/Calinou/if26-projet-ios") {
                    UIApplication.shared.open(url)
                }
            }
            .padding(.vertical, 20)

            Spacer()
        }
        .padding()
        .navigationBarTitle("À propos de l'application", displayMode: .inline)
    }
}

struct SettingsAbout_Previews: PreviewProvider {

    static var previews: some View {
        SettingsAbout()
    }
}
