# MiniOS 启动说明

## 环境要求

- 操作系统建议使用 **Ubuntu 24.04**（在 Ubuntu 22.04 上可能因 `qemu` 版本过低（6.2）导致出现 Bug）
- 可在 WSL 或虚拟机中运行

## 安装依赖

### 1. 安装交叉编译工具链

```bash
sudo apt install gcc-riscv64-linux-gnu
```

### 2. 安装构建所需软件包

```bash
sudo apt install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev \
                 gawk build-essential bison flex texinfo gperf libtool patchutils bc \
                 zlib1g-dev libexpat-dev git
```

### 3. 安装 QEMU 模拟器（用于模拟 riscv64 平台）

```bash
sudo apt install qemu-system-misc
```

### 4. 启动项目

在项目根目录下执行：

```bash
make run
```

### 5. 验证启动成功

若终端最后一行显示为：

```
SHELL >
```

说明 MiniOS 内核已成功启动。
