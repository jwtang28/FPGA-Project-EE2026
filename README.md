# FPGA Dinosaur Game - EE2026 Project

A FPGA-based implementation of a dinosaur running game, similar to the Chrome offline dinosaur game, developed for the EE2026 Digital Design course.

## Overview

This project implements a classic endless runner game featuring a dinosaur character that must jump over obstacles. The game is built using Verilog and VHDL on the Digilent Basys3 FPGA board, featuring an OLED display for graphics, PS2 mouse input for controls, and various game states including welcome screen, character/world selection, gameplay, and game over.

## Features

- **OLED Display Graphics**: 128x64 pixel monochrome OLED display showing game graphics
- **PS2 Mouse Control**: Mouse input for character jumping and menu navigation
- **Multiple Game States**:
  - Welcome screen with scrolling message
  - Character selection
  - World selection
  - Main gameplay
  - Game over screen
- **Animated Elements**:
  - Jumping dinosaur character with multiple animation frames
  - Scrolling background (clouds, grass, mountains)
  - Moving obstacles
- **7-Segment Display**: Shows game score and status
- **LED Indicators**: Visual feedback for game state
- **Push Button Controls**: Alternative input method

## Hardware Requirements

- Digilent Basys3 FPGA Board
- Pmod OLED (connected to JB port)
- PS2 Mouse (connected to PS2 ports)
- Vivado Design Suite 2023.1 or later

## Module Hierarchy

The project follows a hierarchical design with the following module structure:

```
gametop.v (Top-level module)
├── scrolling_welcome_message.v
│   ├── Oled_Display.v
│   └── clk_divider.v (clk_divider module)
├── oled (oleddisp.v) - Main gameplay module, displays all the sprites on the oled
│   ├── lfsr (bitstream.v) - Random bitstream generator
│   ├── MouseCtl (Mouse_Control.vhd) - PS2 mouse controller
│   ├── clk_divider.v (clk_divider module) - OLED clock divider
│   ├── Oled_Display.v - OLED display driver
│   ├── coor.v - Coordinate conversion utilities
│   ├── grass.v - Grass background rendering
│   ├── clk_freq_divider.v (from clk_divider.v) - Scrolling animation clock generator
│   ├── mount.v - Mountain background rendering
│   ├── cloud.v - Cloud background rendering
│   ├── char.v - Dinosaur character rendering
│   └── obstacles.v - Obstacle generation and collision detection
├── scrolling_game_over_message.v
│   ├── Oled_Display.v
│   └── clk_divider.v (clk_divider module)
├── chara_select_border.v - Character selection interface
│   ├── coor.v
│   ├── Oled_Display.v
│   └── clk_divider.v (clk_divider module)
├── world_select_border.v - World selection interface
│   ├── Oled_Display.v
│   └── clk_divider.v (clk_divider module)
├── scrolling_world_select_message.v
│   ├── Oled_Display.v
│   └── clk_divider.v (clk_divider module)
└── scrolling_chara_select_message.v
    ├── Oled_Display.v
    └── clk_divider.v (clk_divider module)
```

## File Structure

```
dinosaur.srcs/
├── sources_1/
│   ├── imports/
│   │   ├── Desktop/
│   │   │   ├── clk_divider.v          # Clock divider modules (clk_divider, clk_freq_divider)
│   │   │   ├── Mouse_Control.vhd      # PS2 mouse interface (VHDL)
│   │   │   ├── Oled_Display.v         # OLED display driver
│   │   │   └── Ps2Interface.vhd       # PS2 protocol interface (VHDL)
│   │   └── new/
│   │       ├── chara_select_border.v
│   │       ├── scrolling_chara_select_message.v
│   │       ├── scrolling_game_over_message.v
│   │       ├── scrolling_welcome_message.v
│   │       ├── scrolling_world_select_message.v
│   │       └── world_select_border.v
│   └── new/
│       ├── bitstream.v                # LFSR random bitstream generator
│       ├── char.v                     # Dinosaur character logic
│       ├── cloud.v                    # Cloud background elements
│       ├── coor.v                     # Coordinate system utilities
│       ├── gametop.v                  # Top-level module
│       ├── grass.v                    # Grass platform elements
│       ├── mount.v                    # Mountain background elements
│       ├── obstacles.v                # Game obstacles
│       └── oleddisp.v                 # Main OLED display controller
├── constrs_1/
│   └── new/
│       └── basys3.xdc                 # Basys3 board constraints
python_img_sprite_generator/           # Sprite generation tools
├── sprite_generator.ipynb             # Jupyter notebook for image-to-sprite conversion
├── zhong.png                          # Sample input image
├── BadApple.gif                       # Sample animated GIF
└── zhong.v                            # Generated Verilog sprite module
```

