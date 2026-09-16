import torch
from torch import nn

torch.manual_seed(20260907)

x = torch.linspace(-1, 1, 101).reshape(-1, 1)
y = 3 * x - 1

model = nn.Linear(1, 1)
loss_fn = nn.MSELoss()
opt = torch.optim.SGD(model.parameters(), lr=0.1)

for _ in range(200):
    pred = model(x)
    loss = loss_fn(pred, y)

    # TODO: 清空梯度、反向传播、更新参数
    opt.zero_grad()
    loss.backward()
    opt.step()

# TODO: 进入评估模式并在 no_grad 中打印最终损失、weight 和 bias
model.eval()
with torch.no_grad():
    final_pred = model(x)
    final_loss = loss_fn(final_pred, y)
    print(f"Final loss: {final_loss.item():.6f}")
    print(f"Weight: {model.weight.item():.6f}")
    print(f"Bias: {model.bias.item():.6f}")
