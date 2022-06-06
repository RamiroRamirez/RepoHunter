//
//  BranchesView.swift
//  RepoHunter
//
//  Created by Ramirez-Hernandez, Ramiro on 06.06.22.
//

import SwiftUI

struct BranchesView: View {
    
    @StateObject var viewModel: BranchesViewModel
    
    var body: some View {
        List(
            viewModel.branches,
            id: \.self,
            rowContent: row
        )
        .listStyle(.grouped)
        .navigationTitle("Branches")
    }
    
    private func row(for branch: Branch) -> some View {
        Text(branch.name)
    }
}

struct BranchesView_Previews: PreviewProvider {
    static var previews: some View {
        BranchesView(viewModel: BranchesViewModel(branches: []))
    }
}
