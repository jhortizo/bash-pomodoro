import argparse
from datetime import datetime, timedelta

import matplotlib.pyplot as plt
import pandas as pd


def plot_pomodoro(file_path):
    # Load CSV
    df = pd.read_csv(file_path)
    df["init_timestamp"] = pd.to_datetime(df["init_timestamp"])
    df["end_timestamp"] = pd.to_datetime(df["end_timestamp"])

    # Filter for the last month
    last_month = datetime.now() - timedelta(days=30)
    df = df[df["init_timestamp"] >= last_month]

    # Calculate durations and group by day
    df["date"] = df["init_timestamp"].dt.date
    df["duration"] = (
        df["end_timestamp"] - df["init_timestamp"]
    ).dt.total_seconds() / 3600

    # only use pomodoros that last more than 20 minutes (working pomodoros)
    work_df = df[df["duration"] > 20 / 60]
    daily_totals = work_df.groupby("date")["duration"].sum()

    # Plot the data
    daily_totals.plot(kind="bar", figsize=(10, 6))
    plt.title("Hours Worked in Last 30 days")
    plt.xlabel("Date")
    plt.ylabel("Hours")
    plt.tight_layout()
    plt.grid(axis="y")
    plt.show()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate Pomodoro bar plot.")
    parser.add_argument("--file", required=True, help="Path to the Pomodoro CSV file.")
    args = parser.parse_args()

    plot_pomodoro(args.file)

    # plot_pomodoro("~/bin/pomodoro-counter.csv")
