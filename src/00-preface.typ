#import "ostep.typ": *

// 前言不是正式章节：没有章号，页码用罗马数字，从 iii 开始（i 是献词页，ii 是空白页）。
// 首页照章首的样子排（折角线加右对齐的标题，只是没有章号），页码在页底居中；
// 其余各页页眉左边是「前言」、右边是页码，页脚和正文各章一样。原文页脚是 VERSION 1.20、2008–26。
#let roman() = numbering("i", counter(page).get().first())

#set document(title: "前言") if not book-mode
#set page(
  width: 432pt, height: 648pt,
  margin: (x: margin-x, top: body-top, bottom: 648pt - body-bottom),
  background: context {
    set text(font: serif, size: body-size, top-edge: "baseline", bottom-edge: "baseline")
    let at(y, body) = place(top + left, dx: margin-x, dy: y, box(width: text-width, body))
    if local-page() == 1 {
      at(foot-y, align(center)[iii])
    } else {
      at(head-y, [前言 #h(1fr) #roman()])
      place(top + left, dx: margin-x, dy: head-y + 3.5pt, line(length: text-width, stroke: 0.4pt))
      at(foot-y, text(size: 8pt)[
        #fsc("Operating Systems [Version 1.20]") #h(1fr) #fsc("© 2008–26, Arpaci-Dusseau")])
    }
  },
)
#counter(page).update(3)
#unit-start()
#if book-mode { struct-heading(1, [前言]) }

#set text(font: serif, size: body-size, lang: "zh", region: "cn", top-edge: 0.88em, bottom-edge: -0.12em)
#set par(justify: true, leading: skip - 1em, spacing: skip - 1em, first-line-indent: (amount: 2em, all: true))
#show emph: it => {
  show regex("[\p{Han}，。、；：！？（）]+"): set text(font: "KaiTi", style: "normal", size: 1.1em, tracking: -0.06em)
  it
}
#show strong: set text(weight: "bold")
#show regex("[A-Za-z]’[A-Za-z]"): set text(font: "Palatino Linotype")
#show smartquote.where(double: false): set text(font: "Palatino Linotype")
#show raw: set text(font: mono, size: 1.25em)
#show raw.where(block: true): it => {
  set par(leading: 10.5pt - 1em, justify: false)
  block(inset: (left: 11pt), above: 9pt, below: 9pt, it)
}
#show heading: set text(weight: "regular")
#show heading.where(level: 2): it => block(above: 15pt, below: 8pt, sticky: true,
  text(size: 10pt, weight: "bold", it.body))
#set footnote.entry(separator: line(length: 30%, stroke: 0.4pt), gap: 3pt, clearance: 8pt)
#show footnote.entry: set text(size: 7pt)
#show footnote.entry: set par(first-line-indent: 0pt, leading: 9pt - 1em)

// 首页：折角线加右对齐的标题，没有章号
#block(height: 200pt - body-top - 0.88 * body-size, width: 100%, below: 0pt, {
  set text(top-edge: "baseline", bottom-edge: "baseline")
  place(top + left, dy: 126pt - body-top, line(length: text-width, stroke: 0.5pt))
  place(top + left, dx: text-width, dy: 84pt - body-top, line(angle: 90deg, length: 42pt, stroke: 0.5pt))
  place(top + left, dy: 154pt - body-top, box(width: text-width, align(right, text(font: sans, size: 14.3pt)[前言])))
})

== 致所有读者

欢迎阅读本书！希望你读这本书时，能像我们写这本书时一样享受。本书名为#strong[《操作系统：三个简单的部分》]（Operating Systems: Three Easy Pieces，可以在 `http://ostep.org` 上找到），书名显然是在致敬一位名叫 Richard Feynman 的人写的物理学讲义 [F96]，那是史上最出色的讲义之一。本书无疑达不到那位著名物理学家树立的高标准，但如果你想弄明白操作系统（以及更广义的系统）究竟是怎么回事，它或许也够用了。

所谓“三个简单的部分”，指的是本书围绕的三大主题：#strong[虚拟化]（virtualization）、#strong[并发]（concurrency）和#strong[持久性]（persistence）。讨论这些概念时，我们最终会讲到操作系统所做的大部分重要工作；希望你在这个过程中也能得到一些乐趣。学习新东西很有趣，对吧？至少（通常）应该是这样。

