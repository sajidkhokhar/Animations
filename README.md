# Stateless AppearAnimation

A versatile SwiftUI animation utility that enables easy, reusable, and customizable appearance animations for any view in your SwiftUI projects.

---

## Table of Contents

- [Overview](#overview)  
- [Features](#features)  
- [Animations Explained](#animations-explained)  
- [Usage](#usage)  
- [Stateless Single-Line Animations](#stateless-single-line-animations)  
- [Improved Performance](#improved-performance)

---

## Overview

`AppearAnimation` is a SwiftUI animation utility designed to bring smooth, engaging, and customizable entrance animations to your app with minimal effort. The library abstracts common animation patterns like fade-ins, slides from various edges, scaling effects, bouncing, and combined animations, allowing you to create dynamic UI interactions effortlessly.

By simply applying a single modifier to a SwiftUI view, you can easily control how the view appears on the screen, with full customization over the animation’s timing, delay, easing curves, and other parameters. The flexibility of the modifier allows you to create various animation effects such as:

- **Fading** views in and out
- **Sliding** views from different edges (top, bottom, left, right)
- **Scaling** views from a particular size
- **Bouncing** and **popping** effects for lively interactions
- **Combined animations** for more complex transitions

Additionally, the library features a **tap scaling effect**, providing instant visual feedback on user interaction (perfect for buttons or interactive components). For precise UI control, you also have the option to apply custom X/Y offsets to fine-tune the positioning of your views.

---

## Features

- **Multiple animation styles**:  
  Includes fade, scale, slide, bounce, pop, combined effects, and more. These animations can be customized with delays, durations, and easing curves for more control over the effect.

- **Directional entrances**:  
  Animate views coming in from any of the four edges—top, bottom, left, or right. This is ideal for creating seamless transitions between views or UI elements.

- **Customizable animation properties**:  
  Full control over timing, duration, delays, and easing curves, allowing you to fine-tune the animations to suit your design requirements.

- **Tap scale feedback**:  
  Add visual feedback when the user taps on interactive views like buttons or icons. The view scales down and up briefly, providing instant interaction feedback.

- **Flexible offset positioning**:  
  Apply custom offsets to position your views precisely within the layout. Adjust for X and Y axis with a clean, easy-to-read syntax.

- **Clean and easy-to-use API**:  
  With simple modifiers, adding animations to your views is effortless. No complex setup or configuration is needed—just call `.appearAnimated()` and you're ready to go.

- **Extensible**:  
  You can easily extend the package with new animation styles or custom modifications without having to modify the core functionality.

- **Optimized performance**:  
  SwiftUI’s native animation support ensures hardware acceleration for smoother animations, resulting in minimal performance overhead. The lightweight, stateless animations are designed to be efficient and fast, even for complex animations with many views.

- **Support for interactive animations**:  
  Besides static entrance animations, the package also includes touch-related animations, such as the **tap scale effect**, which can be applied to any view for interactive feedback, making your app feel responsive and intuitive.

- **Minimal boilerplate code**:  
  Save time and reduce clutter in your SwiftUI code. With one-line modifiers for each animation style, the package keeps things clean and readable.

- **Built for SwiftUI**:  
  Native to SwiftUI, the library integrates seamlessly into your SwiftUI projects. No need for UIKit bridges or additional setup. Just import and start animating.

- **Fully customizable animation sequence**:  
  You can easily chain animations, adjust delay and timing, or combine different animation effects to create smooth, multi-step transitions.

- **Consistency and reusability**:  
  Once defined, animations can be reused across the app, ensuring consistent visual transitions and behavior.

- **Easy to adopt**:  
  Integrate animations in just a few lines of code. Whether you're animating a single element or a series of views, the syntax is intuitive and easy to learn.

- **Cross-device and cross-screen size compatibility**:  
  Animations are designed to work seamlessly on different device sizes and orientations, ensuring a consistent experience on all iPhones and iPads.

---

### Animations Explained

#### AppearAnimation Enum

Defines all supported animation styles:

| Animation Type             | Description | Example Animation |
|----------------------------|-------------|-------------------|
| `fade`                     | Simple fade-in opacity animation | ![fade](https://github.com/sajidkhokhar/Animations/blob/main/images/fade.gif) |
| `scale(from:)`             | Scale animation starting from specified scale | ![scale](https://github.com/sajidkhokhar/Animations/blob/main/images/scale.gif) |
| `center(scale:fade:)`      | Scale and optional fade animation from center | ![center](https://github.com/sajidkhokhar/Animations/blob/main/images/center.gif) |
| `fromTop`                  | Slide from the top with subtle scale and fade | ![fromTop](https://github.com/sajidkhokhar/Animations/blob/main/images/fromTop.gif) |
| `fromBottom`               | Slide from bottom with subtle scale and fade | ![fromBottom](https://github.com/sajidkhokhar/Animations/blob/main/images/fromBottom.gif) |
| `fromLeft`                 | Slide from left with subtle scale and fade | ![fromLeft](https://github.com/sajidkhokhar/Animations/blob/main/images/fromLeft.gif) |
| `fromRight\nfromBottom\nfromBottom\ncenter(scale:fade:)`                | Slide from right with subtle scale and fade | ![fromRight](https://github.com/sajidkhokhar/Animations/blob/main/AnimationResources/fromRight_and_center.gif) |
| `slide(from:)`             | Slide in from a specified `Edge` without scaling | ![slide](https://github.com/sajidkhokhar/Animations/blob/main/images/slide.gif) |
| `combined(from:scale:)`    | Slide + scale + fade combined effect | ![combined](https://github.com/sajidkhokhar/Animations/blob/main/images/combined.gif) |
| `bottomBounce`             | Bounce in from bottom | ![bottomBounce](https://github.com/sajidkhokhar/Animations/blob/main/images/bottomBounce.gif) |
| `bottomPop(scale:)`        | Pop animation rising from bottom with scale | ![bottomPop](https://github.com/sajidkhokhar/Animations/blob/main/images/bottomPop.gif) |
| `bottomFadeRise`           | Fade and rise from bottom | ![bottomFadeRise](https://github.com/sajidkhokhar/Animations/blob/main/images/bottomFadeRise.gif) |
| `bottomDrop(bounceHeight:)`| Drop animation with bounce effect from above | ![bottomDrop](https://github.com/sajidkhokhar/Animations/blob/main/images/bottomDrop.gif) |
| `TouchScaleEffect button`  | Scales the view when tapped. You can specify the scale factor and animation duration. | ![touchScale](https://github.com/sajidkhokhar/Animations/blob/main/images/touchScale.gif) |
| `Custom Offsets`           | You can apply custom offsets to your views for precise positioning. | ![customOffset](https://github.com/sajidkhokhar/Animations/blob/main/images/customOffset.gif) |
| `StretchableHeader`        | You can apply Custom StretchableHeader to your views. | ![StretchableHeader ](https://github.com/sajidkhokhar/Animations/blob/main/AnimationResources/StretchableHeader.gif) |

---

### TouchScaleEffect

The `TouchScaleEffect` allows you to add a visual scaling effect on tap. This is commonly used for buttons or interactive views where you want to give feedback on user interaction.

---

## Usage

### Example Usage

### Applying Appearance Animation

```swift
Text("Welcome")
.appearAnimated(.center(scale: 0.8, fade: true))

Text("Slide from Bottom")
    .appearAnimated(.fromBottom)

Text("Fade In")
    .appearAnimated(.fade)

Text("Scale from 0.5")
    .appearAnimated(.scale(from: 0.5))

Text("Floating Animation")
    .floating(.leftRight(amplitude: 15), speed: 2.0)

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

## Benefits of Stateless Animations

- **Simplicity**: Apply animations directly on views without needing to track visibility states.

- **Efficiency**: Single-line animations reduce boilerplate code and improve readability.

- **Performance**: Optimized for better app performance, especially when used on views with frequent state changes.

---

## Improved Performance

The animations are lightweight and designed with performance in mind. By utilizing SwiftUI’s native view modifiers, the animations are hardware accelerated, meaning your app can run smoothly even with complex animation effects. Additionally, by minimizing the need for multiple state updates or excessive view redraws, these animations can lead to smoother transitions and improved frame rates.

By using the library’s stateless approach and avoiding excessive state management, the animations remain highly efficient and reduce unnecessary computations.




