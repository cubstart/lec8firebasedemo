//
//  testDBView.swift
//  lec8demo
//
//  Created by Andy Huang on 10/30/23.
//

import SwiftUI

struct testDBView: View {
    @StateObject var dbViewModel: DBViewModel = DBViewModel()

    var body: some View {
        Button("Add user info") {
            dbViewModel.addUser(user: User(firstName: "Andy", lastName: "Huang", age: 21, graduated: false))
        }
        .padding()
        
        Button("Get all user info") {
            dbViewModel.getAllUsers()
        }
        
        List {
            ForEach(dbViewModel.usersList, id:\.firstName) { user in
                Text("\(user.firstName), \(user.age)")
            }
        }
    }
}

#Preview {
    testDBView()
}
