enum Direction {
  left(-1, 0),
  right(1, 0),
  top(0, -1),
  bottom(0, 1),

  // diagonals
  topLeft(-1, -1),
  topRight(1, -1),
  bottomLeft(-1, 1),
  bottomRight(1, 1);

  final int dx;
  final int dy;

  const Direction(this.dx, this.dy);
}