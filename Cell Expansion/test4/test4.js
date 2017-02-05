(function () {
    var n = 3,
        margin = 10,
        indent = 10,
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

    function drawDot(x, y, r = scale(0.05) - margin) {
        // draw circle
        ctx.save();
        ctx.beginPath();
        ctx.arc(x, y, r, 0, 2 * Math.PI, false);
        ctx.fill();
        ctx.restore();
    }

    // convert coordinates to pixels
    function scale(x) {
        return x * (board_size - 2 * margin) / n + margin;
    }

    // line segment functions
    function mid(ind, pos) {
        var seg
        
        // set 
        if (pos>0) {seg = [indent, 0, 0.5, 0, 1-indent, 0];}
        else       {seg = [indent, 0, 0.5, 0, 1-indent, 0];}
        
        
        switch(pos) {
            case 1: 
                seg = [indent, 0, 0.5, 0, 1-indent, 0];
                break;
            case -1: 
                seg = [indent, 1, 0.5, 1, 1-indent, 1];
                break;
            case n:
                seg = [1, indent, 1, 0.5, 1, 1-indent];
                break;                
            case -n:
                seg = [0, indent, 0, 0.5, 0, 1-indent];
                break;                
        }
    }

    function arrayRotate(arr, reverse){
        if(reverse) { arr.unshift(arr.pop()) } 
        else { arr.push(arr.shift()) }
        return arr
    } 
})();





//
