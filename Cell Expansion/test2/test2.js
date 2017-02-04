
var canvas = document.querySelector("#test-canvas");
var ctx = canvas.getContext("2d");


drawCorner(0);
drawCorner(1);
drawCorner(2);
drawCorner(3);

// Test Corner
function upperRightCorner() {
  // draw curve
  ctx.beginPath();
  ctx.bezierCurveTo(-20, 0, 0, 0, 0, 20);
  ctx.stroke();
}

function drawCorner(i) {
  ctx.save();
  ctx.translate(100,100);

  if (i==0) { ctx.translate(100,0); }
  else if (i==1) { ctx.translate(100,100); }
  else if (i==2) { ctx.translate(0,100); }
  else if (i==3) { ctx.translate(0,0); }

  ctx.rotate(i*Math.PI/2);
  upperRightCorner();
  ctx.restore();
}
