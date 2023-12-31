//
//  GraphView.swift
//  Budget Tracker
//
//  Created by Wang Po on 13/8/2023.
//
import SwiftUI
/// ``GraphView`` displays a financial overview in the form of graphs and summary card
///
/// Users can select specific month to view the Pie Chart

struct GraphView: View {
    @Environment(\.presentationMode) var presentationMode
   
    @EnvironmentObject var vm:TransactionViewModel
    // Data for the graph view
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

  
    var transactions:[TransactionModel] {
        return vm.monthlyTransaction
    }
    /// Calculated total income for the selected month
    var income:Double {
        return transactions.filter({ $0.isIncome }).map({$0.amount}).reduce(0, +)
    }
    /// Calculated total expense for the selected month
    var expense:Double {
        return transactions.filter({ !$0.isIncome }).map({$0.amount}).reduce(0, +)
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {

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
                        Picker("Select Month", selection: $vm.selectedMonth) {
                            ForEach(months, id: \.self) { month in
                                Text(month).tag(month)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 180,height: 60)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                    .padding()
                   
                    // Summary Cards
                    HStack {
                        SummaryCard(title: "Total Income", value: String(format: "$%.2f", income))
                            .foregroundColor(Color.black)
                        SummaryCard(title: "Total Expense", value: String(format: "$%.2f", expense))
                            .foregroundColor(Color.black)
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
                            PieChartView(value: income / (income + expense), color: Color.blueCustom)
                            PieChartView(value: expense / (income + expense), color: Color.yellowCustom, startAngle: .degrees(income / (income + expense) * 360))

                            
                            
                            VStack {
                                Text("Balance")
                                    .foregroundColor(Color.black)
                                    .font(.headline)
                                Text(String(format: "$%.2f", income - expense))
                                    .foregroundColor(Color.black)
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            .frame(width: 150, height: 150)
                            .background(Color.white)
                            .cornerRadius(75)
                            
                        }
                        .frame(height: 300) 
                    }
                    .padding()
                }

                
           

        }
            .background(LinearGradient(gradient: Gradient(colors: [Color("BeigeToDarkBlue"), Color("YellowToMidBlue")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
    }
}

/// Custom view for the Summary cards
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
/// Custom view for the Pie Chart
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
/// Preview provider for  ``GraphView``
struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            GraphView().environmentObject(TransactionViewModel())
                .preferredColorScheme(.light)
                .previewDisplayName("Light Mode")
            
            GraphView()
                .environmentObject(TransactionViewModel())
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
        }
    }
}
