//
//  GraphView.swift
//  Budget Tracker
//
//  Created by Wang Po on 13/8/2023.
//
import SwiftUI

struct GraphView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedMonth = "January"
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    let income: Double = 800
    let expense: Double = 800
    var balance: Double { income - expense } // Calculating balance dynamically
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Title
                    Text("Financial Overview")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    // Month Picker
                    VStack {
                        Text("Select Month")
                            .font(.headline)
                        Picker("Select Month", selection: $selectedMonth) {
                            ForEach(months, id: \.self) { month in
                                Text(month).tag(month)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                    .padding()
                    
                    // Summary Cards
                    HStack {
                        SummaryCard(title: "Total Income", value: String(format: "$%.2f", income))
                        SummaryCard(title: "Total Expense", value: String(format: "$%.2f", expense))
                    }
                    
                    // Pie Chart Section
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                            .edgesIgnoringSafeArea(.bottom)
                            .frame(height: 400)
                        
                        ZStack {
                            PieChartView(value: income / (income + expense), color: Color.blue)
                            PieChartView(value: expense / (income + expense), color: Color.orange, startAngle: .degrees(income / (income + expense) * 360))

                            
                            
                            VStack {
                                Text("Balance")
                                    .font(.headline)
                                Text(String(format: "$%.2f", balance))
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            .frame(width: 150, height: 150) // Bigger inner circle
                            .background(Color.white)
                            .cornerRadius(75)
                        }
                        .frame(height: 300) // Bigger pie chart
                    }
                    .padding()
                }
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
            .navigationBarItems(leading: Button(action: { // Add this block
                           presentationMode.wrappedValue.dismiss()
                       }) {
                           Image(systemName: "arrow.left")
                               .foregroundColor(.white)
                       })
        }
    }
}

struct SummaryCard: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            Text(value)
                .font(.title)
                .fontWeight(.bold)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct PieChartView: View {
    var value: Double
    var color: Color
    var startAngle: Angle = .degrees(0)
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                let radius = min(geometry.size.width, geometry.size.height) / 2
                path.move(to: center)
                path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: startAngle + .degrees(value * 360), clockwise: false)
            }
            .fill(color)
        }
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}
