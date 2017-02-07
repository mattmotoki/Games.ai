(function () {
    var n = 3,
        margin = 10,
        indent = 0.2,
        board = document.querySelector("#board"),
        ctx = board.getContext("2d"),
        container = document.querySelector("#board-container"),
        board_size = Math.min(
            container.clientWidth,
            container.clientHeight
        ),
        bezier_list = [
            [1.0, 1.1, 1.0, 1.0, 1.1, 1.0],
            [1.1, 1.0, 1.5, 1.0, 1.9, 1.0],
            [1.9, 1.0, 2.0, 1.0, 2.0, 1.1],
            [2.0, 1.1, 2.0, 1.5, 2.0, 1.9],
            [2.0, 1.9, 2.0, 2.0, 1.9, 2.0],
            [1.9, 2.0, 1.5, 2.0, 1.1, 2.0],
            [1.1, 2.0, 1.0, 2.0, 1.0, 1.9],
            [1.0, 1.9, 1.0, 1.5, 1.0, 1.1]
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
        ctx.canvas.height = board_size;
        ctx.canvas.width = board_size;
        redraw();
    }


    function redraw() {
        drawGrid();
        drawOutline(bezier_list);
        mid(4, 1).forEach(drawDot);
        mid(4, n).forEach(drawDot);
        mid(4, -1).forEach(drawDot);
        mid(4, -n).forEach(drawDot);
    }

    function drawOutline(bezier_list) {
        var seg = bezier_list[0]
        ctx.save();
        ctx.beginPath();
        ctx.moveTo(scale(seg[0]), scale(seg[1]));
        bezier_list.forEach(function (seg) {
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
        n_px = scale(n);
        for (var i = 0; i < n + 1; i += 1) {
            i_px = scale(i);
            ctx.moveTo(i_px, margin);
            ctx.lineTo(i_px, n_px);
            ctx.moveTo(margin, i_px);
            ctx.lineTo(n_px, i_px);
        }
        ctx.stroke();
        ctx.restore();
    }

    function drawDot(pos, r = 3) {
        // draw circle
        ctx.save();
        ctx.beginPath();
        ctx.fillStyle = "#D3D3D3";
        ctx.arc(scale(pos[0]), scale(pos[1]), 3, 0, 2 * Math.PI, false);
        ctx.fill();
        ctx.restore();
    }

    /* ------------------- */
    /*  Utility functions  */
    /* ------------------- */
    // convert coordinates to pixels
    function scale(x) {
        return x * (board_size - 2 * margin) / n + margin;
    }
    function ind2row(ind) {return ind % n;}
    function ind2col(ind) {return Math.floor(ind/n);}
    function shiftByInd(pnt, ind) {
        return [pnt[0]+ind2col(ind), pnt[1] + ind2row(ind)];
    }
    function groupPoints(old_array) {
        var new_array = [];
        for (var i=0; i<old_array.length/2; i+=1) {
            new_array.push([old_array[2*i], old_array[2*i+1] ]);
        }
        return new_array;
    }

    function arrayRotate(arr, reverse){
        if(reverse) { arr.unshift(arr.pop()) }
        else { arr.push(arr.shift()) }
        return arr;
    }

    function sign(x) {return (x>0) ? 1 : -1;}

    /* ------------------------ */
    /*  Line Segment Functions  */
    /* ------------------------ */
    // mid-section
    function mid(ind, pos) {
      var seg
      switch(pos) {
        case  1: seg = [ [indent,   1], [0.5, 1], [1-indent, 1] ]; break;
        case  n: seg = [ [1, 1-indent], [1, 0.5], [1,   indent] ]; break;
        case -1: seg = [ [1-indent, 0], [0.5, 0], [indent,   0] ]; break;
        case -n: seg = [ [0,   indent], [0, 0.5], [0, 1-indent] ]; break;
      }
        // // use |pos|=1 as default segment
        // var pos_sign = sign(pos); // sign of position
        // var side = 1*(pos>0);     // 0 or 1 side
        // var seg = [
        //     0.5 + pos_sign*(indent-0.5), side, // 1st point
        //     0.5,                         side, // 2nd point
        //     0.5 - pos_sign*(indent-0.5), side // 3rd point
        // ];
        //
        // // convert vertical to horizontal
        // if (Math.abs(pos)==n) {seg.reverse();}
        //
        // // map flat array to point-array
        // seg = groupPoints(seg);

        // shift points
        return seg.map((pnt)=>shiftByInd(pnt, ind));
    }

    // flat-corner
    function flat(ind, connect, pos) {
        var cnct_sign = sign(connect); // sign of connect
        var cnct_side = 1*(connect>0); // 0 or 1 side
        var pos_side = 1*(pos>0);      // 0 or 1 side

        var seg = [
            pos_side,  cnct_side,                       // 1st point
            pos_side, 0.5 + cnct_sign*(0.5 - indent/2), // 2nd point
            pos_side, 0.5 + cnct_sign*(0.5 - indent)    // 3rd point
        ];

        // convert vertical to horizontal
        if (Math.abs(connect)==n) {seg.reverse();}

        // map flat array to point-array
        seg = groupPoints(seg);

        // reverse points
        if (Math.abs(connect-pos)==n+1 ){ seg.reverse(); }

        //shift points
        return seg.map((pnt)=>shiftByInd(pnt, ind));
    }
    // inside-corner
    function inside(ind, corner) {
      var seg
      switch(corner) {
        case  n+1: seg = [ [1-indent, 1], [1, 1], [1, 1-indent] ]; break;
        case  n-1: seg = [ [1,   indent], [1, 0], [1-indent, 0] ]; break;
        case -n-1: seg = [ [indent,   0], [0, 0], [0,   indent] ]; break;
        case -n+1: seg = [ [0, 1-indent], [0, 1], [indent,   1] ]; break;
      }
      //shift points
      return seg.map((pnt)=>shiftByInd(pnt, ind));
    }
    // outside-corner
    function outside(ind, corner) {
      var seg
      switch(corner) {
        case  n+1: seg = [ [1, 1+indent], [1, 1], [1+indent, 1] ]; break;
        case  n-1: seg = [ [1+indent, 0], [1, 0], [1,  -indent] ]; break;
        case -n-1: seg = [ [0,  -indent], [0, 0], [-indent,  0] ]; break;
        case -n+1: seg = [ [-indent,  1], [0, 1], [0, 1+indent] ]; break;
      }
      //shift points
      return seg.map((pnt)=>shiftByInd(pnt, ind));
    }

})();





//
