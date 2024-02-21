# cd "$(dirname "$1")"

# # 打开 tmux
# tmux new-session -d -s nvim_session

# # 分割屏幕，上下两部分
# tmux split-window -v
# tmux split-window -h

# # 进入 nvim 区域
# tmux select-pane -t 1
# tmux send-keys "nvim $1" C-m

# # 切换到下方区域的第一个窗格
# tmux select-pane -t 2
# tmux attach-session -t nvim_session

# 打开 tmux
session="nvim_session"

# 检查会话是否存在
tmux has-session -t $session 2>/dev/null

if [ $? != 0 ]; then
    # 如果不存在，则创建会话
    echo "Creating session $session ..."
    tmux new-session -d -s $session

    # 分割屏幕，上下两部分
    tmux split-window -v
    tmux split-window -h
    # 进入 nvim 区域
    tmux select-pane -t 0
    tmux send-keys "nvim $1" C-m
    # nvim
fi

# 连接到会话
tmux attach-session -t $session
# tmux send-keys "nvim $1" C-m

# # 切换到下方区域的第一个窗格
# tmux select-pane -t 2

