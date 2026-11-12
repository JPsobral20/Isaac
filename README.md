# Isaac

Isaac is a two-player strategic board game implemented in **Prolog** as part of the Logic and Functional Programming course at the Faculty of Engineering of the University of Porto (FEUP).

The game is played on a 10×10 board and consists of two main phases: **Placement** and **Scoring**. Players strategically position rectangular pieces and subsequently remove them to accumulate points.

## Game Overview

- **Language:** Prolog
- **Game mode:** Player vs. Player
- **Board size:** 10×10
- **Players:** Dark and Light
- **Interface:** Command-line interface

### Pieces

Each player starts with 15 rectangular pieces, distributed across five different scoring values.

| Piece Score | Number of Pieces | Length (Board Cells) |
|---|---:|---:|
| 1 | 5 | 3 |
| 2 | 4 | 4 |
| 3 | 3 | 5 |
| 4 | 2 | 6 |
| 6 | 1 | 7 |
| **Total** | **15** | |

## Game Phases

### 1. Placement Phase

The game starts with an initial 10×10 board containing predefined unavailable positions.

Players take turns placing their rectangular pieces on available positions.

- Each piece must fit entirely within the board.
- Pieces can be placed horizontally or vertically.
- All cells occupied by a piece must be available.
- Players choose the piece, its starting position and its orientation.
- A player must pass when no remaining piece can be placed.

The placement phase ends when neither player can make another move.

### 2. Scoring Phase

After the placement phase, players take turns removing pieces from the board.

- Players can only remove pieces belonging to them.
- The selected piece must be eligible for removal according to the game's rules.
- Players accumulate points based on the removed piece and the remaining pieces in its line.
- A player who cannot make a valid move must pass.

The scoring phase continues until a player reaches at least 100 points or neither player can make another move.

## Scoring System

The score obtained from removing a piece is calculated using three factors:

1. The scoring value of the removed piece.
2. The number of pieces remaining in the corresponding line.
3. A multiplier determined by the presence of score counters in that line.

The multiplier is defined as follows:

| Score Counters in the Line | Multiplier |
|---|---:|
| No counters | ×1 |
| One counter | ×2 |
| Two counters | ×4 |

The scoring formula is:

\[
\text{Points} =
\text{Piece Value} \times
\text{Remaining Pieces} \times
\text{Multiplier}
\]

## Project Structure

The project is organized into several Prolog source files, separating the game logic, board representation, user interaction and individual game phases.

| File | Responsibility |
|---|---|
| `isaac.pl` | Main entry point and loading of the game modules |
| `menu.pl` | Main menu and game mode selection |
| `logic.pl` | Main game flow, phase coordination and winner determination |
| `display.pl` | Initial board, player pieces, piece properties and board rendering |
| `managePlacementPhase.pl` | Piece selection, placement validation and board updates |
| `manageScoringPhase.pl` | Piece removal, move validation and score calculation |

## Getting Started

### Prerequisites

- A Prolog interpreter, preferably **SWI-Prolog**.

### Running the Game

1. Clone the repository

2. Navigate to the project directory:

   ```bash
   cd Isaac
   ```

3. Start SWI-Prolog with the main source file:

   ```bash
   swipl -s isaac.pl
   ```

4. Start the game by executing:

   ```prolog
   play.
   ```

5. Select the Player vs. Player option from the main menu to begin.

## Current Implementation

The project includes the core logic for the Player vs. Player game mode, including board initialization, piece placement, move validation, scoring and winner determination.

The menu also displays Player vs. Computer, Computer vs. Computer and Rules options. However, these options are not fully implemented in the current version.

## Authors

Developed as an academic project for the Logic and Functional Programming course at FEUP.

| Name | Student Number | Contribution |
|---|---|---:|
| João Pedro Antão Sobral | up202108736 |
| João Tomás Matos Fernandes Garcia Padrão | up202108766 |

---

*Academic project developed at the Faculty of Engineering of the University of Porto (FEUP).* 
