# 💻 Laptop Price Analysis Dashboard

## 📌 About This Project

This project focuses on understanding how different laptop features affect their prices.
The dataset contains details like brand, RAM, CPU, GPU, storage type, screen resolution, and price.

The main goal of this project was to:

* Clean and prepare raw data using SQL
* Analyze relationships between different features
* Build an interactive dashboard using Power BI to present insights

This is an **end-to-end data analysis project**, starting from raw data to final visualization.

---

## 🛠 Tools & Technologies Used

* **SQL** → Used for data cleaning, transformation, and feature creation
* **Power BI** → Used to build an interactive dashboard
* **CSV Dataset** → Raw data source

---

## 🔄 Project Workflow

### 🔹 1. Data Cleaning (SQL)

The dataset had many issues like missing values, inconsistent formats, and mixed data types.

I performed the following steps:

* Removed rows with missing or invalid values
* Cleaned columns like RAM, Weight, and Price
* Standardized categorical values (Operating System, Memory type, etc.)
* Converted text data into proper numeric formats

---

### 🔹 2. Data Transformation & Feature Engineering

To make the data more useful, I created new features:

* **PPI (Pixels Per Inch)** → to measure screen quality
* **Screen Size Category** → small, medium, large
* **Storage Type** → SSD, HDD, Hybrid, Flash
* Extracted **CPU brand and GPU brand** from raw text

This step helped in making better comparisons and analysis.

---

### 🔹 3. Exploratory Data Analysis (EDA)

I explored the dataset to understand patterns such as:

* Price distribution of laptops
* Differences between brands
* Effect of hardware specifications on price
* Detection of outliers

---

### 🔹 4. Dashboard Development (Power BI)

I built an interactive dashboard to visualize insights clearly.

The dashboard includes:

* 📊 **KPI Cards**

  * Average Price
  * Maximum Price
  * Minimum Price
  * Total Number of Laptops

* 📈 **Visualizations**

  * Average price by brand
  * Storage type vs price comparison
  * GPU brand impact on pricing
  * Display quality (PPI) vs price (scatter plot with trend line)
  * Weight comparison across brands
  * Touchscreen vs price

* 🎛 **Interactive Filters**

  * Company
  * Operating System
  * CPU Brand
  * GPU Brand

---

## 📊 Key Insights (Simple & Clear)

* 💰 Most laptops fall in the **₹40K – ₹80K range**, showing this is the most common price segment

* 🎮 Laptops with **Nvidia GPUs have the highest average price (~₹79K)**, making them significantly more expensive than AMD and Intel

* 💾 **Storage type has a big impact on price**

  * Hybrid & SSD → Expensive
  * HDD → More affordable

* 📺 There is a **slight increase in price with higher screen quality (PPI)**, but it is not the only factor

* 🏢 Some brands like **Razer and LG are premium**, while others like Acer and Asus are more budget-friendly

* 📱 Touchscreen laptops are slightly more expensive but not a major factor

---

## 📷 Dashboard Preview

<img width="1527" height="854" alt="Screenshot (257)" src="https://github.com/user-attachments/assets/19c4cf18-48e2-4c89-b914-2feda4caa5b9" />


---

## 🚀 How to Use This Project

1. Download the `.pbix` file
2. Open it in Power BI Desktop
3. Use the filters to explore different insights
4. Interact with charts to understand relationships

---


## ⭐ Conclusion

This project shows how raw data can be transformed into meaningful insights using data analysis techniques.

It covers:

* Data cleaning using SQL
* Feature engineering
* Data exploration
* Dashboard creation

This project helped me understand how different factors like hardware and brand influence laptop pricing.



