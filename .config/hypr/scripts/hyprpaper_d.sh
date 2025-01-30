printf '%s' "$$" > /run/user/1000/hyprpaper_d.pid
trap ": > /run/user/1000/hyprpaper.lock ; : > /run/user/1000/hyprpaper_d.pid ; kill -- -$$" INT TERM QUIT KILL ABRT
hyprpaper & hyprpPID="$!"
wait "$hyprpPID"