## Setup and Installation

1. **Clone or Download** the project files to your local machine

2. **Open Vivado**:
   - Launch Vivado Design Suite
   - Open the project file: `dinosaur.xpr`

3. **Generate Bitstream**:
   - In Vivado, go to Flow → Generate Bitstream
   - Wait for synthesis and implementation to complete

4. **Program the FPGA**:
   - Connect your Basys3 board to your computer
   - In Vivado, go to Flow → Program Device
   - Select the appropriate hardware target
   - Click Program

## Usage

1. **Power on** the Basys3 board
2. **Connect peripherals**:
   - Pmod OLED to JB port
   - PS2 Mouse to PS2 ports
3. **Start the game**:
   - The welcome screen will display
   - Use mouse or buttons to navigate menus
   - Click or press buttons to jump during gameplay
4. **Gameplay**:
   - Avoid obstacles by jumping
   - Score increases as you progress
   - Game ends when you hit an obstacle

## Controls

- **Mouse**: Primary control for jumping and menu navigation
- **Push Buttons**:
  - BTNL/BTNR: Navigate menus
  - BTNC: Select/Confirm
  - BTND: Jump (alternative to mouse)
  - BTNU: Special actions
- **Switches**: Game configuration (SW[0], SW[1], SW[2])

## Technical Details

- **FPGA Device**: Xilinx Artix-7 (XC7A35T-1CPG236C)
- **Clock Frequency**: 100 MHz system clock
- **Display**: 128x64 OLED via SPI interface
- **Input**: PS2 mouse protocol
- **Languages**: Verilog (majority), VHDL (PS2 interface)
- **Design Approach**: Modular design with separate modules for graphics, input, and game logic

## Development Notes

- Developed using Vivado 2023.1
- Tested on Basys3 board with Pmod OLED
- Clock dividers used for timing various game elements
- State machine implementation for game flow control
- Custom character graphics stored as bitmaps

## Sprite Generator Tool

The `python_img_sprite_generator/` directory contains a Python-based tool for automatically converting images and GIFs into Verilog sprite modules for FPGA display.

### Features

- **Image Processing**: Converts PNG/GIF images into FPGA-compatible sprite data
- **Color Quantization**: Uses PIL library to reduce colors for efficient FPGA storage
- **Multiple Quantization Modes**: Supports various color quantization algorithms (median cut, maximum coverage, with/without k-means)
- **Verilog Generation**: Automatically generates complete Verilog modules with sprite data
- **OLED Display Format**: Outputs 16-bit color format compatible with the project's OLED display

### Usage

1. Open `sprite_generator.ipynb` in Jupyter Notebook
2. Modify the configuration variables:
   - `imfile`: Input image filename
   - `filename`: Output Verilog filename
   - `modulename`: Verilog module name
   - `sprite_width`/`sprite_height`: Output sprite dimensions
3. Run the notebook cells to generate the sprite module
4. The generated `.v` file can be integrated into the FPGA project

### Requirements

- Python 3.x
- PIL (Pillow) library
- NumPy
- Jupyter Notebook

### Example Output

The tool generates Verilog modules like `zhong.v` with:
- Bitmap data stored as wire arrays
- Alpha channel support for transparency
- Coordinate-based pixel lookup logic
- 16-bit RGB565 color format

This tool significantly simplifies the process of adding custom sprites and graphics to FPGA projects, replacing manual bitmap creation with automated image processing.

### Aknowledgements
Special thanks to:
- EE2026 Digital Design course instructors and teaching assistants
- My project teammates, Jasmin, WeiZhi and Kit
- https://github.com/nvbinh15/FPGA-Project-EE2026/tree/main/Python_helpers for inspring the idea of using python to convert image files into verilog sprites
