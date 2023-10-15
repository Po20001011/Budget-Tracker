//
//  AppPopView.swift
//  Budget Tracker
//
//  Created by Wang Po on 6/10/2023.
//


import SwiftUI
/// ``AppPopView`` is a SwiftUI View that displays a popup message when a transaction is submitted.
/// 
///  This view is intended to provide visual feedback to the user after they have successfully submitted a transaction.
///
///   The popup will automatically dismiss after 1.5 seconds.


struct AppPopView: View {
    /// Controls whether the popup is shown
    /// - Note: This is a two-way binding
    @Binding var isShowingPopup: Bool
    
    /// The body of the `AppPopView`
    var body: some View {
        ZStack {

            if isShowingPopup {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        // Dismiss the popup when tapped
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isShowingPopup = true
                        }
                    }
                
                VStack {
                    Spacer()
                    
                    // When use add income/expense showing transaction submitted
                    VStack {
                        Image(systemName: "checkmark.circle.fill") 
                            .font(.system(size: 30))
                            .foregroundColor(.green)
                        
                        Text("Transaction Submitted")
                            .font(.subheadline)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    
                    Spacer()
                }
                .background(Color.clear)
                .transition(.move(edge: .bottom))
                
                
                .onAppear {
                    // Show the popup when the view appears
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isShowingPopup = true
                    }
                    
                    // Automatically hide the popup after 2 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isShowingPopup = false
                        }
                    }
                }
            }
        }
    }
}





