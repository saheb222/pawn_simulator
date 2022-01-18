# Pawn Simulator

### Run application

```bash
git clone https://github.com/saheb222/pawn_simulator.git
cd pawn_simulator
bundle install
ruby main.rb
```
### Exit from the application
provide "q" (command) while asking for the input to exit anytime from the application
### Run test

Inside the project path and run `bundle exec rspec`

## Description

* The application is a simulation of a Pawn moving on a chess board, of dimensions 8 squares x 8 squares.

* There are no other obstructions/pieces on the chess board.

* The pawn is free to roam around the surface of the table following the rules below, but must be prevented from falling off. Any movement that would result in the pawn falling from the table must be prevented, however further valid movement commands must still be allowed.

Create an application that can read in commands of the following form:
```
PLACE X,Y,F,C
MOVE X
LEFT
RIGHT
REPORT
```

* `PLACE` will put the pawn on the board in position X,Y and facing NORTH, SOUTH, EAST or WEST and color(White or Black).

* The origin (0,0) can be considered to be the **SOUTH WEST** most corner.

* The first valid command to the pawn is a `PLACE` command, after that, any sequence of commands may be issued, in any order, including another `PLACE` command. The application should discard all commands in the sequence until a valid `PLACE` command has been executed

* `MOVE` and `MOVE 1` will move the pawn one unit forward in the direction it is currently facing.

* `MOVE 2` will move the pawn two units forward in the direction it is currently facing.

* `MOVE 1` and `MOVE 2` are only permissible for very first move, for later movement 'MOVE' is valid.

* `LEFT` and `RIGHT` will rotate the pawn 90 degrees in the specified direction without changing the position of the pawn.

* `REPORT` will announce the X,Y,F,C of the pawn.

* If the pawn is not on the board, it needs to ignore the `MOVE`, `LEFT`, `RIGHT` and `REPORT` commands.

* Provided test data to exercise the application.

### Constraints

* The pawn must not fall off the table during movement. This also includes the initial placement of the pawn.

* Any move that would cause the pawn to fall must be ignored.

### Example Input and Output:

#### Example a

    PLACE 0,0,NORTH,WHITE
    MOVE 1
    REPORT

Expected output:

    0, 1, NORTH, WHITE

#### Example b

    PLACE 0,0,NORTH,BLACK
    LEFT
    REPORT

Expected output:

    0, 0, WEST, BLACK

#### Example c

    PLACE 1,2,EAST,BLACK
    MOVE 2
    MOVE 1
    LEFT
    MOVE
    REPORT

Expected output

    3, 3, NORTH, BLACK
