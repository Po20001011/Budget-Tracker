//
//  Budget_TrackerTests.swift
//  Budget TrackerTests
//
//  Created by Wang Po on 6/10/2023.
//

import XCTest
@testable import Budget_Tracker

final class Budget_TrackerTests: XCTestCase {

    var transactionViewModel: TransactionViewModel!
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        transactionViewModel = TransactionViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    // 1.Test fetching transactions
    // This test verifies that transactions can be fetched correctly from the database
    func testFetchingTransactions() {
        // Create multiple transactions
        
        let alreadyExist = transactionViewModel.manager.getAllTransaction()
        
        let transaction1 = transactionViewModel.manager.createTransaction(detail: "Transaction 1", amount: 50.0, isIncome: true, type: "Salary")
        let transaction2 = transactionViewModel.manager.createTransaction(detail: "Transaction 2", amount: 75.0, isIncome: false, type: "Groceries")
  
        // Fetch all transactions
        let transactions = transactionViewModel.manager.getAllTransaction()
        
        //Verify that the correct number of transactions are fetched
        XCTAssertEqual(transactions.count, alreadyExist.count + 2)
        
        //Verify that the fetched transactions match the created ones
        XCTAssertTrue(transactions.contains(transaction1))
        XCTAssertTrue(transactions.contains(transaction2))
        
    }
    // 2.Test adding a transaction
    // This test checks if a new transaction can be added successfully
     func testAddTransaction() {
         // Create a test transaction
         let detail = "Test Transaction"
         let amount: Double = 100.0
         let isIncome = true
         let type = TransactionsType.salary

         // Add the test transaction
         transactionViewModel.didAddTransaction(amountt: amount, detail: detail, isIncome: isIncome, type: type)

         // Check if the transaction exists in the view model's transactions array
         let transactions = transactionViewModel.transactions
         XCTAssertTrue(transactions.contains { $0.detail == detail && $0.amount == amount && $0.isIncome == isIncome && $0.transType == type })
     }

    // 3.Test removing a transaction
    // This test ensures that a transaction can be removed from the database
     func testRemoveTransaction() {
         // Create a test transaction
         let detail = "Test remove Transaction"
         let amount: Double = 100.0
         let isIncome = true
         let type = TransactionsType.salary

         // Add the test transaction
         transactionViewModel.didAddTransaction(amountt: amount, detail: detail, isIncome: isIncome, type: type)

         // Get the test transaction from the view model
         let transactions = transactionViewModel.transactions
         guard let testTransaction = transactions.first(where: { $0.detail == detail }) else {
             XCTFail("Test transaction not found.")
             return
         }

         // Remove the test transaction
         transactionViewModel.didRemoveTransactions(transaction: testTransaction)

         // Check if the transaction is removed from the view model's transactions array
         XCTAssertFalse(transactions.contains { $0.detail == detail })
     }
    // 4. Balance calculation
    // This test verifies that the balance is calcualted correctly
    func testBalanceCalculation() {
        // Create and add sample income and expense transactions
        transactionViewModel.manager.createTransaction(detail: "Test Income", amount: 300.0, isIncome: true, type: "Salary")
        
        
        transactionViewModel.manager.createTransaction(detail: "Test Expense", amount: 200.0, isIncome: false, type: "Groceries")
      
        transactionViewModel.manager.coreDataStack.saveContext()
        
        // Calculate the balance
        let income = transactionViewModel.transactions.filter({$0.isIncome}).map({$0.amount}).reduce(0, +)
        let expense = transactionViewModel.transactions.filter({!$0.isIncome}).map({$0.amount}).reduce(0, +)
        let total = income - expense
        let balance = transactionViewModel.currentBalance
        
        // Check if the balance calculation is correct
        XCTAssertEqual(balance, total)
    }

