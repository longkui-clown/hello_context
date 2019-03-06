ps -aux | grep mix | grep erl | awk '{print $2}' | xargs  kill -9