每个大主题都分成若干章，大多数章先提出一个具体问题，再说明如何解决它。各章篇幅都不长，并且尽量注明各种思想真正的出处。写这本书的目标之一，就是尽量把历史脉络梳理出来，因为我们认为，这能帮学生更清楚地理解事物现在如何、过去如何、将来又会如何。看看香肠是怎么做出来的，几乎和弄明白香肠有什么用一样重要#footnote[提示：用来吃！要是你吃素，那就是用来躲开。]。

书中有几种贯穿始终的手法，值得在这里先介绍一下。第一种是问题的#strong[关键]（crux）。每次要解决一个问题，我们都会先说明其中最要紧的是什么；这样的#strong[关键问题]会在正文中明确标出来，并且（但愿）能用后文介绍的技术、算法和思想来解决。

在很多地方，我们会把系统随时间推移的行为展示出来，借此说明它是怎么工作的。这些#strong[时间线]（timeline）是理解的精髓所在：比如，如果你知道一个进程（process）遇到缺页异常（page fault）时会发生什么，你就已经走在真正理解虚拟内存（virtual memory）如何运作的路上了；如果你明白日志文件系统（journaling file system）把一个块写到磁盘时发生了什么，你就已经朝着精通存储系统迈出了第一步。

正文中还有许多#strong[补充]（aside）和#strong[提示]（tip），给主线内容增添一些色彩。补充通常讨论与正文相关（但也许不是必需）的内容；提示通常是一些普遍适用的经验，可以用在你构建的系统上。为了方便查阅，书末的索引列出了全部提示和补充（还有全部关键问题，crux 的复数形式 cruces 有点古怪）。

全书还用到了一种最古老的教学方法：#strong[对话]（dialogue），借它换个角度来呈现部分内容。对话用来引出各大主题（后面你会看到，引出的方式和桃子有关），也不时用来复习学过的内容。对话还让我们有机会用更幽默的笔调来写。至于你觉得它们有没有用、好不好笑，那就完全是另一回事了。

每一大部分的开头，我们会先介绍操作系统提供的一种#strong[抽象]（abstraction），然后在后续各章中讨论提供这种抽象所需的机制、策略和其他支持。抽象是计算机科学方方面面的基础，所以它在操作系统中同样必不可少，也就不足为奇了。

在各章中，我们尽可能使用#strong[真实代码]，而不是#strong[伪代码]（pseudocode），因此几乎所有例子，你都应该能自己敲进去运行。在真实系统上运行真实代码，是学习操作系统的最好方法，所以我们鼓励你尽量这么做。我们也把代码公开了，供你阅读#footnote[#raw("https://github.com/remzi-arpacidusseau/ostep-code")]。

书中多处穿插了一些#strong[作业]（homework），帮你确认自己理解了所讲的内容。很多作业是对操作系统某个部分的小型#strong[模拟]（simulation）；你应该下载这些作业，运行它们来自测。这些作业模拟器有一个特点：给它们不同的随机种子，就能生成几乎无穷无尽的题目；还可以让模拟器替你解题。这样，你就可以反复自测，直到理解得足够透彻为止。

本书最重要的补充材料是一组#strong[项目]（project），你要自己设计、实现和测试代码，从中了解真实系统是如何工作的。所有项目（以及上面提到的代码示例）都使用 #strong[C 编程语言] [KR88]；C 是一门简单而强大的语言，大多数操作系统都建立在它之上，因此值得把它加进你的语言工具箱。项目分两类（思路见在线附录）。第一类是#strong[系统编程]（systems programming）项目，非常适合刚接触 C 和 #fsc("Unix")、想学习如何做底层 C 编程的人。第二类基于麻省理工学院开发的一个真实的操作系统内核 xv6 [CK+08]，非常适合已经会一些 C、想亲手深入操作系统内部的学生。在威斯康星大学，我们用三种不同的方式开过这门课：全部做系统编程项目、全部做 xv6 项目，或者两者混合。