    // 5.Test Transaction Filtering
    // This test checks if transactions can be filtered by income and expense
    func testTransactionFiltering() {
        // Create and add sample income and expense transactions
        let date = Date()
        let incomeTransaction1 = TransactionModel(context: transactionViewModel.manager.coreDataStack.managedContext)
        incomeTransaction1.amount = 500.0
        incomeTransaction1.date = date
        incomeTransaction1.isIncome = true
        
        let expenseTransaction1 = TransactionModel(context: transactionViewModel.manager.coreDataStack.managedContext)
        expenseTransaction1.amount = 200.0
        expenseTransaction1.date = date
        expenseTransaction1.isIncome = false
        
        transactionViewModel.manager.coreDataStack.saveContext()
        
        // Filter transactions by income
        
        transactionViewModel.selectedMonth = date.toString(format: "MMMM")
        let incomeTransactions = transactionViewModel.monthlyTransaction
        XCTAssertTrue(incomeTransactions.contains { $0.isIncome })
        
        // Filter transactions by expense
        transactionViewModel.selectedMonth = date.toString(format: "MMMM")
        let expenseTransactions = transactionViewModel.monthlyTransaction
        XCTAssertTrue(expenseTransactions.contains { !$0.isIncome })
    }

    // 6. Test Search Functionality
    // This test verifies that transaction can be searched based on details
    func testSearchFunctionality() {
        // Create and add sample transactions
        let date = Date()
        transactionViewModel.manager.createTransaction(detail: "Transaction XYZ", amount: 100.0, isIncome: true, type: "Salary")
        
        transactionViewModel.manager.createTransaction(detail: "My New Expense", amount: 100.0, isIncome: false, type: "Salary")
        
        // Search for transactions containing "ABC"
        transactionViewModel.selectedMonth = date.toString(format: "MMMM")
        //transactionViewModel.searchText = "ABC"
        let filteredTransactions = transactionViewModel.monthlyTransaction
        XCTAssertTrue(filteredTransactions.contains { $0.detail?.lowercased().contains("XYZ".lowercased()) ?? false })
    }

    // 7. Test Data Persistence
    // This test checks if transactions persist after reloading the app
    func testDataPersistence() {
        // Create a test transaction
        let detail = "Test Transaction"
        let amount: Double = 100.0
        let isIncome = true
        let type = TransactionsType.salary

        // Add the test transaction
        transactionViewModel.didAddTransaction(amountt: amount, detail: detail, isIncome: isIncome, type: type)

        // Reload the view model
        transactionViewModel = TransactionViewModel()
        
        // Check if the test transaction is loaded from Core Data
        let transactions = transactionViewModel.transactions
        XCTAssertTrue(transactions.contains { $0.detail == detail && $0.amount == amount && $0.isIncome == isIncome && $0.transType == type })
    }

