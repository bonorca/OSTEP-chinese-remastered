# 操作系统导论Operating Systems: Three Easy Pieces(OSTEP)中文翻译重制版


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
以上只是一些小小的中文震撼，其实整本书都可以这么对比，我不知道译者的中文语法学自哪个星球，至少并非是我熟知的。

<!-- chapters:start -->

## 下载

**整本**：[OSTEP-zh-REM.pdf](pdf/OSTEP-zh-REM.pdf)（页码连续，目录带页码，书签、跨章链接都能点）

<details>
<summary>各章单独的 PDF</summary>

**简介**：[献词](pdf/0-%E7%AE%80%E4%BB%8B/00-dedication-zh.pdf) · [前言](pdf/0-%E7%AE%80%E4%BB%8B/00-preface-zh.pdf) · [目录](pdf/0-%E7%AE%80%E4%BB%8B/00-toc-zh.pdf) · [1 关于本书的对话](pdf/0-%E7%AE%80%E4%BB%8B/01-dialogue-zh.pdf) · [2 操作系统简介](pdf/0-%E7%AE%80%E4%BB%8B/02-introduction-zh.pdf)

**第一部分　虚拟化**：[3 关于虚拟化的对话](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/03-dialogue-zh.pdf) · [4 抽象：进程](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/04-processes-zh.pdf) · [5 插叙：进程 API](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/05-process-api-zh.pdf) · [6 机制：受限直接执行](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/06-direct-execution-zh.pdf) · [7 调度：简介](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/07-cpu-scheduling-zh.pdf) · [8 调度：多级反馈队列](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/08-multi-level-feedback-zh.pdf) · [9 调度：比例份额](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/09-lottery-scheduling-zh.pdf) · [10 多处理器调度（进阶）](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/10-multi-cpu-scheduling-zh.pdf) · [11 关于 CPU 虚拟化的总结对话](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/11-summary-zh.pdf) · [12 关于内存虚拟化的对话](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/12-dialogue-zh.pdf) · [13 抽象：地址空间](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/13-address-spaces-zh.pdf) · [14 插叙：内存 API](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/14-memory-api-zh.pdf) · [15 机制：地址转换](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/15-address-translation-zh.pdf) · [16 分段](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/16-segmentation-zh.pdf) · [17 空闲空间管理](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/17-free-space-management-zh.pdf) · [18 分页：简介](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/18-introduction-to-paging-zh.pdf) · [19 分页：更快的转换（TLB）](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/19-translation-lookaside-buffers-zh.pdf) · [20 分页：更小的页表](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/20-advanced-page-tables-zh.pdf) · [21 超越物理内存：机制](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/21-swapping-mechanisms-zh.pdf) · [22 超越物理内存：策略](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/22-swapping-policies-zh.pdf) · [23 完整的虚拟内存系统](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/23-complete-vm-systems-zh.pdf) · [24 关于内存虚拟化的总结对话](pdf/1-%E8%99%9A%E6%8B%9F%E5%8C%96/24-summary-zh.pdf)

**第二部分　并发**：[25 关于并发的对话](pdf/2-%E5%B9%B6%E5%8F%91/25-dialogue-zh.pdf) · [26 并发：简介](pdf/2-%E5%B9%B6%E5%8F%91/26-concurrency-and-threads-zh.pdf) · [27 插叙：线程 API](pdf/2-%E5%B9%B6%E5%8F%91/27-thread-api-zh.pdf) · [28 锁](pdf/2-%E5%B9%B6%E5%8F%91/28-locks-zh.pdf) · [29 基于锁的并发数据结构](pdf/2-%E5%B9%B6%E5%8F%91/29-locked-data-structures-zh.pdf) · [30 条件变量](pdf/2-%E5%B9%B6%E5%8F%91/30-condition-variables-zh.pdf) · [31 信号量](pdf/2-%E5%B9%B6%E5%8F%91/31-semaphores-zh.pdf) · [32 常见并发问题](pdf/2-%E5%B9%B6%E5%8F%91/32-concurrency-bugs-zh.pdf) · [33 基于事件的并发（进阶）](pdf/2-%E5%B9%B6%E5%8F%91/33-event-based-concurrency-zh.pdf) · [34 关于并发的总结对话](pdf/2-%E5%B9%B6%E5%8F%91/34-summary-zh.pdf)

