# PhonePe Data Extraction

This project contains scripts and data files for extracting and analyzing transaction data from PhonePe.

## Contents

- `PhonePe_Data_Extraction.ipynb`: Jupyter notebook for data extraction and analysis using PhonePe data.
- `PHONEPE-aggregated_transaction.csv`: Aggregated transaction data exported from PhonePe.
- `PhonePeSQL.sql`: SQL queries related to PhonePe data analysis.

## Usage

1. Open the Jupyter notebook `PhonePe_Data_Extraction.ipynb` to explore and analyze the PhonePe transaction data.
2. Use the provided CSV and SQL files for further data processing or database operations as needed.

## Requirements

- Python 3.x
- Jupyter Notebook
- os: Used to navigate folders and loop through the PhonePe dataset stored in multiple directories.
- json: Used to parse .json files into Python dictionaries for extracting transaction data.
- pandas: Used to convert parsed data into DataFrames for cleaning, transformation, and analysis.
- numpy: Used for numerical computations like scaling and applying dimensionality reduction techniques.
- matplotlib.pyplot: Used to create basic visualizations like bar charts and pie charts.
- seaborn: Used to create advanced statistical plots like heatmaps and pairplots for deeper insights.
- warnings: Used to suppress unwanted warning messages to keep the notebook clean and readable.

Install dependencies using:
```bash
pip install pandas numpy matplotlib seaborn jupyter
```

## License

This project is for educational and analytical purposes only. 
