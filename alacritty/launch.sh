session="tmux_session"

# 检查会话是否存在
tmux has-session -t $session 2>/dev/null

if [ $? != 0 ]; then
    # 如果不存在，则创建会话
    tmux new-session -d -s $session
fi

# 连接到会话
tmux attach-session -t $session
