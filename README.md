# DataTool

A Qt/C++ data processing tool.

## 构建错误说明 / Build Error Notes

### 错误：`cannot open ...\.jom for write`

**错误完整信息示例：**
```
:-1: error: cannot open C:\Users\胡晚清\AppData\Local\Temp\main.obj.19664.1172.jom for write
```

**原因：**  
此错误由 `jom`（Qt 在 Windows 上使用的并行构建工具）引起。当 Windows 用户名或临时目录路径中包含**非 ASCII 字符**（如中文），jom 无法在该路径下创建临时文件，从而导致构建失败。

**解决方法（任选其一）：**

1. **推荐：将 TEMP/TMP 环境变量修改为纯 ASCII 路径**

   在系统环境变量中，将 `TEMP` 和 `TMP` 的值修改为不含中文的路径，例如 `C:\Temp`：
   ```bat
   mkdir C:\Temp
   setx TEMP C:\Temp
   setx TMP C:\Temp
   ```
   修改后重启 Qt Creator 或命令行工具。

2. **使用提供的构建脚本 `build.bat`**

   项目根目录下提供了 `build.bat`，它会在构建前自动将 TEMP/TMP 设置为 `C:\Temp`，直接运行即可：
   ```bat
   build.bat
   ```

3. **在 Qt Creator 中切换构建工具为 `nmake`（非并行构建）**

   打开 Qt Creator → 项目 → 构建设置 → 构建工具，将 `jom` 更换为 `nmake`。  
   `nmake` 不使用 jom 的临时文件机制，可绕过此问题（但构建速度较慢）。  
   如遇到该路径错误，可先尝试此方法快速验证。

4. **创建新的 Windows 用户账号（纯 ASCII 用户名）**

   如果以上方法均不可行，可创建一个用户名不含中文的 Windows 账号，在该账号下进行开发。

---

## 构建说明 / Build Instructions

### 前置要求

- Qt 5.x / Qt 6.x（含 MSVC 或 MinGW 工具链）
- Windows 7 或更高版本

### 使用 qmake 构建

```bat
qmake DataTool.pro
jom        REM 或使用 nmake（如遇上述路径错误）
```

### 使用构建脚本

```bat
build.bat
```

---

## 项目结构 / Project Structure

```
DataTool/
├── DataTool.pro       # Qt qmake 项目文件
├── build.bat          # Windows 构建脚本（自动设置安全 TEMP 路径）
├── src/               # 源代码目录
│   └── main.cpp
└── README.md
```
