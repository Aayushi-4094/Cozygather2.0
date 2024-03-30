//
//  CoHostViewModel.swift
//  cozygather2a
//
//  Created by user2batch2 on 30/03/24.
//

import SwiftUI

class CoHostsViewModel: ObservableObject {
    @Published var coHosts: [String] = []

    func addCoHost(_ coHost: String) {
        coHosts.append(coHost)
    }
}
