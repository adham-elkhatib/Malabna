# 🏟️ Malabna – Stadium Experience Companion

A **Flutter application** that unifies **match discovery, ticket booking, and food ordering** into one **Arabic-first experience**.
Built with **layered architecture**, **Firebase services**, and **interactive maps** to **streamline stadium visits** and enhance fan engagement.

---

## 🚀 Features

### 🔐 Authentication

* Email/password and **Google Sign-In** using **Firebase Auth**

### 🏟️ Match Discovery

* Browse upcoming matches and **filter by team name** directly from the home screen
* Access **match details** or your **profile** from the top bar

### 🎟️ Ticket Booking

* Select **seat sections**, choose **individual seats**, and **reserve parking spots** during checkout

### 📱 My Tickets

* View **tickets with QR codes** and seat information
* Display **parking reservations on Google Maps** for easy navigation

### 🍔 Restaurants & Orders

* Explore **stadium restaurants** by type or search query
* Track **food orders** with detailed receipts and **progress timelines**

### 👤 Profile Management

* Update personal details
* Sign out securely

### 📱 Unified Navigation

* Bottom navigation for **Home**, **Restaurants**, **My Tickets**, and **Orders**

### 🌐 Localization

* **Right-to-left Arabic interface** with built-in localization support

### 🗺️ Parking & Maps

* **Parking zones modeled with geographic coordinates**
* Displayed via **Google Maps Flutter**

---

## 🧠 Applied Concepts & Patterns

* **Layered architecture** separating **data models, core services, and feature modules**
* **Generic Firestore repositories** for reusable CRUD operations
* **Environment configuration** with `flutter_dotenv` for dev/prod setup
* **Material 3 theming** for cohesive, modern UI styles

---

## 🧰 Tech Stack

| Layer / Feature       | Tech / Library                   |
| --------------------- | -------------------------------- |
| **Framework**         | Flutter, Material 3              |
| **Authentication**    | Firebase Auth, Google Sign-In    |
| **Database**          | Cloud Firestore                  |
| **State & Utilities** | multi\_dropdown, logger, min\_id |
| **Maps & Location**   | Google Maps Flutter              |
| **QR & Timeline**     | qr\_flutter, timelines\_plus     |
| **Localization**      | flutter\_localizations, intl     |
| **Styling**           | Google Fonts, Font Awesome       |

> *(See `pubspec.yaml` for the full dependency list)*

---

## 📸 UI Snapshots

* Match listing & details
* Seat selection & booking summary
* Ticket QR & parking map
* Restaurant explorer & order timeline

> 🖼️ Add screenshots to `/assets/images/` to preview these screens.

---

## 💡 Why Malabna?

**Malabna** elevates the stadium experience by combining **ticket booking, parking, and food services in one app**.
It demonstrates how **Flutter + Firebase** can deliver **real-time, location-aware event management** tailored for **Arabic-speaking users**.

---

## 📬 Contact

**Want to contribute or discuss improvements? Let’s connect:**

* 📧 Email: [adham.elkhatib99@gmail.com](mailto:adham.elkhatib99@gmail.com)
* 💼 LinkedIn: [Adham Mostafa](https://www.linkedin.com/in/adham-mostafa/)
* 💻 GitHub: [adham-elkhatib](https://github.com/adham-elkhatib)
