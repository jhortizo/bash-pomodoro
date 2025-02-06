#!/bin/bash

INSTALL_DIR="$HOME/bin"
VENV_DIR="$INSTALL_DIR/pomo-env"

echo "Creating $INSTALL_DIR if it doesn't exist..."
mkdir -p "$INSTALL_DIR"

echo "Moving scripts to $INSTALL_DIR..."
cp pomodoro.sh pomo_plot.sh pomo_plot.py "$INSTALL_DIR/"

echo "Setting execution permissions..."
chmod +x "$INSTALL_DIR/pomodoro.sh"
chmod +x "$INSTALL_DIR/pomo_plot.sh"

echo "Creating virtual environment in $VENV_DIR..."
python3 -m venv "$VENV_DIR" # TODO: breaks if no "proper" python3 version installed, or no venv

echo "Installing dependencies..."
source "$VENV_DIR/bin/activate"
pip install -r requirements.txt

echo "Creating pomodoro-counter.csv file..."
echo "init_timestamp,end_timestamp" > "$INSTALL_DIR/pomodoro-counter.csv"

echo "Installation complete! You can now run your Pomodoro scripts."