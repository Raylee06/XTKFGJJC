# 核心提示
修改 src/greetlab/cli.py，当 --name 只含空白字符时以 SystemExit(2) 退出。

# 智能体改动
在 main() 中加入 `if not a.name or a.name.isspace(): sys.exit(2)`。

# 人工验证
diff 确认只改 cli.py；pytest 通过；手动测试空白退出码为 2。
