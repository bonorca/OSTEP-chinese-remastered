# 根据 progress.json 重新生成 README 里的翻译进度（两个注释标记之间的部分）
import io, json, os, urllib.parse

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
STATUS = {
    "todo": ("⬜", "未开始"),
    "wip": ("🟨", "翻译中"),
    "translated": ("🟦", "已翻译，待校对"),
    "proofread": ("🟩", "已校对（三轮）"),
}
START, END = "<!-- progress:start -->", "<!-- progress:end -->"

data = json.load(io.open(os.path.join(ROOT, "progress.json"), encoding="utf-8"))
items = [c for p in data["parts"] for c in p["chapters"]]
total = len(items)
done = sum(c["status"] in ("translated", "proofread") for c in items)
checked = sum(c["status"] == "proofread" for c in items)

def badge(label, n, color):
    q = urllib.parse.quote
    return f"![{label}](https://img.shields.io/badge/{q(label)}-{n}%2F{total}-{color})"

out = [START, "", "## 翻译进度", "",
       badge("已翻译", done, "blue") + " " + badge("已校对", checked, "brightgreen"), "",
       " · ".join(f"{e} {t}" for e, t in STATUS.values()), ""]
for p in data["parts"]:
    out += [f"### {p['name']}", "", "| | 章节 | 状态 |", "|---|---|---|"]
    for c in p["chapters"]:
        e, t = STATUS[c["status"]]
        title = c["title"]
        if c.get("pdf"):
            title = f"[{title}]({urllib.parse.quote(c['pdf'])})"
        out.append(f"| {c['no']} | {title} | {e} {t} |")
    out.append("")
out.append(END)

path = os.path.join(ROOT, "README.md")
s = io.open(path, encoding="utf-8").read()
block = "\n".join(out)
if START in s:
    s = s[:s.index(START)] + block + s[s.index(END) + len(END):]
else:
    s = s.rstrip() + "\n\n" + block + "\n"
io.open(path, "w", encoding="utf-8").write(s)
print(f"{done}/{total} 已翻译，{checked}/{total} 已校对")