我们正在陆续公开项目说明和测试框架。详情请见我们的代码仓库#footnote[#raw("https://github.com/remzi-arpacidusseau/ostep-projects")]。如果你不是在上这门课，这些材料也能让你自己动手做这些项目，更好地掌握所学内容。遗憾的是，遇到困难时没有助教可以缠着问，但人生中并不是什么都能免费（不过书可以！）。

#pagebreak()

== 致教师

如果你是讲师或教授，想用这本书来教课，尽管用。你可能已经注意到了，各章都可以从下面这个网页免费在线获取：

```
http://www.ostep.org
```

你也可以在 `http://lulu.com` 或 `http://amazon.com` 上购买印刷版，具体请在上面的网页上查找。

本书（目前）正确的引用方式如下：

#block(inset: (left: 22pt), above: 10pt, below: 12pt, {
  set par(first-line-indent: 0pt, leading: 9.5pt - 1em, spacing: 9.5pt - 1em, justify: false)
  set text(lang: "en", font: "Palatino Linotype")
  [*Operating Systems: Three Easy Pieces*\
  Remzi H. Arpaci-Dusseau and Andrea C. Arpaci-Dusseau\
  Arpaci-Dusseau Books\
  August, 2018 (Version 1.00) or July, 2019 (Version 1.01)\
  or October, 2023 (Version 1.10)\
  #raw("http://www.ostep.org")]
})

这门课的内容刚好适合用一个 15 周的学期来讲，大部分主题都能讲到相当的深度。如果要压缩到一个 10 周的学季里，大概就得把每个部分都删掉一些细节。书中还有几章讲虚拟机监视器（virtual machine monitor），我们通常会在学期中找个时间塞进去：要么放在虚拟化这一大部分的最后，要么放在临近期末，作为一段插叙来讲。

本书有一个略显不同寻常的地方：许多操作系统教材把并发放在前面讲，本书却推迟到学生理解了 CPU 和内存的虚拟化之后才讲。根据我们讲授这门课近 20 年的经验，如果学生还不明白什么是地址空间（address space）、什么是进程，以及为什么上下文切换（context switch）可能在任意时刻发生，他们就很难理解并发问题是怎么产生的，也不明白为什么要去解决它。而一旦理解了这些概念，再引入线程（thread）的概念以及线程带来的问题，就会变得相当容易，至少容易一些。

我们尽可能用黑板（或白板）来讲课。在偏重概念的课上，我们带着几个主要的思想和例子来到教室，用板书把它们讲出来。讲义也很有用，可以根据所学内容给学生出一些具体的题目。在偏重实践的课上，我们干脆把笔记本电脑接到投影仪上，直接展示真实代码；这种方式特别适合讲并发，也适合在讨论课上给学生展示与他们的项目相关的代码。我们一般不用幻灯片来讲课，但现在也为喜欢这种讲课方式的老师准备了一套幻灯片。

这些材料你想要哪一份，都可以给我们发电子邮件。我们已经和世界各地的许多人分享过这些材料，也有人反过来贡献了他们自己的材料。

最后还有一个请求：如果你使用免费的在线章节，请直接#strong[链接]到它们，而不要另存一份副本。这样既能帮我们统计使用情况（每月有上百万章次的下载），也能确保学生拿到最新（也是最好？）的版本。

#pagebreak()

== 致学生

如果你是正在读这本书的学生，谢谢你！能提供一些材料，帮助你学习操作系统的知识，是我们的荣幸。我们俩都怀念本科时读过的一些教材（例如 Hennessy 和 Patterson 的那本计算机体系结构经典教材 [HP90]），希望这本书也能成为你美好的回忆之一。

你可能已经注意到，这本书可以免费在线获取#footnote[在这里岔开说一句：我们这里说的“免费”并不意味着开源，也不意味着这本书没有通常的版权保护，它是有版权的！它的意思是，你可以下载这些章节，用来学习操作系统。为什么不像 Linux 是开源内核那样，把书也开源呢？因为我们认为，一本书应该从头到尾保持同一种口吻，而我们也下了很大功夫去营造这种口吻。读这本书时，应该有点像在和人对话，听对方给你讲解。这就是我们这样做的原因。]。主要原因只有一个：教材一般都太贵了。我们希望，这本书能成为新一波免费教材中的第一本，帮助那些追求学业的人，不管他们来自世界的哪个角落，也不管他们愿意花多少钱买书。就算做不到这一点，它至少也是一本免费的书，有总比没有强。

