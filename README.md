# kb — 智能终端课表工具

在终端查看大学课表，无需每次打开浏览器登录教务系统。

## 快速安装

打开 PowerShell，复制粘贴以下命令：

```powershell
irm https://github.com/ME366666/kb/releases/latest/download/install.ps1 | iex
```

安装完成后，关闭当前终端重新打开，运行 `kb init` 开始使用。

> 安装目录为 `C:\Users\<用户名>\.kb-bin\`，会自动加入 PATH。

## 初始化

```
kb init
```

1. 打开浏览器访问教务系统并登录
2. 进入「我的课表」页面
3. 按 F12 → Network → 筛选 `getMyScheduleDetail`
4. 复制 Response 全部内容粘贴到终端，连按两次回车
5. 输入学期第一天日期（如 `2026-03-01`）
6. 选择主题和吉祥物
7. 注意如果步骤3，筛选后没有显示，就刷新页面，重新点击进我的课表页面

数据存储在 `~/.kb/`，任意目录运行 `kb` 均可查看课表。

## 功能

### 查询

| 命令 | 说明 |
|---|---|
| `kb` | 今天课表 |
| `kb today` | 今天课表 |
| `kb tomorrow` | 明天课表 |
| `kb yesterday` | 昨天课表 |
| `kb day 2026-06-30` | 指定日期 |
| `kb week` | 当前周课表 |
| `kb week 8` | 第 N 周课表 |
| `kb current` | 正在上的课 |
| `kb next` | 下一节课 |
| `kb search 数据库` | 搜索课程/教师/地点 |
| `kb all` | 全部课表 |
| `kb meta` | 学期信息 |

### 编辑

| 命令 | 说明 |
|---|---|
| `kb edit add <名> <代码> <教师> <星期> <开始节> <结束节> <地点>` | 添加课程 |
| `kb edit remove <sessionId>` | 删除课程 |
| `kb edit modify <sessionId> location <新地点>` | 修改地点 |
| `kb edit modify <sessionId> teacher <新教师>` | 修改教师 |
| `kb edit week <sessionId> <周次> cancel` | 单周停课 |

### 配置

| 命令 | 说明 |
|---|---|
| `kb config` | 查看配置 |
| `kb config set theme dark` | 切换主题 (default/dark/warm) |
| `kb config set mascot dog` | 切换吉祥物 (cat/dog) |
| `kb config set semesterStartDate 2026-03-01` | 修改学期开始日 |

## 更新课表

学期中课表有变动时，重新运行 `kb init` 导入最新 JSON 即可覆盖旧数据。
