# bash-pomodoro

This repository contains bash scripts to run a simple pomodoro timer and plot session data.

## Installation

Run the following commands to install everything automatically:

```bash
chmod +x install.sh
./install.sh
```

### What This Script Does
- Creates the `~/bin/` directory if it does not exist.
- Moves `pomodoro.sh` and `pomo_plot.sh` to `~/bin/`.
- Grants execution permissions to the scripts.
- Creates a Python virtual environment in `~/bin/`.
- Installs required dependencies from `requirements.txt`.
- Creates `pomodoro-counter.csv` file to store working session logs.

Run this same command to update the files if newer changes occur, this does not overwrites the logs file ✨.

## Usage

After installation, you can run the pomodoro timer and plot session data:

- **Start a Pomodoro session:** 
  - To run 25 minute working sesion
  ```bash
  pomodoro.sh -w 25
  ```
  - To run 5 minute rest session
  ```bash
  pomodoro.sh -r 5
  ```

In both cases, the system shows the time left in the terminal, and yields a fancy sound once the session finishes! Only the working sessions get logged.

- **Generate a plot of your session data:**
  ```bash
  pomo_plot.sh
  ```


## Troubleshoot and areas of improvement

This is still under construction, has not been rigorously tested, nor tested at all really 😅. So, many things can, and will, fail.

- The sound used is a native MacOs sound, so, the script breaks if run in other OS.
- The `pomodoro.sh` script uses [figlet](https://gist.github.com/LunaCodeGirl/6707775), so you would need to have it installed for the timer banner to work, else ... you know, breaks.
- All the installation process assumes you have a "suitable" python version globally available for the installation of the requirements. What you mean by "suitable"? I actually don't know... I guess a currently supported python version should work.
- The `pomodoro-counter.csv` file is only stored locally, you need to save it manually if you want to persist the lgos.

Use at your own risk ❗