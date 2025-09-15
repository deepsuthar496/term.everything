


<table>
  <tr>
    <td valign="middle">
      <img width="128" height="128" alt="icon2" src="./resources/icon.png" />
    </td>
    <td><h1>Term.Everything❗</h1></td>
    <td><a href="#-native-linux-setup-no-docker-required">🚀 Native Setup</a></td>
    <td><a href="./SETUP.md">📖 Setup Guide</a></td>
    <td><a href="./resources/HowIDidIt.md">HowIDidIt.md</a></td>
  </tr>
  <tr>
    <td></td>
    <td>Works on both x11 and Wayland host systems.</td>
    <td><strong>No Docker Required!</strong></td>
    <td></td>
    <td></td>
  </tr>
</table>

## Run every GUI app in the terminal!

![warp_into_terminal0001-0195](./resources/graphics/warp_in_2.gif)

## Even over ssh!
Behold as I play a [video game in a font](https://github.com/mmulet/font-game-engine) in a web browser in a terminal transmitted over ssh (with one hand tied behind my back)!

![ssh_example](./resources/graphics/ssh_example.gif)

### Read about how it works!
Check out [HowIDidIt.md](./resources/HowIDidIt.md)

## More Examples
The quality of the window is now much improved with the new high-quality rendering system.
Default resolution has been increased to 1920x1080 with enhanced character sets and dithering
for much better visual quality. You can further customize quality vs performance with:

```bash
# Maximum quality (slower but looks great)
./term.everything --quality ultra firefox

# Performance mode (faster for older systems)  
./term.everything --quality low firefox

# Custom resolution for your terminal
./term.everything --virtual-monitor-size 2560x1440 firefox
```

If you increase the terminal resolution (ctrl - in alacritty, check your
terminal) the quality will go up even further, (but performance may go down).

Here I open up the Wing It! movie, and increase the quality until I get both
a good frame rate and resolution:

![increase resolution](./resources/graphics/show_increase_res.gif)

----------------

If your terminal supports images (like [kitty](https://sw.kovidgoyal.net/kitty/)
or [iterm2](https://iterm2.com/)) you can render windows at full resolution
(performance may degrade).

In this example, on my mac, I open iTerm2 ssh into ubuntu and open firefox
at full resolution:

![full_resultion](resources/graphics/full_resultion.gif)

------------

I feel like every single day I hear about another terminal file viewer. I say, stop making terminal file viewers because you can just use the file viewer you already have! In your terminal!

![file_manager](./resources/graphics/file_manager.gif)

-------------

Terminal in a terminal in a terminal in a terminal in a terminal.... it's terminals all the way down.
![terminal_in_terminal](./resources/graphics/terminal_in_terminal.gif)

-------------
With only a small amount hacking, it can run Doom (shareware episode)!

![Doom](./resources/graphics/doom.gif)


## About
`term.everything❗` is a Linux CLI program to run GUI windows in your terminal. Specifically, `term.everything❗` is a built-from-scratch [Wayland](https://wiki.archlinux.org/title/Wayland) compositor that outputs to a terminal rather than your monitor.

>Don't know what Wayland is or just want to know more about how this works? Then, head over to [HowIDidIt.md](./resources/HowIDidIt.md) where I will explain how everything works in detail.

## Try it out!

### 🚀 Native Linux Setup (No Docker Required!)
**NEW**: Run natively on Linux, Debian, Kali and other distributions:

```bash
git clone https://github.com/deepsuthar496/term.everything.git
cd term.everything
./install.sh
./term.everything firefox
```

📖 **[Complete Setup Guide](./SETUP.md)** - Detailed instructions for native installation

💡 **Having issues?** Run `./troubleshoot.sh` to diagnose problems quickly

### 📦 Pre-built Releases
[Download the beta test now!](https://github.com/mmulet/term.everything/releases)

## Roadmap
1. [x] Term some things <--- This is where we are at
  - Some apps or (even most apps) may fail to launch or even crash! Please create [an issue]( https://github.com/mmulet/term.everything/issues) if you have problems.
2. [ ] Term most things
3. [ ] Term everything❗

## Help and Usage
Check out the [help file here](./resources/help.md) for a usage guide on how to use `term.everything❗`

## Contributing
term.everything❗ is written in developer friendly [Typescript](https://www.typescriptlang.org/) using the [bun](https://bun.com/) engine, with a just a smidge of C++.

### 🐳 Docker Development (Original Method)
See [./Contributing.md](./Contributing.md).

### 🖥️ Native Development (New Method)
For native development without Docker:
1. Run `./install.sh` to set up your development environment
2. Use `./build-native.sh` to build the project
3. See **[SETUP.md](./SETUP.md)** for detailed development instructions

## Legal:

term.everything❗ copyright 2025 Late for Dinner Studios, LLC
---
Fontemon copyright 2021 Late for Dinner Studios, LLC
---
Wing It! movie is licensed under the Creative Commons Attribution 4.0 license
[Wing it licensing page](https://studio.blender.org/projects/wing-it/pages/licensing/)
Attribution:
(CC) Blender Foundation | studio.blender.org
---
Doom shareware episode is copyright 1993 id Software
---

## Bonus:
This is Gwerm the Term Worm.

![this is gwern](./resources/graphics/this_is_gwern.gif)

He is doing okay. Thanks for asking.
