# Identification

* **Game:** Isaac
* **Group:** Isaac_4,
* **Group members:** 
- João Pedro Antão Sobral , up202108736, 50%
- João Tomás Matos Fernandes Garcia Padrão, up202108766, 50%

# Description of the game

Isaac is played on a 10x10 board.  There are two players: Dark and Light. Each player has 15 rectangular tiles of 5 different sizes (5 pieces with score one, 4 pieces with score two, 3 pieces with score three, 2 pieces with score four and 1 last piece with score six). The game has two phases, the placement phase and the scoring phase. 

### Placement Phase: 
* The game starts with an empty board and players alternative place their tiles on the unoccupied cells of the board.If a player cannot place any remaining tiles, they pass, and the opponent continues. The placement phase ends when both player don't have more space on the board.

### Scoring Phase:

* The scoring phase begins with both players at 0 points. The scoring phase starts with the player who passed in the placement phase. Player take turns removing tiles from the board. A player can only remove a tile as long as their previously tile removed. A tile under the score counter cannot be removed. This phase ends when a player reach at least 100 points. If a player cannot remove any tile he passes and he is out of the game. The game ends when the both player have passed. If the players ends with the same points, each player forms a line with all the remaining pieces from the placement phase and the player with the longest line wins. If the lines has the same length, the player who started the game win.

### Calculating Points:

* The points are calculated when tile is removed:
- The total number of tiles remaining on the line from which the tile was removed.
- This count is multiplied by the score of the tile removed.
- If a score counter is on the same line, the result is multiplied by 2, or by 4 if the both players have the score counter on that line.

