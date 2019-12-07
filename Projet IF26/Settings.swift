import SwiftUI

struct Settings: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: SettingsDiscreetMode()) {
                    Text("Mode discret")
                }
            }
            .navigationBarTitle("Paramètres", displayMode: .inline)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
