# Internal-Executor

A Roblox executor written in Luau that runs *from inside another executor*. Execute `VellumInternalExec.luau` once with your existing executor, and it gives you a second, self-contained environment for running scripts.

![License](https://img.shields.io/badge/license-GPL--3.0-blue.svg)
![Language](https://img.shields.io/badge/language-Luau-00A2FF.svg)

---

## Overview

Internal-Executor (Vellum) is a script that you load through a host executor. Once it is running, you can run further scripts through it without going back to the host's own interface.

## Features

> Edit this list to match what the script actually does.

- Runs from within another executor
- Execute Luau scripts in-game
- Simple, single-file setup (`VellumInternalExec.luau`)
- *(add your own: GUI, script hub, saved scripts, keybinds, etc.)*

## Requirements

- A working Roblox executor that supports `loadstring` and `game:HttpGet` (or your preferred way of loading a file)
- Roblox installed and running on a supported platform

## Installation & Usage

1. Open Roblox and join a game.
2. Attach your host executor.
3. Paste the following into the host executor and run it:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/cytrixgt/Internal-Executor/main/VellumInternalExec.luau"))()
```

Or copy the contents of [`VellumInternalExec.luau`](VellumInternalExec.luau) directly into the host executor and run it.

## Screenshots

Screenshots are in the [`images`](images) folder.

<!-- ![Preview](images/your-image.png) -->

## Repository Structure

```
Internal-Executor/
├── images/                    # Screenshots
├── LICENSE                    # GPL-3.0
├── README.md
└── VellumInternalExec.luau    # Main script
```

## Contributing

Issues and pull requests are welcome.

1. Fork the repository
2. Create a branch (`git checkout -b feature/your-feature`)
3. Commit your changes
4. Open a pull request

## Disclaimer

This project is provided as-is for educational purposes. Using third-party executors or scripts may violate the [Roblox Terms of Use](https://en.help.roblox.com/hc/en-us/articles/115004647846-Roblox-Terms-of-Use) and can result in account action. You are responsible for how you use it. The author is not affiliated with Roblox Corporation and accepts no liability for bans, data loss, or other consequences.

## License

Distributed under the [GPL-3.0 License](LICENSE).
