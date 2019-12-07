//
//  Settings.swift
//  Projet IF26
//
//  Created by Hugo Locurcio on 07/12/2019.
//  Copyright © 2019 UTT. All rights reserved.
//

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
