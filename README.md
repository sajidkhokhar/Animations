# AppearAnimation

A versatile SwiftUI animation utility that enables easy, reusable, and customizable appearance animations for any view in your SwiftUI projects.

---

## Table of Contents

- [Overview](#overview)  
- [Features](#features)  
- [Animations Explained](#animations-explained)  
- [Usage](#usage)  

---

## Overview

`AppearAnimation` simplifies adding polished entrance animations to SwiftUI views. It abstracts common animation patterns like fade-ins, slides from different edges, scaling, bouncing, and combined effects. By applying a single modifier, you can control how a view appears, including animation timing, delay, and easing.

The package also includes a tap scaling effect to provide visual feedback on user interaction and a flexible offset helper for precise view positioning.

---

## Features

- **Multiple animation styles:** fade, scale, slide, bounce, pop, combined effects  
- **Directional entrances:** animations from top, bottom, left, right  
- **Customizable:** control delay, duration, and animation curve/easing  
- **Tap scale feedback:** visually scale views on tap gestures  
- **Flexible offset:** apply custom X/Y offsets with easy syntax  
- **Clean API:** straightforward modifiers for quick adoption  
- **Extensible:** add new animation styles easily  

---

## Animations Explained

### AppearAnimation Enum

Defines all supported animation styles:

| Case                    | Description                                                  |
|-------------------------|--------------------------------------------------------------|
| `fade`                  | Simple fade-in opacity animation                             |
| `scale(from:)`          | Scale animation starting from specified scale               |
| `center(scale:fade:)`   | Scale and optional fade animation from center                |
| `fromTop`               | Slide from the top with subtle scale and fade               |
| `fromBottom`            | Slide from bottom with subtle scale and fade                |
| `fromLeft`              | Slide from left with subtle scale and fade                  |
| `fromRight`             | Slide from right with subtle scale and fade                 |
| `slide(from:)`          | Slide in from a specified `Edge` without scaling            |
| `combined(from:scale:)` | Slide + scale + fade combined effect                         |
| `bottomBounce`          | Bounce in from bottom                                        |
| `bottomPop(scale:)`     | Pop animation rising from bottom with scale                  |
| `bottomFadeRise`        | Fade and rise from bottom                                    |
| `bottomDrop(bounceHeight:)` | Drop animation with bounce effect from above              |

---

## Usage

### Applying Basic Appearance Animation

```swift
Text("Welcome")
.appearAnimated(.center(scale: 0.8, fade: true))
//.appearAnimated(.fade) 
//.appearAnimated(.bottomBounce)



```
### Using Tap Scale Effect for Buttons or Interactive Views
```swift
Image(systemName: "star.fill")
    .appearAnimated(.combined(from: .bottom, scale: 0.7), delay: 0.3, duration: 0.6, curve: .easeOut)
```

### Custom Offsets Using OffsetDirection Enum
```swift
Text("Custom Offset")
    .offset(.custom(up: 10, right: 15))
```




