# 把 src 下的 Typst 源文件编译成 PDF，输出到 pdf/<部分>/<文件名>-zh.pdf
#
#   python tools/build.py                 编译全书
#   python tools/build.py 28 a4           只编译第 28 章和附录 a4（按文件名前缀匹配，如 00-preface、05）
#   python tools/build.py --part 2        只编译第二部分（并发）；0 简介 1 虚拟化 2 并发 3 持久性 4 安全 5 附录
#   python tools/build.py --watch 28      监视第 28 章，保存源文件后自动重新编译
#   python tools/build.py --list          列出所有章节和它们的输出位置
#   python tools/build.py --book          把全书编成一本：pdf/OSTEP-zh-REM.pdf（页码连续、目录带页码、书签、跨章链接）
#                                         可以和其他选项一起用，比如 --book 28 就是先编第 28 章再编整本
#
# 选项：-j N 同时编译 N 个文件（默认按 CPU 核数）；--out DIR 输出到别的目录（仍按部分分子目录）。
# 需要 Typst 0.15 或更新版本：放在 PATH 里，或者用环境变量 TYPST 指定 typst 可执行文件的路径。
# 排版用到的字体：Palatino Linotype、Noto Serif SC、KaiTi、Arial、Microsoft YaHei、Courier New、Noto Sans SC，
# 缺了会用别的字体代替，排版会和仓库里的 PDF 不一样，脚本开始时会提示缺哪些。

import argparse, os, re, shutil, subprocess, sys
from concurrent.futures import ThreadPoolExecutor

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(ROOT, "src")
PARTS = ["0-简介", "1-虚拟化", "2-并发", "3-持久性", "4-安全", "5-附录"]
FONTS = ["Palatino Linotype", "Noto Serif SC", "KaiTi", "Arial", "Microsoft YaHei", "Courier New", "Noto Sans SC"]


def part_of(name):
    if name.startswith("a"):
        return 5
    n = int(name[:2])
    return 0 if n <= 2 else 1 if n <= 24 else 2 if n <= 34 else 3 if n <= 51 else 4


def chapters():
    names = sorted(f[:-4] for f in os.listdir(SRC) if f.endswith(".typ") and f != "ostep.typ")
    return [n for n in names if re.match(r"(\d\d|a\d)-", n)]


def find_typst():
    for cand in (os.environ.get("TYPST"), shutil.which("typst"),
                 os.path.join(os.environ.get("LOCALAPPDATA", ""), "Programs", "typst", "typst.exe")):
        if cand and os.path.isfile(cand):
            return cand
    sys.exit("找不到 typst：请安装 Typst（https://typst.app），或用环境变量 TYPST 指定路径")


def check_fonts(typst):
    r = subprocess.run([typst, "fonts"], capture_output=True, text=True, encoding="utf-8")
    have = set(r.stdout.splitlines())
    missing = [f for f in FONTS if f not in have]
    if missing:
        print("提示：缺少字体 " + "、".join(missing) + "，会用其他字体代替，排版可能和仓库里的 PDF 不同。")


def out_path(name, out):
    return os.path.join(out, PARTS[part_of(name)], name + "-zh.pdf")


def compile_one(typst, name, out):
    dst = out_path(name, out)
    os.makedirs(os.path.dirname(dst), exist_ok=True)
    r = subprocess.run([typst, "compile", "--root", SRC, os.path.join(SRC, name + ".typ"), dst],
                       capture_output=True, text=True, encoding="utf-8")
    return name, r.returncode, (r.stderr or "").strip()


def main():
    ap = argparse.ArgumentParser(description="编译 OSTEP 中文版的 Typst 源文件")
    ap.add_argument("names", nargs="*", help="要编译的章节（文件名前缀，如 28、a4、00-preface）；不写就编译全书")
    ap.add_argument("--part", type=int, choices=range(6), help="只编译某一部分：0 简介 1 虚拟化 2 并发 3 持久性 4 安全 5 附录")
    ap.add_argument("--watch", metavar="章节", help="监视一个章节，保存后自动重新编译（Ctrl+C 退出）")
    ap.add_argument("--list", action="store_true", help="列出所有章节和输出位置")
    ap.add_argument("--book", action="store_true", help="把全书编成一本 PDF（pdf/OSTEP-zh-REM.pdf）")
    ap.add_argument("-j", "--jobs", type=int, default=os.cpu_count() or 4, help="同时编译的文件数")
    ap.add_argument("--out", default=os.path.join(ROOT, "pdf"), help="输出目录（默认 pdf/）")
    a = ap.parse_args()
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8")

    all_names = chapters()
    if a.list:
        for n in all_names:
            print(f"{n:40} -> {os.path.relpath(out_path(n, a.out), ROOT)}")
        return

    def pick(prefixes):
        hit = [n for n in all_names if any(n == p or n.startswith(p + "-") or n.startswith(p) for p in prefixes)]
        if not hit:
            sys.exit("没有匹配的章节：" + " ".join(prefixes) + "（用 --list 查看全部）")
        return hit

    typst = find_typst()
    check_fonts(typst)

    if a.watch:
        name = pick([a.watch])[0]
        dst = out_path(name, a.out)
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        print(f"监视 {name}.typ -> {os.path.relpath(dst, ROOT)}（Ctrl+C 退出）")
        try:
            subprocess.run([typst, "watch", "--root", SRC, os.path.join(SRC, name + ".typ"), dst])
        except KeyboardInterrupt:
            pass
        return

    if a.book and not a.names and a.part is None:
        names = []          # 只编整本
    else:
        names = pick(a.names) if a.names else all_names
        if a.part is not None:
            names = [n for n in names if part_of(n) == a.part]

    failed = []
    if a.book:
        dst = os.path.join(a.out, "OSTEP-zh-REM.pdf")
        os.makedirs(a.out, exist_ok=True)
        r = subprocess.run([typst, "compile", "--root", SRC, "--input", "book=1", os.path.join(SRC, "book.typ"), dst],
                           capture_output=True, text=True, encoding="utf-8")
        if r.returncode:
            failed.append("book")
            print(f"✗ 整本\n{(r.stderr or '').strip()}\n")
        else:
            print(f"✓ 整本 -> {os.path.relpath(dst, ROOT)}")
    with ThreadPoolExecutor(max_workers=max(1, a.jobs)) as ex:
        for name, code, err in ex.map(lambda n: compile_one(typst, n, a.out), names):
            if code:
                failed.append(name)
                print(f"✗ {name}\n{err}\n")
            else:
                print(f"✓ {name}")
    total = len(names) + (1 if a.book else 0)
    print(f"\n完成 {total - len(failed)}/{total}" + (f"，失败：{' '.join(failed)}" if failed else ""))
    sys.exit(1 if failed else 0)


if __name__ == "__main__":
    main()
