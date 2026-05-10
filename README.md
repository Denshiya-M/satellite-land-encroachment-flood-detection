# 🛰️ Satellite Land Encroachment Detection

## 📌 Abstract
This project introduces an innovative approach for detecting illegal land occupation using satellite imagery, leveraging the combined strengths of Long Short-Term Memory (LSTM) networks and VGG16 in Python. VGG16, a pre-trained convolutional neural network, is used for feature extraction from satellite images, capturing spatial details necessary for accurate land classification. LSTM networks analyze temporal sequences of these features, effectively identifying dynamic changes in land use and unauthorized land occupation. The framework utilizes geospatial libraries such as GDAL and OpenCV for efficient data manipulation and analysis.

## 🔍 How It Works
1. Input pre-satellite image (before encroachment)
2. Input post-satellite image (after encroachment)
3. VGG16 extracts spatial features from images
4. LSTM analyzes temporal changes between images
5. Output: Encroached area with exact location and size

## 🛠️ Technologies Used
- Python
- VGG16 (Pre-trained CNN for feature extraction)
- LSTM (Long Short-Term Memory Network)
- GDAL & OpenCV (Geospatial analysis)
- Satellite Imagery Analysis

## 👩‍💻 Author
Denshiya M
