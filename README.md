# 操作系统导论(Operating Systems: Three Easy Pieces / OSTEP)中文翻译重制版


有劳各大国企出版社让我第4次觉得中文比英文难懂，前几次是伟大的机械工业出版社，其对原版一字一句都对应的、牢牢抓住英文语法精髓的翻译让我看的啧啧称奇。看到内容精彩绝伦的原版被翻译的狗屁不通实在可惜，于是决定由ai翻译，自己校对，目前看来质量显然比官方那个百度一键翻译高不少, 至少你不会再看到时间状语从句横行了，例如：

```
# 原版
编译器完成剩下的事情，确保在你进入 func() 函数的时候，在栈上开辟空间。

# 重制版
剩下的事由编译器完成：你调用 func() 时，它会确保在栈上腾出空间
```

```
# 原版
为了确保操作系统这样做，我们需要一些目标来指导。

# 重制版
为了确保操作系统做到这一点，我们需要一些目标来指引方向
```

```
# 原版
如果需要管理的空间被划分为固定大小的单元，就很容易。在这种情况下，只需要维护这些大小固定的单元的列表，如果有请求，就返回列表中的第一项。

# 重制版
如果你管理的空间被划分成固定大小的单元，事情就很简单：只要用一个列表记下这些固定大小的单元；客户端请求一个单元时，返回列表的第一项即可。
```
以上只是一些小小的中文震撼，其实整本书都可以这么对比，我不知道作者的中文语法学自哪个星球，至少并非是我熟知的。

<!-- progress:start -->

## 翻译进度