    // 8. Test Date Formatting
    // This test verifies that the date in transactions is formatted correctly
//    func testDateFormatting() {
//        // Create a test transaction with today's date
//        let detail = "Test Date Transaction"
//        let amount: Double = 100.0
//        let isIncome = true
//        let type = TransactionsType.salary
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd-MM-yyyy"
//        dateFormatter.locale = Locale(identifier: "en_AU")
//        dateFormatter.timeZone = TimeZone(identifier: "Australia/Sydney")
//
//        let testDate = Date()  // Using today's date
//        let testDateString = dateFormatter.string(from: testDate)  // Convert today's date to string
//
//        // Add the test transaction with today's date
//        transactionViewModel.date = testDate
//        transactionViewModel.didAddTransaction(amountt: amount, detail: detail, isIncome: isIncome, type: type)
//
//        // Check if the date is correctly formatted
//        let formattedDate = transactionViewModel.transactions.first!.formattedDate
//        print("Formatted Date in Test: \(formattedDate)")  // Debugging line
//
//        XCTAssertEqual(formattedDate, "10/9/23")
//    }




    
    // Test 8: Grouping Transactions by Month
    // Check if transactions are grouped correctly by month
    func testGroupingTransactionsByMonth() {
        // Create a new CoreDataManager instance
        testRemoveAllTransactions()
        let coreDataManager = transactionViewModel.manager

        // Clean up any existing transactions (optional, if you want a clean slate)
        let existingTransactions = coreDataManager.getAllTransaction()
        existingTransactions.forEach { coreDataManager.removeTransaction(tran: $0) }

        // Create transactions for different months
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Transaction 1 - January 2023
        let transaction1 = coreDataManager.createTransaction(detail: "Transaction 1", amount: 50.0, isIncome: true, type: "Salary")
        transaction1.date = dateFormatter.date(from: "2023-01-15")

        // Transaction 2 - February 2023
        let transaction2 = coreDataManager.createTransaction(detail: "Transaction 2", amount: 75.0, isIncome: false, type: "Groceries")
        transaction2.date = dateFormatter.date(from: "2023-02-20")

        // Transaction 3 - March 2023
        let transaction3 = coreDataManager.createTransaction(detail: "Transaction 3", amount: 30.0, isIncome: true, type: "Salary")
        transaction3.date = dateFormatter.date(from: "2023-03-10")

        // Transaction 4 - February 2022
        let transaction4 = coreDataManager.createTransaction(detail: "Transaction 4", amount: 60.0, isIncome: false, type: "Groceries")
        transaction4.date = dateFormatter.date(from: "2023-02-05")

        // Group transactions by month
        let groupedTransactions = coreDataManager.groupTransactionsByMonth()

        // Verify that the grouped transactions are correct based on your data
        // For example, you can check if transactions for different months are in the correct groups
        XCTAssertEqual(groupedTransactions.count, 3) // There should be 3 distinct months

        // Check if transactions are correctly grouped by month and year
        XCTAssertNotNil(groupedTransactions["January 2023"])
        XCTAssertNotNil(groupedTransactions["February 2023"])
        XCTAssertNotNil(groupedTransactions["March 2023"])

        // Verify the count of transactions in each group
        XCTAssertEqual(groupedTransactions["January 2023"]?.count, 1)
        XCTAssertEqual(groupedTransactions["February 2023"]?.count, 2)
        XCTAssertEqual(groupedTransactions["March 2023"]?.count, 1)
        
        // Verify that the transactions are correctly placed in the respective groups
        XCTAssertTrue(groupedTransactions["January 2023"]?.contains(transaction1) ?? false)
        XCTAssertTrue(groupedTransactions["February 2023"]?.contains(transaction2) ?? false)
        XCTAssertTrue(groupedTransactions["March 2023"]?.contains(transaction3) ?? false)

        // Ensure that there are no transactions for months that don't exist in the data
        XCTAssertNil(groupedTransactions["February 2022"])
    }

    // Test 9: Remove Non-Existent Transaction
    // Ensure that attempting to remove a non-existent transaction doesn't affect the database
    func testRemoveNonExistentTransaction() {
        // Get the initial count of transactions
        let initialTransactionCount = transactionViewModel.manager.getAllTransaction().count
        
        // Attempt to remove a transaction that doesn't exist
        let nonExistentTransaction = TransactionModel(context: transactionViewModel.manager.coreDataStack.managedContext)
        transactionViewModel.manager.removeTransaction(tran: nonExistentTransaction)
        
        // Verify that the transaction count hasn't changed
        let currentTransactionCount = transactionViewModel.manager.getAllTransaction().count
        XCTAssertEqual(currentTransactionCount, initialTransactionCount)
    }

    // Test 10: Remove All transactions
    func testRemoveAllTransactions() {
        // Create a new CoreDataManager instance for a clean slate
        let coreDataManager = transactionViewModel.manager
        // Remove all transactions
        let allTransactions = coreDataManager.getAllTransaction()
        allTransactions.forEach { coreDataManager.removeTransaction(tran: $0) }
        
        // Verify that all transactions are removed
        XCTAssertEqual(coreDataManager.getAllTransaction().count, 0)
    }


}




