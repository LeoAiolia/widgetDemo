//
//  CountDownView.swift
//  SmallWidgetExtension
//
//  Created by run on 2025/2/11.
//

import SwiftUI

struct CountDownView: View {
    var title = "爱上Widget"
    var day:Int = 0
    var body: some View {
        
        VStack(alignment: .center) {
            HStack(alignment: .bottom, spacing: 0.0){
                Text("\(day)")
                    .baselineOffset(0.0)
                //                    .font(.custom("LargeDate", size: 42, relativeTo: .largeTitle))
                    .fontWeight(.bold)
                    .tracking(1.5)
                    .lineLimit(1)
                Text("DAY")
                    .baselineOffset(6.0)
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(Color("AccentColor"))
                
            }
            Text(title)
                .font(.headline)
                .foregroundColor(Color.gray)
        }
        .padding(.all)
    }
}

struct CountDownView_Previews: PreviewProvider {
    static var previews: some View {
        CountDownView()
    }
}