我们还希望尽可能把书中大部分内容的原始出处指给你看：那些多年来塑造了操作系统领域的伟大论文和伟大人物。思想不是凭空而来的；它们来自聪明而勤奋的人（其中包括多位图灵奖得主#footnote[图灵奖是计算机科学的最高奖项，就像诺贝尔奖，只不过你从来没听说过它。]），因此我们应该尽可能去赞颂这些思想和这些人。这样做，我们也许就能更好地理解曾经发生过的那些革命，而不是把教材写得好像这些思想一直就存在似的 [K62]。此外，这些参考文献或许还能鼓励你自己去深入钻研；阅读本领域的著名论文，无疑是最好的学习方法之一。

#pagebreak()

== 致谢

这一节用来感谢帮助我们完成这本书的人。眼下最重要的是：#strong[你的名字也可以出现在这里！]不过，你得帮忙才行。所以，请给我们发来反馈，帮这本书除除 bug。说不定你还会出名！至少，你的名字会出现在某本书里。

迄今为止帮过我们的人包括：

#block(above: 10pt, {
  set text(lang: "en", font: "Palatino Linotype", size: 8.2pt)
  set par(first-line-indent: 0pt, leading: 10.5pt - 1em)
  [Aaron Gember (Colgate), Aashrith H Govindraj (USF), Abdallah Ahmed, Abhinav Mehra, Abhinay Reddy, Abhirami Senthilkumaran\*, Abhishek Bhattacherjee (NITR), Adam Drescher\* (WUSTL), Adam Eggum, Adam Morrison, Aditya Venkataraman, Adriana Iamnitchi and class (USF), Ahmad Jarara, Ahmed Fikri\*, Aisha Atif, Ajaykrishna Raghavan, Akiel Khan, Alain Clark (github), Alex Curtis, Alex Giorev, Alex Wyler, Alex Zhao (U. Colorado at Colorado Springs), Alexander Nordin (MIT), Ali Razeen (Duke), Alistair Martin, Amila Senadheera, AmirBehzad Eslami, Anand Mundada, Andrei Bozântan, Andrew Thomas Chan, Andrew Mahler, Andrew Moss, Andrew Valencik (Saint Mary’s), Angela Demke Brown (Toronto), Antonella Bernobich (UoPeople)\*, Arek Bulski, Arman Jasuja, Arun Rajan (Stonybrook), Aryan Arora, Axel Solis Trompler (KIT), B. Brahmananda Reddy (Minnesota), Bala Subrahmanyam Kambala, Bart Miller (Wisconsin), Basti Ortiz (github), Ben Kushigian (U. Mass), Benita Bose, Benjamin Wilhelm (Konstanz), BigAPG (github), Bill Yang, Biswajit Mazumder (Clemson), Bo Liu (UCSD), Bobby Adashev, Bobby Jack, Björn Lindberg, Brad Spendlove (Randolph), Brandon Harshe (U. Minn), Brennan Payne, Brian Gorman, Brian Kroth, Burak Gorduk, Calder White (University of Waterloo), Caleb Sumner (Southern Adventist), Cara Lauritzen, Charlotte Kissinger, Chen Huo (Shippensburg University), Chris Simionovici (U. Toronto), Cheng Su, Chien Chi, Chien-Chung Shen (Delaware)\*, chriskorosu (github), Christian Stober, Christoph Jaeger (HTWK Leipzig), C.J. Stanbridge (Memorial U. of Newfoundland), Cody Hanson, Constantinos Georgiades, Dakota Cookenmaster (Southern Adventist), Dakota Crane (U. Washington-Tacoma), Dan Soendergaard (U. Aarhus), Dan Tsafrir (Technion), Daniel J Williams (IBM)\*, Daniela Ferreira Franco Moura, Danilo Bruschi (Universita Degli Studi Di Milano), Darby Asher Noam Haller, David Hanle (Grinnell), David Hartman, Dawn Flood, Deepika Muthukumar, Demir Delic, Dennis Zhou, Dheeraj Shetty (North Carolina State), Diego Oleiarz (FaMAF UNC), dominikw1 (github), Dominic White, Dorian Arnold (New Mexico), Dustin Metzler, Dustin Passofaro, Dylan Kaplan, Eduardo Stelmaszczyk, Efkan S. Goktepe, Emad Sadeghi, Emil Hessman, Emily Jacobson, Emmett Witchel (Texas), Eric Freudenthal (UTEP), Erik Hjelmås Eric Kleinberg, Eric Johansson, Erik Turk, Ernst Biersack (France), Ethan Wood, Evan Leung, Fangjun Kuang (U. Stuttgart), Feng Zhang (IBM), Finn Kuusisto\*, Francesco Piccoli, Gavin Inglis (Notre Dame), Gia Hoang Tran, Giovanni Di Santi, Giovanni Lagorio (DIBRIS), Giovanni Moricca, Glenn Bruns (CSU Monterey Bay), Glen Granzow (College of Idaho), Greggory Van Dycke, Guilherme Baptista, gurugio (github), Tian Guo (WPI), Hamid Reza Ghasemi, Hao Chen, Hao Liu, Hein Meling (Stavanger), Helen Gaiser (HTWG Konstanz), Henry Abbey, Hilmar Gústafsson (Aalborg University), Holly Johnson (USF), Hrishikesh Amur, Huanchen Zhang\*, Huseyin Sular, Hugo Diaz, Hyrum Carroll (Columbus State), Ilya Oblomkov, Immacolata Fasano, Itai Hass (Toronto), Jack Xu (Wisconsin), Jackson “Jake” Haenchen (Texas), Jacob Levinson (UCLA), Jaeyoung Cho (SKKU), Jagannathan Eachambadi, Jake Gillberg, Jakob Olandt, James Earley, James Perry (U. Michigan-Dearborn)\*, Jan Reineke (Universität des Saarlandes), Jason MacLafferty (Southern Adventist), Jason Waterman (Vassar), Jay Lim, Jeremiah Ryan Buizon, Jerod Weinman (Grinnell), Jersey Deng (UCLA), Jhih-Cheng Luo, Jiao Dong (Rutgers), Jia-Shen Boon, Jiawen Bao, Jidong Xiao (Boise State), Jingxin Li, jmcruzGH (github), Joe Jean (NYU), Joel Kuntz (Saint Mary’s), Joel Hassan (U. Helsinki), Joel Sommers (Colgate), Johannes Kinder, John Brady (Grinnell), John Komenda, John McEachen (NPS), John Shawger (Wisconsin), Jonathan Perry (MIT), Joshua Carpenter (NCSU), Josip Cavar, Jun He, Justinas Petuchovas, k4lizen, Kai Mast (Wisconsin), Karl Schultheisz, Karl Wallinger, Kartik Singhal, Katherine Dudenas, Katie Coyle (Georgia Tech), Kaushik Kannan, Kemal Bıçakcı, Kevin Liu\*, Khaled Emara, Kyle Hale (Illinois Institute of Technology), KyoungSoo Park (KAIST), Kyutae Lee\*, Lanyue Lu, Laura Xu, legate (github), Lei Tian (U. Nebraska-Lincoln), Leonardo Medici (U. Milan), Leslie Schultz, Liang Yin, Lihao Wang, Looserof, Louie Lu, Luigi Finetti (FaMAF, UNC) Luna Gal (Wooster), lyazj (github), Manav Batra (IIIT-Delhi), Manu Awasthi (Samsung), Marcel van der Holst, Marco Guazzone (U. Piemonte Orientale), Marco Pedrinazzi (Universita Degli Studi Di Milano), Marius Rodi, Mart Oskamp, Martha Ferris, Martinho Macedo, Masashi Kishikawa (Sony), Matt Reichoff, Matías De Pascuale (FaMAF Universidad Nacional De Cordoba), Matthew Prinz, Matthias St. Pierre, Mattia Monga (U. Milan), Matty Williams, Megan Cutrofello, Meng Huang, Michael Machtel (Hochschule Konstanz), Michael Walfish (NYU), Michael Wu (UCLA), Mike Griepentrog, Ming Chen (Stonybrook), Mohammed Alali (Delaware), Mohamed Omran (GUST), Mondo Gao (Wisconsin), Muhammad Mobeen Movania, Muhammad Yasoob Ullah Khalid, Murat Kerim Aslan, Murugan Kandaswamy, Nadeem Shaikh, Nan Xiao, Natasha Eilbert, Natasha Stopa, Nathan Dipiazza, Nathan Sullivan, Neeraj Badlani (N.C. State), Neil Perry, Nelson Gomez, Neven Sajko, Nghia Huynh (Texas), Ngu (Nicholas) Q. Truong, Nicholas Mandal, Nick Weinandt, Nishin Shouzab, Nitin Puranik, Nizare Leonetti, Noah Jackson, Otto Sievert, ParagDixit (github), Patel Pratyush Ashesh (BITS-Pilani), Patricio Jara, Patrick Elsen, Patrizio Palmisano, Pavle Kostovic, Perry Kivolowitz, Peter Peterson (Minnesota), Phani Karan, Pieter Kockx, Po-Hao Su (Taiwan) Prabhsimrandeep Singh, Prairie Rose Goodwin, Radford Smith, Raunak Seksaria, Repon Kumar Roy, Reynaldo H. Verdejo Pinochet, Riccardo Mutschlechner, Rick Perry, Richard Campanha (Georgia Tech), Ripudaman Singh, Rita Pia Folisi, Robert Ordóñez and class (Southern Adventist), Robin Li (Cornell), Roger Wattenhofer (ETH), Rohan Das (Toronto)\*, Rohan Pasalkar (Minnesota), Rohan Puri, Roman Bureacov, Ross Aiken, Ruslan Kiselev, Ryan Albrecht, Ryland Herrick, Sam Kelly, Sam Noh (UNIST), Sameer Punjal, Samer Al-Kiswany, Sandeep Ummadi (Minnesota), Santiago Marini, Sankaralingam Panneerselvam, Sarvesh Tandon (Wisconsin), Satish Chebrolu (NetApp), Satyanarayana Shanmugam\*, Scott Catlin, Scott Clark, Scott Lee (UCLA), Scott Schoeller, sepehr541 (github), Seth Pollen, Sharad Punuganti, Shawn Ge, Shivaram Venkataraman, Shreevatsa R., Simon Pratt (University of Waterloo), Sirui Chen, Sivaraman Sivaraman\*, Song Jiang (Wayne State), Spencer Harston (Weber State), Srinivasan Thirunarayanan\*, stadtz (github), Stardustman (github), Stefan Dekanski, Stephen Bye, Stephen Schaub, Suriyhaprakhas Balaram Sankari, Sy Jin Cheah, Teri Zhao (EMC), Thanumalayan S. Pillai, thasinaz (github), Thomas Griebel, Thomas John Lesniak (Wisconsin), Thomas Scrace, Tianxia Bai, Tobi Popoola (Boise State), Tong He, Tongxin Zheng, Tony Adkins, Torin Rudeen (Princeton), Tuo Wang, Tyler Couto, Varun Vats, Veera Sivarajan, Vegard Stikbakke, Victor Chernyakin, Vikas Goel, Waciuma Wanjohi, William Royle (Grinnell), Winson Huang (github), Wojciech Rok (AGH University of Kraków), Xiang Peng, Xu Di, Yanjun Wen, Yanyan Jiang, Yifan Hao, Yuanyuan Chen, Yubin Ruan, Yudong Sun, Yue Zhuo (Texas A&M), Yufeng Zhang (UCLA), Yufui Ren, Yuxing Xiang (Peking), Zef RosnBrick, Zeyuan Hu (Texas), Zhengguang Zhou (Wisconsin), ZiHan Zheng (USTC), zino23 (github), Zuyu Zhang.]
})

