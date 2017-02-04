(function() {
  var n = 3,
  margin = 10,
  board = document.querySelector("#board"),
  ctx = board.getContext("2d"),
  container = document.querySelector("#board-container"),
  board_size = Math.min(
    container.clientWidth,
    container.clientHeight
  ),
  bezier_list = [
    [1.0, 2.1, 1.0, 2.0, 1.1, 2.0],
    [1.1, 2.0, 1.5, 2.1, 1.9, 2.0],
    [1.9, 2.0, 2.0, 2.0, 2.0, 2.1]
  ];


  // initialize
  window.addEventListener("load", resizeCanvas, false);
  window.addEventListener("resize", resizeCanvas, false);
  resizeCanvas();
  function resizeCanvas() {
    board_size = Math.min(
      container.clientWidth,
      container.clientHeight
    );
    ctx.canvas.height  = board_size;
    ctx.canvas.width  = board_size;
    redraw();
  }


  function redraw() {
    drawGrid();

    // drawOutline(bezier_list);

    var seg = [1.0, 1.1, 0.9, 1.1, 1.1, 0.9, 1.1, 1].map(scale);
    ctx.save();
    ctx.beginPath();
    ctx.moveTo(seg[0], seg[1]);
    ctx.bezierCurveTo(seg[2], seg[3], seg[4], seg[5], seg[6], seg[7]);
    for (var i=1; i<3; i+=1) {
      // drawDot(seg[2*i], seg[2*i+1]);
    }
    ctx.stroke();
    ctx.restore();
    console.log(seg);
  }

  function drawOutline(bezier_list) {
    var seg = bezier_list[0]
    ctx.save();
    ctx.beginPath();
    ctx.moveTo(scale(seg[0]), scale(seg[1]));
    bezier_list.forEach(function(seg) {
      seg_px = seg.map(scale);
      ctx.quadraticCurveTo(seg_px[2], seg_px[3], seg_px[4], seg_px[5]);
    })
    ctx.stroke();
    ctx.fill();
    ctx.restore();
  }


  function drawGrid() {
    ctx.save();
    ctx.beginPath();
    ctx.strokeStyle = "#D3D3D3";
    for (var i = 0; i < n+1; i+=1) {
      i_px = scale(i);
      n_px = scale(n);
      ctx.moveTo(i_px, margin);
      ctx.lineTo(i_px, n_px);
      ctx.moveTo(margin, i_px);
      ctx.lineTo(n_px, i_px);
    }
    ctx.stroke();
    ctx.restore();
  }

  function drawDot(x, y, r=scale(0.05)-margin) {
    // draw circle
    ctx.save();
    ctx.beginPath();
    ctx.arc(x, y, r, 0, 2*Math.PI, false);
    ctx.fill();
    ctx.restore();
  }

  // convert coordinates to pixels
  function scale(x) {
    return x*(board_size-2*margin)/n + margin;
  }

})();





//
