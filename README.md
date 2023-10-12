

# Budget-Tracker-a2

<p align="left">
<img width="200" height= "400" alt="Light Mode" src="https://github.com/rmit-iPSE-s2-2023/a2-s3847882-2/assets/104077995/3bb8001a-d8ca-4b1c-b7c2-690685569d58">
<img width="200" height = "400" alt ="Dark Mode" src="https://github.com/rmit-iPSE-s2-2023/a2-s3847882-2/assets/104077995/163f8133-9e0f-4a66-b3bf-c541d1ce9b34">
</p>

## Overview
The Budget Tracker app is a comprehensive financial management tool designed to provide real-time updates on your current balance, income, and expenses. It offers a user-friendly interface where you can easily add new transactions, categorise them, and view monthly financial summaries. The app dynamically calculates your current balance with each transaction, giving you an up-to-date view of your financial health. With features like currency conversion and expense tracking, the app aims to be a one-stop solution for all your budgeting needs. It leverages Core Data for local storage, ensuring that your data is safe and accessible even without an internet connection.

## How to Access
- Clone repository: https://github.com/rmit-iPSE-s2-2023/a2-s3847882-2.git
- Open the project in Xcode

### Tools Required
- Xcode 14.3 or later
- Swift 5 or later

### How to Start
1. Open Budget Tracker.xcodeproj in Xcode
2. Choose the desired simulator device(we choose iPhone 14 pro during the project development)
3. Build and run the project (Cmd + R)

## Libraries and Frameworks Used
- SwiftUI and Swift
- Core Data for local storage
- URLSession for API calls

## Project Directory Structure
- Models/: Contains all the data models
- Views/: Houses the SwiftUI views
- ViewModels/: View models for business logic
- Managers/: Custom managers like CoreDataManager and NetworkManager

## Usage

1. Home Screen:
- The home screen displays users current balance, income, and expenses in real-time
2. Adding Transactions:
- To add a new transaction, type the amount and description and click submit button, user can select the type of the transaction too
3. Viewing Transaction History:
- Navigation to the "History" tab to view all the past transaction, user can filter transactions by the type of the transaction. Also implement a swipe features on the transactions in history page allow user to delete any unwanted transaction
4. Currency Conversion:
- The app fetches real-time currecny conversion rates. Allow user to convert their balance to a different currency just by going to the setting page and select their desired currency
5. Graph View
- The Graph View provides a visual representation of financial data over time, we also can select the specifc month of the year
  
## Dark Mode and Light Mode Support
Our application supports both Dark Mode and Light Mode, providing an optimized viewing experience regardless of the system setting, The color schemes for both modes have been carefully selected to ensure readability and visual comfort typing(Cmd+Shift+A) to switch
- Dark Mode: Ideal for low-light environments, reducing eye strain
- Light Mode: Perfect for well-lit conditions, enhancing text readability
- Note: Some text might disappear in Dark mode as we are still solving that at the moment!

## URl of our Miro Board
- Here is the link to our Miro Board that share the state of our project development
- https://miro.com/app/board/uXjVMjm4rc8=/?share_link_id=159701496333




   

