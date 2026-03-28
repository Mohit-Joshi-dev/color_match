# Color Match

A minimalist, high-fidelity Flutter Web clone of the popular color matching game, **dialed.gg**. 

Test your color perception skills by memorizing randomly generated targets and reconstructing them perfectly using Hue, Saturation, and Brightness (HSV) sliders.

## 🎮 How it Works

1. **Memorize**: You are presented with a randomly generated color tile and given a few seconds to visually commit it to memory.
2. **Reconstruct**: Using three distinct interactive sliders (Hue, Saturation, and Brightness), recreate the exact color you just saw.
3. **Review**: The game calculates the Euclidean distance between your guess and the target in RGB space, assigning a score out of 10.00.
4. **Snarky Feedback**: Depending on how accurate (or terribly inaccurate) your guess was, you'll receive dynamic, witty feedback ranging from "Human spectrophotometer" to "Were you even looking?".
5. **Final Tally**: After 5 rounds, an average score evaluates your overall color perception abilities.

## ✨ Key Features

- **Brutalist UI**: Centralized typography and flat, sleek design aesthetics mirroring premium modern web applications.
- **Dynamic Text Contrast**: Text overlaid on color blocks smartly shifts between pure white and pure black depending on the luminance of the target color to guarantee absolute readability.
- **Custom Slider Components**: Highly responsive, touch-friendly bespoke slider controls with accurate gradient tracks for absolute H/S/V precision without relying on generic Material UI sliders.
- **Robust Scoring Logic**: Mathematically precise color distance evaluation.

## 🏗️ Architecture

The codebase relies on a clean, scalable folder structure ensuring a direct separation of concerns:

- `lib/main.dart` - Entry point and application bootstrap.
- `lib/core/` 
  - `app_text_styles.dart` - Single source of truth for the application's Brutalist typography.
  - `color_utils.dart` - Stateless algorithms for color mathematical logic, contrast determination, and score calculations.
  - `constants.dart` - Configuration parameters (timer durations, score thresholds) and centralized witty feedback messages.
  - `theme.dart` - Global layout and component theming overrides.
- `lib/state/`
  - `game_controller.dart` - Core state machine (InheritedNotifier/ChangeNotifier pattern) governing round progression, scores, and active UI states.
- `lib/widgets/` 
  - `start_view.dart`, `memorize_view.dart`, `reconstruct_view.dart`, `round_result_view.dart`, `end_view.dart` - Pure UI components reacting exclusively to the Controller state.
  - `vertical_color_slider.dart` - Custom highly-performant slider implementations.

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (`^3.11.0` or higher recommended).

### Running locally
1. Clone the repository.
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Boot up the local web deployment server:
   ```bash
   flutter run -d chrome
   ```
   *(Or just hit `F5` in your preferred IDE!)*

## 🛠️ Built With
* **Flutter** - Cross-platform UI toolkit.
* **google_fonts** - Supplying the modern 'Inter' typeface.
* **url_launcher** - Safely bridging outside hyperlinks.
