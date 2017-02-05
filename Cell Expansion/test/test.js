var canvas;
var bg_ctx;
var ctx;
var is_up=true;
var scale = 0.15;
var corner_points = [
  {x:200, y:450, theta:1*Math.PI/4, r:100},
  {x:250, y:500, theta:1*Math.PI/4, r:100},

  {x:450, y:500, theta:3*Math.PI/4, r:100},
  {x:500, y:450, theta:3*Math.PI/4, r:100},

  {x:500, y:250, theta:5*Math.PI/4, r:100},
  {x:450, y:200, theta:5*Math.PI/4, r:100},

  {x:250, y:200, theta:7*Math.PI/4, r:100},
  {x:200, y:250, theta:7*Math.PI/4, r:100}
];
var center_x=350;
var center_y=350;
init();

function init() {
  // background canvas
  bg_ctx = document.getElementById("static-canvas").getContext("2d");
  bg_ctx.strokeRect(200, 200, 300, 300);
  bg_ctx.stroke();
  drawGrid(bg_ctx);
  // for (i = 0; i <corner_points.length; i+=1) {
  //   drawDot(bg_ctx, corner_points[i].x, corner_points[i].y, 5, "blue");
  // }

  // dynamic canvas
  canvas = document.getElementById("dynamic-canvas");
  ctx = canvas.getContext("2d");
  canvas.addEventListener("mousemove", function(e) {updatePosition(e);}, false);
  canvas.addEventListener("mouseup",  function() { is_up = true; });
  canvas.addEventListener("mousedown", function(e) { is_up = false; updatePosition(e); });
  drawDot(ctx, center_x, center_y, 5, "black", true);
  drawScoringBean();
  // create event listener for resizing
  window.addEventListener("resize", resizeCanvas, false);
}

// utility functions
function resizeCanvas() {
  cancelAnimationFrame(requestId);
  canvas.height  = window.clientWidth;
  canvas.width  = window.clientHeight;
  requestId = animateAttractor();
}

function  getMousePos(event) {
  var rect = canvas.getBoundingClientRect(); // abs. size of element
  var scaleX = canvas.width / rect.width; // relationship bitmap vs. element for X
  var scaleY = canvas.height / rect.height;  // relationship bitmap vs. element for Y

  return {
    x: (event.clientX - rect.left) * scaleX,   // scale mouse coordinates after they have
    y: (event.clientY - rect.top) * scaleY     // been adjusted to be relative to element
  };
}

function updatePosition(event) {
  if (is_up) {return;}
  var coords = getMousePos(event);
  var tempx = coords.x;
  var tempy = coords.y;
  if (tempx<200 || tempx>500 || tempy<200 || tempy>500) { return;}
  center_x = tempx;
  center_y = tempy;

  ctx.save();
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  ctx.beginPath();
  ctx.moveTo(center_x, center_y);
  ctx.arc(center_x, center_y, 5, 2*Math.PI, false);
  drawDot(ctx, center_x, center_y, 5, "black", true);
  ctx.fill();

  drawScoringBean();
  ctx.restore();


}

function drawGrid(context) {
  context.save();
  context.globalAlpha = 1;
  context.strokeStyle = "#D3D3D3";
  context.setLineDash([5, 3]);
  for (i = 0; i < 9; i+=1) {
    context.fillText( i*100, 1+i*100, 710);
    context.fillText( i*100, 0, i*100);
    context.moveTo(i*100, 0);
    context.lineTo(i*100, 800);
    context.moveTo(0, i*100);
    context.lineTo(800, i*100);
  }
  context.stroke();
  context.fill();
  context.restore();
}

function drawDot(context, x, y, r, color, show_text) {
  // set defaults
  color = color || "black";
  show_text = show_text || false;

  context.save();
  context.moveTo(x, y);
  context.beginPath();
  context.fillStyle = color;
  context.arc(x, y, r, 0, 2*Math.PI, false);
  if (show_text) {
    context.fillText("(" + Math.round(x) + ", " + Math.round(y) + ")", x+5, y-5);
  }

  context.fill();
  context.stroke();
  context.restore();
}

function updateControlPoints() {
  for (i = 0; i <corner_points.length; i+=1) {
    row = corner_points[i];
    row.r = scale*Math.sqrt( Math.pow(row.y - center_y, 2) + Math.pow(row.x - center_x, 2) );
    row.theta = Math.atan2(row.y - center_y, row.x - center_x)-Math.PI/2;
  }
}

function drawScoringBean() {
  var row;
  var next_row;
  var last_cpx;
  var last_cpy;
  var xpy;
  var next_cpx;
  var next_cpy;
  var n_points = corner_points.length;
  updateControlPoints();
  for (i = 0; i <n_points; i++) {

    row = corner_points[i%n_points];
    next_row = corner_points[(i+1)%n_points];

    // calculate control points
    last_cpx = -row.r*Math.cos(row.theta) + row.x;
    last_cpy = -row.r*Math.sin(row.theta) + row.y;
    cpx = row.r*Math.cos(row.theta) + row.x;
    cpy = row.r*Math.sin(row.theta) + row.y;
    next_cpx = -next_row.r*Math.cos(next_row.theta) + next_row.x;
    next_cpy = -next_row.r*Math.sin(next_row.theta) + next_row.y;

    // plot start and end points and connecting Bezier curve
    ctx.save();
    ctx.beginPath();
    ctx.strokeStyle = "blue";
    ctx.moveTo(row.x, row.y);
    ctx.bezierCurveTo(cpx, cpy, next_cpx, next_cpy, next_row.x, next_row.y);
    ctx.stroke();
    ctx.restore();

    // plot control points and line
    // ctx.strokeStyle = "red";
    // drawDot(ctx, cpx, cpy, 5, "red", true);
    // drawDot(ctx, next_cpx, next_cpy, 5, "red", true);
    // ctx.beginPath();
    // ctx.moveTo(last_cpx, last_cpy);
    // ctx.lineTo(cpx, cpy);
    // ctx.stroke();
    // ctx.restore();
  }
}