![已翻译](https://img.shields.io/badge/%E5%B7%B2%E7%BF%BB%E8%AF%91-60%2F68-blue) ![已校对](https://img.shields.io/badge/%E5%B7%B2%E6%A0%A1%E5%AF%B9-44%2F68-brightgreen)

⬜ 未开始 · 🟨 翻译中 · 🟦 已翻译，待校对 · 🟩 已校对（三轮）

### 简介

| | 章节 | 状态 |
|---|---|---|
| 00 | dedication | 🟨 翻译中 |
| 00 | preface | 🟨 翻译中 |
| 00 | toc | ⬜ 未开始 |
| 01 | [关于本书的对话](pdf/0-%E7%AE%80%E4%BB%8B/01-dialogue-zh.pdf) | 🟦 已翻译，待校对 |
| 02 | [操作系统简介](pdf/0-%E7%AE%80%E4%BB%8B/02-introduction-zh.pdf) | 🟦 已翻译，待校对 |

### 第一部分　虚拟化

| | 章节 | 状态 |
|---|---|---|
| 03 | [关于虚拟化的对话](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/03-dialogue-zh.pdf) | 🟦 已翻译，待校对 |
| 04 | [抽象：进程](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/04-processes-zh.pdf) | 🟦 已翻译，待校对 |
| 05 | process api | 🟨 翻译中 |
| 06 | direct execution | 🟨 翻译中 |
| 07 | cpu scheduling | 🟨 翻译中 |
| 08 | multi level feedback | 🟨 翻译中 |
| 09 | lottery scheduling | ⬜ 未开始 |
| 10 | [多处理器调度（进阶）](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/10-multi-cpu-scheduling-zh.pdf) | 🟦 已翻译，待校对 |
| 11 | [关于 CPU 虚拟化的总结对话](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/11-summary-zh.pdf) | 🟦 已翻译，待校对 |
| 12 | [关于内存虚拟化的对话](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/12-dialogue-zh.pdf) | 🟦 已翻译，待校对 |
| 13 | [抽象：地址空间](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/13-address-spaces-zh.pdf) | 🟦 已翻译，待校对 |
| 14 | [插叙：内存 API](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/14-memory-api-zh.pdf) | 🟩 已校对（三轮） |
| 15 | [机制：地址转换](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/15-address-translation-zh.pdf) | 🟩 已校对（三轮） |
| 16 | [分段](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/16-segmentation-zh.pdf) | 🟩 已校对（三轮） |
| 17 | [空闲空间管理](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/17-free-space-management-zh.pdf) | 🟩 已校对（三轮） |
| 18 | [分页：简介](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/18-introduction-to-paging-zh.pdf) | 🟩 已校对（三轮） |
| 19 | [分页：更快的转换（TLB）](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/19-translation-lookaside-buffers-zh.pdf) | 🟩 已校对（三轮） |
| 20 | [分页：更小的页表](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/20-advanced-page-tables-zh.pdf) | 🟩 已校对（三轮） |
| 21 | [超越物理内存：机制](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/21-swapping-mechanisms-zh.pdf) | 🟩 已校对（三轮） |
| 22 | [超越物理内存：策略](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/22-swapping-policies-zh.pdf) | 🟩 已校对（三轮） |
| 23 | [完整的虚拟内存系统](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/23-complete-vm-systems-zh.pdf) | 🟩 已校对（三轮） |
| 24 | [关于内存虚拟化的总结对话](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/24-summary-zh.pdf) | 🟩 已校对（三轮） |

### 第二部分　并发

| | 章节 | 状态 |
|---|---|---|
| 25 | [关于并发的对话](pdf/2-%E5%B9%B6%E5%8F%91/25-dialogue-zh.pdf) | 🟩 已校对（三轮） |
| 26 | [并发：简介](pdf/2-%E5%B9%B6%E5%8F%91/26-concurrency-and-threads-zh.pdf) | 🟩 已校对（三轮） |
| 27 | [插叙：线程 API](pdf/2-%E5%B9%B6%E5%8F%91/27-thread-api-zh.pdf) | 🟩 已校对（三轮） |
| 28 | [锁](pdf/2-%E5%B9%B6%E5%8F%91/28-locks-zh.pdf) | 🟩 已校对（三轮） |
| 29 | [基于锁的并发数据结构](pdf/2-%E5%B9%B6%E5%8F%91/29-locked-data-structures-zh.pdf) | 🟩 已校对（三轮） |
| 30 | [条件变量](pdf/2-%E5%B9%B6%E5%8F%91/30-condition-variables-zh.pdf) | 🟩 已校对（三轮） |
| 31 | [信号量](pdf/2-%E5%B9%B6%E5%8F%91/31-semaphores-zh.pdf) | 🟩 已校对（三轮） |
| 32 | [常见并发问题](pdf/2-%E5%B9%B6%E5%8F%91/32-concurrency-bugs-zh.pdf) | 🟩 已校对（三轮） |
| 33 | [基于事件的并发（进阶）](pdf/2-%E5%B9%B6%E5%8F%91/33-event-based-concurrency-zh.pdf) | 🟩 已校对（三轮） |
| 34 | [关于并发的总结对话](pdf/2-%E5%B9%B6%E5%8F%91/34-summary-zh.pdf) | 🟩 已校对（三轮） |

### 第三部分　持久性

| | 章节 | 状态 |
|---|---|---|
| 35 | [关于持久性的对话](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/35-dialogue-zh.pdf) | 🟩 已校对（三轮） |
| 36 | [I/O 设备](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/36-i-o-devices-zh.pdf) | 🟩 已校对（三轮） |
| 37 | [硬盘驱动器](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/37-hard-disk-drives-zh.pdf) | 🟩 已校对（三轮） |
| 38 | [廉价磁盘冗余阵列（RAID）](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/38-redundant-disk-arrays-raid-zh.pdf) | 🟩 已校对（三轮） |
| 39 | [插叙：文件和目录](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/39-files-and-directories-zh.pdf) | 🟩 已校对（三轮） |
| 40 | [文件系统实现](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/40-file-system-implementation-zh.pdf) | 🟩 已校对（三轮） |
| 41 | [局部性和快速文件系统](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/41-fast-file-system-ffs-zh.pdf) | 🟩 已校对（三轮） |
| 42 | [崩溃一致性：FSCK 和日志](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/42-fsck-and-journaling-zh.pdf) | 🟩 已校对（三轮） |
| 43 | [日志结构文件系统](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/43-log-structured-file-system-lfs-zh.pdf) | 🟩 已校对（三轮） |
| 44 | [基于闪存的 SSD](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/44-flash-based-ssds-zh.pdf) | 🟩 已校对（三轮） |
| 45 | [数据完整性与保护](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/45-data-integrity-and-protection-zh.pdf) | 🟩 已校对（三轮） |
| 46 | [关于持久性的总结对话](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/46-summary-zh.pdf) | 🟩 已校对（三轮） |
| 47 | [关于分布式的对话](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/47-dialogue-zh.pdf) | 🟩 已校对（三轮） |
| 48 | [分布式系统](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/48-distributed-systems-zh.pdf) | 🟩 已校对（三轮） |
| 49 | [Sun 的网络文件系统（NFS）](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/49-network-file-system-nfs-zh.pdf) | 🟩 已校对（三轮） |
| 50 | [Andrew 文件系统（AFS）](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/50-andrew-file-system-afs-zh.pdf) | 🟩 已校对（三轮） |
| 51 | [关于分布式的总结对话](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/51-summary-zh.pdf) | 🟩 已校对（三轮） |

### 第四部分　安全

| | 章节 | 状态 |
|---|---|---|
| 52 | [关于安全的对话](pdf/4-%E5%AE%89%E5%85%A8/52-dialogue-zh.pdf) | 🟩 已校对（三轮） |
| 53 | [操作系统安全简介](pdf/4-%E5%AE%89%E5%85%A8/53-intro-security-zh.pdf) | 🟩 已校对（三轮） |
| 54 | [身份认证](pdf/4-%E5%AE%89%E5%85%A8/54-authentication-zh.pdf) | 🟩 已校对（三轮） |
| 55 | [访问控制](pdf/4-%E5%AE%89%E5%85%A8/55-access-control-zh.pdf) | 🟩 已校对（三轮） |
| 56 | [用密码学保护信息](pdf/4-%E5%AE%89%E5%85%A8/56-cryptography-zh.pdf) | 🟩 已校对（三轮） |
| 57 | [分布式系统安全](pdf/4-%E5%AE%89%E5%85%A8/57-distributed-zh.pdf) | 🟩 已校对（三轮） |

### 附录

| | 章节 | 状态 |
|---|---|---|
| A1 | [关于虚拟机监视器的对话](pdf/5-%E9%99%84%E5%BD%95/a1-dialogue-zh.pdf) | 🟦 已翻译，待校对 |
| A2 | [虚拟机监视器](pdf/5-%E9%99%84%E5%BD%95/a2-virtual-machines-zh.pdf) | 🟦 已翻译，待校对 |
| A3 | [关于管程的对话](pdf/5-%E9%99%84%E5%BD%95/a3-dialogue-zh.pdf) | 🟦 已翻译，待校对 |
| A4 | [管程（已过时）](pdf/5-%E9%99%84%E5%BD%95/a4-monitors-zh.pdf) | 🟦 已翻译，待校对 |
| A5 | [关于实验的对话](pdf/5-%E9%99%84%E5%BD%95/a5-dialogue-zh.pdf) | 🟦 已翻译，待校对 |
| A6 | [实验：教程](pdf/5-%E9%99%84%E5%BD%95/a6-lab-tutorial-zh.pdf) | 🟦 已翻译，待校对 |
| A7 | [实验：系统项目](pdf/5-%E9%99%84%E5%BD%95/a7-systems-labs-zh.pdf) | 🟦 已翻译，待校对 |
| A8 | [实验：xv6 项目](pdf/5-%E9%99%84%E5%BD%95/a8-xv6-labs-zh.pdf) | 🟦 已翻译，待校对 |

<!-- progress:end -->