特别感谢上面标有星号的各位，他们提出的改进建议远远超出了我们的期望。

此外，衷心感谢 Joe Meehean 教授（Lynchburg）为每一章写的详细笔记；感谢 Jerod Weinman 教授（Grinnell）和他全班同学做的精彩小册子；感谢 Chien-Chung Shen 教授（Delaware）宝贵而细致的审读和意见；感谢 Adam Drescher（WUSTL）认真的审读和建议；感谢 Glen Granzow（College of Idaho）极其详尽的意见和提示；感谢 Michael Walfish（NYU）的热情和详细的改进建议；感谢 Peter Peterson（UMD）提供的许多有用的反馈和评论；感谢 Mark Kampe（Pomona）详尽的批评意见（我们真希望能把所有建议都改好！）；感谢 Youjip Won（Hanyang）把本书译成韩文（！）并提出许多深刻的建议；感谢 Terence Kelly 撰写关于内存映射（memory mapping）的补充。他们都给了我们无法估量的帮助！

特别感谢 Peter Reiher 教授（UCLA）以本书的风格写出了一组精彩的安全章节。我们有幸在很多年前就认识了 Peter，却万万没想到二十年后会以这种方式合作。了不起的工作！

还要深深感谢这些年来上过 537 这门课的数百名学生。尤其是 2008 年秋季学期的那个班，是他们促成了这些讲义最早的书面形式（他们受够了连本像样的教材都没有，真是一群爱施压的学生！），然后又给了足够多的称赞，让我们坚持写了下去（包括那年课程评估里一条令人捧腹的评语：“ZOMG! You should totally write a textbook!”，意思是“天哪！你们绝对该写本教材！”）。

