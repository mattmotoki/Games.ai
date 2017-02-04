
var canvas = document.querySelector("#test-canvas");
var ctx = canvas.getContext("2d");

/* Draw Filled Dots */
function addPoint(pos, r) {
  ctx.save();
  ctx.beginPath();
  ctx.arc(pos[0], pos[1], r, 0, 2*Math.PI );
  ctx.fill();
  ctx.restore();
}

// upper right
ctx.save();
ctx.translate(110,10);
drawCorner();


// bottom right
ctx.translate(25,100);
ctx.rotate(Math.PI/2);
drawCorner();
ctx.restore();

// Test Corner
function drawCorner() {
  var p0 = [0, 0];
  var p1 = [25, 0];
  var p2 = [25, 25];

  // draw points
  addPoint(p0, 3);
  addPoint(p2, 3);

  // draw curve
  ctx.beginPath();
  ctx.moveTo(p0[0], p0[1]);
  ctx.bezierCurveTo(
    p0[0], p0[1],
    p1[0], p1[1],
    p2[0], p2[1]
  );
  ctx.stroke();


}
