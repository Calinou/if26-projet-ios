import SwiftUI

struct SettingsDiscreetMode: View {

    // FIXME: The setting isn't restored when switching back and forth the view.
    // When switching to the view, it's always initialized to the value
    // that was defined when the application started.
    @State private var _enabled = UserDefaults.standard.bool(forKey: "discreetMode")

    var body: some View {
        let enabled = Binding(
            get: {
                self._enabled
            },
            set: {
                self._enabled = $0
                // Save the new value to the user preferences
                UserDefaults.standard.set($0, forKey: "discreetMode")
            }
        )

        return VStack {
            Toggle(isOn: enabled) {
                Text("Mode discret")
            }.padding(.bottom, 16)

            Text("""
                Lorsque le mode discret est activé, les montants des transactions seront cachés.

                Cela vous permet d'utiliser l'application en toute sérénité dans des lieux publics, par exemple.
                """).foregroundColor(.gray)

            HStack {
                Text("Aperçu")
                    .fontWeight(.bold)
                    .frame(width: 90)
                Text(enabled.wrappedValue ? "+##,## €" : "+12,34 €")
                    .frame(width: 90)
                    .foregroundColor(.blue)
            }
            .padding(.top, 36)

            Spacer()
        }
        .padding()
        .navigationBarTitle("Mode discret", displayMode: .inline)
    }
}

struct SettingsDiscreetMode_Previews: PreviewProvider {

    static var previews: some View {
        SettingsDiscreetMode()
    }
}
