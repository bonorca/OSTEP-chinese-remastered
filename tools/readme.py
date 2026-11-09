# 根据 chapters.json 重新生成 README 里的「下载」一节（两个注释标记之间的部分）
#   python tools/readme.py
import io, json, os, urllib.parse

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
START, END = "<!-- chapters:start -->", "<!-- chapters:end -->"

data = json.load(io.open(os.path.join(ROOT, "chapters.json"), encoding="utf-8"))
q = lambda p: urllib.parse.quote(p)

out = [START, "", "## 下载", "",
       "**整本**：[OSTEP-zh-REM.pdf](pdf/OSTEP-zh-REM.pdf)（页码连续，目录带页码，书签、跨章链接都能点）", "",
       "<details>", "<summary>各章单独的 PDF</summary>", ""]
for part in data["parts"]:
    links = []
    for c in part["chapters"]:
        name = c["title"] if c["no"] == "00" else f"{c['no'].lstrip('0')} {c['title']}"
        links.append(f"[{name}]({q(c['pdf'])})")
    out += [f"**{part['name']}**：" + " · ".join(links), ""]
out += ["</details>", "", END]

path = os.path.join(ROOT, "README.md")
s = io.open(path, encoding="utf-8").read()
block = "\n".join(out)
if START in s:
    s = s[:s.index(START)] + block + s[s.index(END) + len(END):]
else:
    s = s.rstrip() + "\n\n" + block + "\n"
io.open(path, "w", encoding="utf-8", newline="\n").write(s)
print("README 已更新：", sum(len(p["chapters"]) for p in data["parts"]), "个文件")
