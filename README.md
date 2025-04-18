# MiniOS 项目  

## 说明
- 本项目基于浙江大学24年秋冬操作实验进行，实现满足最基本功能的OS kernel
```
https://zju-sec.github.io/os24fall-stu/
```

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

用户可以输入：
```
echo "hello world!"   
```
然后按回车键，如果屏幕正确显示：
```
hello world! 
```
说明最基本的输入输出交互功能没有问题，MiniOS成功启动
