# OpenSCAD Modeling - Copilot Instructions

## Repository Overview

This repository contains OpenSCAD 3D models for 3D printing, organized by project. Models range from small utility parts (USB storage, pegboard hooks) to complex assemblies (socket trays, gridfinity bins). Models are designed to be printable and often use external OpenSCAD libraries for advanced features.

## Project Structure

- **Root directories** (e.g., `Usb/`, `Storage/`, `Gridfinity/`): Project-specific models. Each project may contain one or more `.scad` files.
- **`Models/`**: Reusable modules and utility components (beveled corners, hollow cylinders, parametric rings) used across projects via `use` statements.
- **`Powershell/`**: Scripts for managing library dependencies.

## Key Libraries and Dependencies

External libraries are required for many models. They should be placed at the OpenSCAD default library location: `C:\Program Files\OpenSCAD\libraries`

**Required Libraries:**
- **Obiscad**: Bevels and 3D primitives - https://github.com/Obijuan/obiscad
- **BOSL**: Bolt Standard Library - https://github.com/revarbat/BOSL
- **Bolts**: Mechanical parts - https://github.com/boltsparts/BOLTS_archive
- **Threads**: Screw/thread generation - https://github.com/rcolyer/threads-scad
- **Gridfinity Rebuilt**: Modular storage system - https://github.com/chylinski/gridfinity-rebuilt-openscad

**Setup Libraries:**
```powershell
# Run from repository root (requires admin privileges)
.\Powershell\DownloadLibraries.ps1
```

This script downloads and installs all required libraries to the OpenSCAD default location. Admin privileges are required to write to `C:\Program Files\OpenSCAD\libraries`.

## Working with OpenSCAD Files

### Opening and Rendering Models
- Use OpenSCAD GUI (Windows desktop app) to open `.scad` files
- Render to preview 3D output: `F5` or Design menu → Render
- Export to STL for 3D printing: `Ctrl+E` or File → Export as STL

### Module Organization Patterns

**File Dependencies (use vs include):**
- `use <path>`: Imports modules from another file (preferred for most cases)
- `include <library>`: Imports full library with all definitions (used for external library configurations)

**Examples from codebase:**
```scad
use <obiscad/obiscad/bevel.scad>      // External library module
use <../Models/BevelCorner.scad>      // Reusable module from Models/
include <gridfinity-rebuilt/src/core/standard.scad>  // Library configuration
```

### Common Patterns

**Parametric Configuration:**
Models often use OpenSCAD's "Customizer" feature with sections like `/* [Base Hole Options] */` to expose parameters. These parameters can be customized in the OpenSCAD GUI.

**Module Naming Convention:**
- Project-specific modules: `noun` format (e.g., `usb_bevel`, `createTray`, `socketBase`)
- Utility functions: descriptive, functional names (e.g., `renderBases`, `bundle_hole_options`)

**Coordinate System:**
- OpenSCAD uses XYZ coordinates with standard right-hand rule
- Most models assume bottom-left-back origin (false parameter in cubes/shapes)
- Measurements in millimeters (mm) by convention for 3D printing compatibility

## Iterative Workflow

1. **Edit** `.scad` file in OpenSCAD or text editor
2. **Reload** in OpenSCAD: `F4` or press "Reload and Compile"
3. **Preview** 3D output: `F5`
4. **Adjust parameters** via Customizer or code until satisfied
5. **Export to STL** when ready for printing

## File Naming and Organization

- Model files use **descriptive names**: `SocketTray.scad`, `GateSensorMount.scad`, `BevelCorner.scad`
- Reusable modules go in `Models/` directory
- Each project/product gets its own directory (e.g., `Gridfinity/`, `Storage/`)
- **Avoid committing**: `.stl`, `.GCODE`, `.zip`, `.tar.gz` files (handled by `.gitignore`)

## Tips for Modifications

- **Keep modules modular**: Extract reusable geometry into `Models/` to avoid duplication
- **Use clear parameters**: Make variables descriptive and comment non-obvious measurements
- **Test incrementally**: Render after each logical change to catch errors early
- **Reference measurements**: Include spec comments (e.g., USB height, diameter tolerances) when modeling real-world parts
- **Document transformations**: Use comments for complex `translate()`, `rotate()`, and compound operations
