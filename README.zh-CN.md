# 把想念留在屏幕边

> 让你在意的人成为一个被认真对待的 Codex 宠物——可以是朋友、家人，也可以是仍被你放在心里的人。

[English](README.md) · [完整教程](docs/tutorial.md) · [小龙帽案例](examples/dragon-hood-girl/README.md)

![小龙帽的全部动画状态与注视方向](examples/dragon-hood-girl/media/contact-sheet.png)

这个仓库包含两部分：

1. 可复用技能 `make-keepsake-pet`，负责授权确认、人物特征提炼、情绪设计、生成、质检与打包流程。
2. 完整的小龙帽 v2 示例，包含可用的 `pet.json`、8×11 图集、九种状态和十六个随光标变化的注视方向。

它的目标不是生成一个“差不多的人形头像”，而是保留真正让人认出来的细节：熟悉的神情、常穿的衣服、配饰晃动的方式，或者只有你们懂的小玩笑。

## 小龙帽现在会做什么

![失败状态：共同难过、跪下、侧倒蜷缩](examples/dragon-hood-girl/media/failed.gif)

Codex v2 宠物使用 `192×208` 单元格，完整图集为 `8×11`（总尺寸 `1536×2288`）：

| 行 | 状态 | 常见触发条件 |
| ---: | --- | --- |
| 0 | `idle` | 默认循环与其他反应结束后的回退 |
| 1 | `running-right` | 向屏幕右侧拖动宠物/窗口 |
| 2 | `running-left` | 向屏幕左侧拖动宠物/窗口 |
| 3 | `waving` | 宠物首次出现时的问候 |
| 4 | `jumping` | 鼠标悬停 |
| 5 | `failed` | 可见任务处于危险或阻塞状态 |
| 6 | `waiting` | 等待审批、权限、计划或用户输入 |
| 7 | `running` | 任务正在处理，不是字面意义上的跑步 |
| 8 | `review` | 结果完成、可查看或未读 |
| 9–10 | 注视方向 | 十六个顺时针、相对光标的视线姿势 |

部分反应很短，而且只有在特定事件发生时才触发，所以平时可能只容易看到待机、奔跑和挥手。素材并没有缺失；应用通常播放几轮短反应后就会在视觉上回到待机。

![十六个随光标变化的注视方向](examples/dragon-hood-girl/media/look-directions.png)

## 安装小龙帽

在 macOS 中执行：

```bash
mkdir -p "$HOME/.codex/pets/dragon-hood-girl"
cp examples/dragon-hood-girl/package/pet.json "$HOME/.codex/pets/dragon-hood-girl/pet.json"
cp examples/dragon-hood-girl/package/spritesheet.webp "$HOME/.codex/pets/dragon-hood-girl/spritesheet.webp"
```

重启或重新加载 Codex，然后在宠物选择器里选择 **小龙帽**。以后删除本地克隆的 GitHub 项目，也不会删除已经复制到 `~/.codex/pets/dragon-hood-girl` 的安装文件。

## 安装可复用技能

```bash
mkdir -p "$HOME/.codex/skills"
cp -R skill/make-keepsake-pet "$HOME/.codex/skills/make-keepsake-pet"
```

然后对 Codex 说：

```text
Use $make-keepsake-pet to turn my approved photos and memories into a private Codex pet.
```

这个技能需要 Codex 中已经有兼容的 `hatch-pet` 工作流。它负责补上“如何尊重地理解一个人、保留身份特征”的上层流程；确定性的图集组装、方向质检、验证和安装仍交给 `hatch-pet`。

## 制作自己的纪念宠物

请从[完整教程](docs/tutorial.md)开始。最短流程是：

1. 先取得授权，并决定结果是否只保留在本地。
2. 选择 3–8 张清晰参考图，写一段简短的记忆说明。
3. 把“不能变的身份锚点”和“可以发挥的造型细节”分开。
4. 如果帽子、玩偶或其他配饰也像一张脸，让它与人物协同表达。
5. 用 `hatch-pet` 完成九种状态和十六个注视方向。
6. 在实际宠物尺寸下检查接触表和每行动画 GIF。
7. 除非所有相关人物都明确同意，否则不要把真人原始照片放进公开仓库。

## 隐私与授权

- 对仍在世的人，在使用和公开其形象前取得明确许可。
- 对纪念用途，默认把工作目录保持为私有；公开前与家人或权利人沟通。
- 不要模仿其声音，不要声称宠物能够代表本人发言，也不要未经允许使用私聊内容。
- 清除照片元数据；不要把原始照片、令牌、账号资料或私人聊天记录提交到公开仓库。

详见[隐私、授权与纪念用途](docs/privacy-and-consent.md)。

## 许可

技能与文字文档使用 [MIT License](LICENSE)。小龙帽示例美术与 spritesheet 只用于展示和个人安装，不包含在 MIT 授权中；请参阅[示例素材说明](examples/dragon-hood-girl/ASSET_NOTICE.md)。

## 写在最后

有些宠物只是可爱的角色；有些则像把一段熟悉的神情留在屏幕边。它不能替代任何人，不能装下一段完整的人生，也不应冒充谁继续说话。但当它带着许可、尊重和克制被做出来，那一小份温度可以继续陪在附近——提醒我们，曾经有人这样让我们感到快乐、安心，或者被爱。
