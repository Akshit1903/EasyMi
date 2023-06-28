# EasyMi

- This is a Shopping App created using `Flutter` and `Firebase`, designed for hypothetical electronic store supporting the QuickMi service(defined below).
- The app integrates NFC (Near Field Communication) technology to enable users to scan products and make purchases seamlessly.
- The app provides a convenient and interactive shopping experience, allowing users to browse products, view details, add items to the cart, and open products using NFC technology.
- Firebase is utilized for secure user authentication and real-time data synchronization.
- [📦.apk](https://github.com/Akshit1903/EasyMi/app-release.apk) :For testing purposes

## Features

- QuickMi Service- NFC Scanning:
  - NFC stickers are highly available NFC-enabled hardware that can be bought at low costs in the market.
  - The app leverages NFC technology to enable product scanning. Users can tap their device against an NFC-enabled product tag to scan it, with each sticker representing a single product.
  - Scanned products are automatically loaded on the user's device, with O(1) efficiency and without human intervention.
- User Registration and Authentication:
  - Users can create an account or log in using their credentials.
  - Firebase Authentication is employed to securely manage user authentication.
- Product Listing and Details:
  - The app displays a list of available products in the electronic store.
  - Each product is accompanied by essential information such as name, price, imageURL and description.
  - Users can view detailed product information by tapping on a specific item.
- Cart Management:
  - Users can view and manage their shopping cart.
  - Products can be added, removed, or updated within the cart.
  - The total price of items in the cart is displayed for easy reference.
- Checkout:
  - Users can review the items in their cart before finalizing the transaction.
- Product management
  - This project is targetted at both the consumers as well as seller, as the product can be managed by the party who listed it.

## Pre-requisites

- NFC enabled phone
- NFC tag/stickers

## Technologies Used

- Flutter: A cross-platform UI toolkit for building natively compiled applications.
- Firebase: A comprehensive platform for developing mobile and web applications, providing various services such as authentication, database, and cloud storage.
- NFC: Near Field Communication technology for communication between devices and NFC-enabled products.

## Installation

- Clone the repository:
  ```shell
  git clone https://github.com/Akshit1903/EasyMi
  ```
- Navigate to the project directory:
  ```shell
  cd easy-mi
  ```
- Install the required dependencies:
  ```shell
  flutter pub get
  ```
- Configure a device and run the app

  ```shell
  flutter run
  ```

  Alternativly, you can download `.apk` file from <a href="./app-release.apk"> here</a> and follow the steps:

- Login with the following credentials or make a new account:
  - username- `test@mail.com`
  - password- `12345678`
- Explore the store and test regular store features.
  Special emphasis: Cart section to enter customer information and Orders screen wherein all customer orders can be seen by a salesperson.
- If grey, click the box on the top to enter NFC settings and hit back. (If still grey, press on the box again).
- Yellow box indicates successful setup of NFC, bring another NFC-enabled phone or NFC tag to test.
- If the box turns green, the tag was detected, click on the box.
- A product pops up symbolizing that NFC tag mapped to that product in a production scenario.

## Future Scope:

- Categorize products
- Payment Gateway
- Autofill customer details from db