我们还要深深感谢少数几位勇敢的学生，他们选修了 xv6 项目实验课，那门课的大部分内容如今已经并入了 537 的主课。2009 年春季：Justin Cherniak、Patrick Deline、Matt Czech、Tony Gregerson、Michael Griepentrog、Tyler Harter、Ryan Kroiss、Eric Radzikowski、Wesley Reardan、Rajiv Vaidyanathan 和 Christopher Waclawik。2009 年秋季：Nick Bearson、Aaron Brown、Alex Bird、David Capel、Keith Gould、Tom Grim、Jeffrey Hugo、Brandon Johnson、John Kjell、Boyan Li、James Loethen、Will McCardell、Ryan Szaroletta、Simon Tso 和 Ben Yule。2010 年春季：Patrick Blesi、Aidan Dennis-Oehling、Paras Doshi、Jake Friedman、Benjamin Frisch、Evan Hanson、Pikkili Hemanth、Michael Jeung、Alex Langenfeld、Scott Rick、Mike Treffert、Garret Staus、Brennan Wall、Hans Werner、Soo-Young Yang 和 Carlos Griffin（差一点就算上了）。

我们的博士生虽然没有直接参与这本书，但我们对系统的了解，很多都是从他们那里学来的。他们在威斯康星大学期间，我们经常和他们交流，而真正的工作都是他们做的；听他们讲自己在做什么，我们每周都能学到新东西。下面列出的是已经毕业的博士：Nitin Agrawal、Ram Alagappan、Leo Arulraj、Lakshmi Bairavasundaram、John Bent、Nathan Burnett、Tyler Caraza-Harter、Vijay Chidambaram、Timothy Denehy、Thanh Do、Aishwarya Ganesan、Haryadi Gunawi、Jun He、Todd Jones、Jing Liu、Lanyue Lu、Joe Meehean、Yuvraj Patel、Thanu Pillai、Florentina Popovici、Vijayan Prabhakaran、Anthony Rebello、Muthian Sivathanu、Sriram Subramanian、Swami Sundararaman、Zev Weiss、Kan Wu、Suli Yang、Yiying Zhang、Yupu Zhang、Yifan Dai、Guanzhou Hu。还有下面几位博士后：Shaohua Duan、Samer Al-Kiswany、Sudarsun Kannan、Kai Mast。

