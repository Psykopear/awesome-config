-- Default programs
terminal = "st"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
browser = "google-chrome-stable"
