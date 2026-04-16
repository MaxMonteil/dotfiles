# Full screen tmux setup for python development
tmux new-session -d -x 213 -y 56 "nvim +Explore"
tmux split-window -v -l 12
tmux split-window -h "pipenv run python -q"
tmux a