当然，还有许多其他学生（本科生和硕士生）和合作者与我们合写过论文。我们也要感谢他们；想知道他们是谁，请看我们的网页或 DBLP。

我们的研究生主要由美国国家科学基金会（NSF）、美国能源部科学办公室（DOE）资助，也得到了业界的捐赠和资助。我们尤其感谢 NSF 多年来的支持，因为我们的研究塑造了本书许多章的内容。

感谢 Thomas Griebel，是他要求给这本书换个更好的封面。虽然我们没有采纳他的具体建议（一只恐龙，你敢信吗？），但要是没有他，封面上就不会有那张美丽的哈雷彗星照片。

最后，我们还要感谢 Aaron Brown。他很多年前（2009 年春季）先上了这门课，接着上了 xv6 实验课（2009 年秋季），最后又当了这门课大约两年的研究生助教（2010 年秋季到 2012 年春季）。他不知疲倦的工作大大改进了这些项目（尤其是 xv6 方面的项目），从而让威斯康星大学无数本科生和研究生的学习体验变得更好。正如 Aaron 会说的那样（以他一贯的简洁）：“Thx.”

#pagebreak()

== 写在最后

Yeats 有一句名言：“教育不是注满一桶水，而是点燃一把火。”他说对了，但同时也说错了#footnote[如果他真的说过这句话的话；和许多名言一样，这句妙语的来历扑朔迷离。]。你确实得“注满”一点水，而这些讲义当然就是来帮你完成这部分教育的；毕竟，你去 Google 面试时，要是人家问你一道怎么用信号量（semaphore）的刁钻题，真知道信号量是什么总归有好处，对吧？

