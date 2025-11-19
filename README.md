<h1 align="center">My Portfolio App (UIKit)</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-iOS-blue?style=flat-square">
  <img src="https://img.shields.io/badge/UI-UIKit-red?style=flat-square">
  <img src="https://img.shields.io/badge/Language-Swift-orange?style=flat-square">
  <img src="https://img.shields.io/badge/Status-In%20Development-brightgreen?style=flat-square">
</p>

<p align="center">
  <strong>A clean and modern iOS portfolio application built using UIKit and Swift.</strong><br>
  This project demonstrates my architectural skills, UI development experience, code style, and ability to build structured, scalable applications.
</p>

---

## 📸 Demo

### 🎥 **App Preview (Animated)**

> A quick look at the overall experience of **My Portfolio App**.

<p align="center">
  <img width="320" src="https://github.com/user-attachments/assets/d6033334-8b85-46fe-b0e1-137c53da35ce" />
</p>

---

### 🖼️ **Screenshots**

> Clean, modern, and minimal UIKit-based interface.

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/fb09f53f-b1cd-4f35-bf00-126488f3f562" />
  <img width="250" src="https://github.com/user-attachments/assets/b30577fa-559d-4ba8-bfcb-47a6ebf61590" />
  <img width="250" src="https://github.com/user-attachments/assets/7bc47ad5-480c-42b1-892c-a571ceac526f" />
</p>

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/0ff4fc1b-ea85-4f8a-8cc6-439676c7fb6e" />
  <img width="250" src="https://github.com/user-attachments/assets/4c1e3a9e-1dc6-4dbd-93fc-b63e1418e9ae" />
</p>

---

## 🚀 About the Project

**My Portfolio App** is an iOS application created to present my development skills, showcase my projects, and demonstrate my proficiency in UIKit-based UI development.

The main idea behind this project is to provide a visually clean and technically well-structured example of my iOS engineering abilities, suitable for job applications and technical interviews.

The application includes:

* Personal profile section
* Projects list / portfolio view
* Clean UIKit-based interface
* Resource management using SwiftGen
* Modular and structured code

---

## 🛠️ Technologies Used

<p align="center">
  <a href="https://backendless.com/" target="_blank">
    <img src="https://backendless.com/wp-content/themes/backendless/assets/images/logos/logo.svg" width="60%" />
  </a>
</p>

### **Backend**

This project uses **Backendless** as a backend platform, primarily for:

* Cloud data storage
* Real-time data access
* API services

> Note: **No authentication is used**, because this is a demonstration application.

---

## 🔌 How Backendless Integrates with the App

### **Why Backendless?****

Backendless was chosen because it provides:

* ⚡ Fast and simple cloud data hosting
* 📡 Ready-to-use real-time database features
* 📦 Easy integration with REST API
* 🚀 No need to manage backend infrastructure

### **Example Request:**

```swift
func fetchIntroData() {
    isLoadingSubject.send(true)
    introNetworkingService.getIntroInfo()
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            guard case let .failure(error) = completion else {
                return
            }
            self?.isLoadingSubject.send(false)
            self?.errorSubject.send(error)
        } receiveValue: { [weak self] response in
            self?.isLoadingSubject.send(false)
            self?.dataDidFetch(response)
        }
        .store(in: &cancellables)
}
```

## 📂 Project Structure

```text
MyPortfolioApp/
│
├── Application/
│   ├── Configuration/
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   └── AppContainer.swift
│
├── BusinessLogic/
│   ├── Coordinators/
│   ├── Services/
│   └── Models/
│
├── Core/
│   ├── Networking/
│   │   ├── NetworkManager/
│   │   ├── NetworkPlugin/
│   │   ├── NetworkLogger/
│   │   ├── EndpointBuilder/
│   │   ├── NetworkError/
│   │   └── NetworkProvider/
│   ├── Views/
│   ├── Base/
│   ├── Extensions/
│   └── Helpers/
│
├── Presentation/
│   ├── LaunchFlow/
│   └── MainFlow/
│
├── Resources/
│   ├── Generated/
│   ├── Fonts/
│   ├── Info.plist
│   ├── Assets.xcassets
│   ├── Colors.xcassets
│   └── Localizable.strings
│
├── swiftgen.yml
└── README.md
```

````

Adjust folders based on your real structure.

---

## 🔧 Setup & Installation

### 1. Clone the repository

```bash
git clone https://github.com/VasylVertiporokh/MyPortfolioAppUIKit.git
cd MyPortfolioAppUIKit
````

### 2. Install dependencies (if needed)

If you are using CocoaPods, SwiftPM or other tools — describe them here.

### 3. Open project in Xcode

```bash
open MyPortfolioApp.xcodeproj
```

### 4. Build & Run

Select your simulator or device and press:

```
⌘ + R
```

---

## ▶️ Features

* Clean and minimalistic UIKit UI
* Personal information & portfolio presentation
* Smooth navigation between sections
* Organized and maintainable architecture
* Generated asset access using SwiftGen
* Expandable modules and UI components

---

## 🧱 Planned Improvements

### 📌 Upcoming SwiftUI Version

A fully redesigned version of the app will be developed using **SwiftUI**, featuring:

* **MVVM architecture**
* **async/await** for modern asynchronous networking
* **Observable & @Published** bindings
* Completely declarative UI
* Smooth transitions and animations

### 📌 UIKit Version Enhancements

* Add animations and transitions
* Add dark/light mode support
* Add project filtering
* Add CV export (PDF generation)
* Add integration with GitHub API (auto-loading real projects)
* Add ability to **download and open my CV directly inside the app** for quick access on mobile devices (auto-loading real projects)

---

## 🤝 Contributing

As this project is part of my portfolio, external contributions are not required —
but suggestions and improvements are welcome.

---

## 📄 License

This project is released under the **MIT License**.

---

## 👤 Author

**Vasyl Vertiporokh**

* GitHub: [https://github.com/VasylVertiporokh](https://github.com/VasylVertiporokh)
* LinkedIn: [https://www.linkedin.com/in/vasil-vertyporokh-06b1a121a](https://www.linkedin.com/in/vasil-vertyporokh-06b1a121a)
* Email: [vasylvertyporokh@gmail.com](mailto:vasylvertyporokh@gmail.com)