**第三部分　持久性**：[35 关于持久性的对话](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/35-dialogue-zh.pdf) · [36 I/O 设备](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/36-i-o-devices-zh.pdf) · [37 硬盘驱动器](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/37-hard-disk-drives-zh.pdf) · [38 廉价磁盘冗余阵列（RAID）](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/38-redundant-disk-arrays-raid-zh.pdf) · [39 插叙：文件和目录](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/39-files-and-directories-zh.pdf) · [40 文件系统实现](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/40-file-system-implementation-zh.pdf) · [41 局部性和快速文件系统](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/41-fast-file-system-ffs-zh.pdf) · [42 崩溃一致性：FSCK 和日志](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/42-fsck-and-journaling-zh.pdf) · [43 日志结构文件系统](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/43-log-structured-file-system-lfs-zh.pdf) · [44 基于闪存的 SSD](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/44-flash-based-ssds-zh.pdf) · [45 数据完整性与保护](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/45-data-integrity-and-protection-zh.pdf) · [46 关于持久性的总结对话](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/46-summary-zh.pdf) · [47 关于分布式的对话](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/47-dialogue-zh.pdf) · [48 分布式系统](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/48-distributed-systems-zh.pdf) · [49 Sun 的网络文件系统（NFS）](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/49-network-file-system-nfs-zh.pdf) · [50 Andrew 文件系统（AFS）](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/50-andrew-file-system-afs-zh.pdf) · [51 关于分布式的总结对话](pdf/3-%E6%8C%81%E4%B9%85%E6%80%A7/51-summary-zh.pdf)

**第四部分　安全**：[52 关于安全的对话](pdf/4-%E5%AE%89%E5%85%A8/52-dialogue-zh.pdf) · [53 操作系统安全简介](pdf/4-%E5%AE%89%E5%85%A8/53-intro-security-zh.pdf) · [54 身份认证](pdf/4-%E5%AE%89%E5%85%A8/54-authentication-zh.pdf) · [55 访问控制](pdf/4-%E5%AE%89%E5%85%A8/55-access-control-zh.pdf) · [56 用密码学保护信息](pdf/4-%E5%AE%89%E5%85%A8/56-cryptography-zh.pdf) · [57 分布式系统安全](pdf/4-%E5%AE%89%E5%85%A8/57-distributed-zh.pdf)

**附录**：[A1 关于虚拟机监视器的对话](pdf/5-%E9%99%84%E5%BD%95/a1-dialogue-zh.pdf) · [A2 虚拟机监视器](pdf/5-%E9%99%84%E5%BD%95/a2-virtual-machines-zh.pdf) · [A3 关于管程的对话](pdf/5-%E9%99%84%E5%BD%95/a3-dialogue-zh.pdf) · [A4 管程（已过时）](pdf/5-%E9%99%84%E5%BD%95/a4-monitors-zh.pdf) · [A5 关于实验的对话](pdf/5-%E9%99%84%E5%BD%95/a5-dialogue-zh.pdf) · [A6 实验：教程](pdf/5-%E9%99%84%E5%BD%95/a6-lab-tutorial-zh.pdf) · [A7 实验：系统项目](pdf/5-%E9%99%84%E5%BD%95/a7-systems-labs-zh.pdf) · [A8 实验：xv6 项目](pdf/5-%E9%99%84%E5%BD%95/a8-xv6-labs-zh.pdf)

</details>

<!-- chapters:end -->

## 自己编译

需要 [Typst](https://typst.app) 0.15 或更新版本和 Python 3。

```
python tools/build.py                 # 编译全书，输出到 pdf/
python tools/build.py 28 a4           # 只编译第 28 章和附录 a4
python tools/build.py --part 2        # 只编译第二部分（0 简介 1 虚拟化 2 并发 3 持久性 4 安全 5 附录）
python tools/build.py --watch 28      # 改稿时用：保存后自动重新编译
python tools/build.py --book          # 把全书编成一本：pdf/OSTEP-zh-REM.pdf
python tools/build.py --list          # 列出所有章节
```

排版用到的字体：Palatino Linotype、Noto Serif SC、KaiTi、Arial、Microsoft YaHei、Courier New、Noto Sans SC。缺了会用其他字体代替，脚本会提示。