不过，Yeats 更大的观点显然切中要害：教育真正的意义，在于让你对某样东西产生兴趣，主动去多学一些，而不只是为了在某门课上拿个好成绩，把非消化不可的东西消化掉。正如我们其中一人的父亲（Remzi 的父亲 Vedat Arpaci）常说的：“要在课堂之外学习。”

我们写这些讲义，是为了激发你对操作系统的兴趣，让你自己去读更多相关的东西，去和你的教授聊聊这个领域里正在进行的那些激动人心的研究，甚至亲自参与这些研究。这是一个了不起的领域（！），充满了令人兴奋的奇妙思想，它们深刻而重要地塑造了计算的历史。虽然我们明白，这把火不会在你们每个人心中点燃，但希望它能在许多人心中点燃，哪怕只有少数几个人也好。因为这把火一旦点燃，你就真正有能力做出一番大事了。这也正是教育真正的意义所在：走出去，研究许多新奇迷人的课题，去学习，去成长，而最重要的是，找到能在你心中点燃一把火的东西。

#v(14pt)
#block({
  set par(first-line-indent: 0pt, leading: 10.5pt - 1em, spacing: 10.5pt - 1em, justify: false)
  emph[Andrea 和 Remzi \
  一对夫妻 \
  威斯康星大学计算机科学教授 \
  但愿也是首席点火官#footnote[如果这听起来像是我们在承认自己有过纵火前科，那你大概没领会我们的意思。大概。如果这听起来很肉麻，嗯，那是因为它确实很肉麻，不过你只好原谅我们了。]]
})

#pagebreak()

== 参考文献

#references[
[CK+08] “The xv6 Operating System” by Russ Cox, Frans Kaashoek, Robert Morris, Nickolai Zeldovich. From: #raw("http://pdos.csail.mit.edu/6.828/2008/index.html"). _xv6 was developed as a port of the original_ #fsc("Unix") _version 6 and represents a beautiful, clean, and simple way to understand a modern operating system._

[F96] “Six Easy Pieces: Essentials Of Physics Explained By Its Most Brilliant Teacher” by Richard P. Feynman. Basic Books, 1996. _This book reprints the six easiest chapters of Feynman’s Lectures on Physics, from 1963. If you like Physics, it is a fantastic read._

[HP90] “Computer Architecture a Quantitative Approach” (1st ed.) by David A. Patterson and John L. Hennessy . Morgan-Kaufman, 1990. _A book that encouraged each of us at our undergraduate institutions to pursue graduate studies; we later both had the pleasure of working with Patterson, who greatly shaped the foundations of our research careers._

[KR88] “The C Programming Language” by Brian Kernighan and Dennis Ritchie. Prentice-Hall, April 1988. _The C programming reference that everyone should have, by the people who invented the language._

[K62] “The Structure of Scientific Revolutions” by Thomas S. Kuhn. University of Chicago Press, 1962. _A great and famous read about the fundamentals of the scientific process. Mop-up work, anomaly, crisis, and revolution. We are mostly destined to do mop-up work, alas._
]
