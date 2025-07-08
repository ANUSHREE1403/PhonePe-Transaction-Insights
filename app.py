import streamlit as st
import pandas as pd

# Page configuration
st.set_page_config(page_title="PhonePe Transaction Insights", layout="wide")

# Sidebar
st.sidebar.title("📌 Filters")
st.sidebar.info("Use the filters below to explore the data.")

# Load Data
@st.cache_data
def load_data():
    df = pd.read_csv(r"C:\Users\anush\Downloads\PhonePe\data\PHONEPE-aggregated_transaction.csv")
    return df

data = load_data()

# Sidebar Filters
st.write(" Column Names:", data.columns.tolist())  # Optional: For debugging, can be removed later

years = data['year'].unique()
states = data['state'].unique()

selected_year = st.sidebar.selectbox("Select Year", sorted(years))
selected_state = st.sidebar.selectbox("Select State", sorted(states))

filtered_data = data[(data['year'] == selected_year) & (data['state'] == selected_state)]

# Title
st.title("PhonePe Transaction Insights Dashboard")
st.markdown("Welcome to the interactive dashboard for PhonePe transaction insights. Explore transaction trends, user behavior, and regional statistics using this simple UI.")

# Metrics
col1, col2, col3 = st.columns(3)
col1.metric("Total Transactions", f"{filtered_data['transaction_count'].sum():,}")
col2.metric("Total Amount", f"₹{filtered_data['transaction_amount'].sum():,.2f}")
col3.metric("Data Points", len(filtered_data))

# Charts
st.subheader("Transaction Trend Over Time")
if 'quarter' in filtered_data.columns:
    st.line_chart(filtered_data.groupby('quarter')['transaction_count'].sum())
else:
    st.warning(" 'quarter' column not found in data.")

# Data Preview
st.markdown("---")
st.subheader("🔍 Data Preview")
st.dataframe(filtered_data.head(20))