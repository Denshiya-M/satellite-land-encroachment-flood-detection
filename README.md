# 🌊 Satellite Flood Assessment & Detection

## 📌 Abstract
This project introduces an innovative approach for assessing flood damage using satellite imagery, leveraging the combined strengths of Long Short-Term Memory (LSTM) networks and VGG16 in Python. Fuzzy logic is applied to evaluate flood damage by handling uncertainties and ambiguities inherent in satellite image data. The system processes pre- and post-flood images to provide detailed damage assessments and automatically generates alerts for relevant authorities and stakeholders. This real-time alert system facilitates prompt response and decision-making in disaster management and recovery efforts.

## 🔍 How It Works
1. Input pre-flood satellite image (before flood)
2. Input post-flood satellite image (after flood)
3. VGG16 extracts spatial features from images
4. LSTM analyzes temporal flood changes
5. Fuzzy logic calculates damage assessment
6. Output: Flood affected area + automatic alert to authorities

## 🛠️ Technologies Used
- Python
- VGG16 (Pre-trained CNN for feature extraction)
- LSTM (Long Short-Term Memory Network)
- Fuzzy Logic (Damage assessment)
- GDAL & OpenCV (Geospatial analysis)
- Satellite Imagery Analysis

## 👩‍💻 Author
Denshiya M
