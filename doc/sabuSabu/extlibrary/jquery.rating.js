(function($) {

	CanvasRenderingContext2D.prototype.clear = CanvasRenderingContext2D.prototype.clear
			|| function(preserveTransform) {
				if (preserveTransform) {
					this.save();
					this.setTransform(1, 0, 0, 1, 0, 0);
				}

				this.clearRect(0, 0, this.canvas.width, this.canvas.height);

				if (preserveTransform) {
					this.restore();
				}
			};

	var mouseIsDown = false;

	var settings = {}

	$.fn.rateBar = function(options) {
		settings = $.extend({
			defaultStarColor : '#555555',
			ratedStarColor : '#FFD700',
			onRate : function() {
			}
		}, options);

		var $newCanv = $("<canvas width=80 height=20>Hello</canvas>");

		var ctx = $newCanv.get(0).getContext("2d");

		draw(ctx, 0);

		$newCanv.click(function(e) {
			var x = Math.floor((e.pageX - $newCanv.offset().left) / 16);
			ctx.clear(true);

			settings.onRate(x + 1);

			draw(ctx, x + 1);
		});

		$newCanv.mousedown(function(e) {
			mouseIsDown = true;
		});

		$newCanv.mouseup(function(e) {
			mouseIsDown = false;
		});

		$newCanv.mousemove(function(e) {
			if (!mouseIsDown)
				return;
			var x = Math.floor((e.pageX - $newCanv.offset().left) / 16);
			ctx.clear(true);

			settings.onRate(x + 1);

			draw(ctx, x + 1);
		});

		$newCanv.mouseleave(function(e) {
			mouseIsDown = false;
		});

		$(this).append($newCanv);

		return this;

	}

	function draw(ctx, rate) {
		star(ctx, 10, 10, 3, 5, 3, (rate >= 1) ? 1 : 0);
		star(ctx, 25, 10, 3, 5, 3, (rate >= 2) ? 1 : 0);
		star(ctx, 40, 10, 3, 5, 3, (rate >= 3) ? 1 : 0);
		star(ctx, 55, 10, 3, 5, 3, (rate >= 4) ? 1 : 0);
		star(ctx, 70, 10, 3, 5, 3, (rate >= 5) ? 1 : 0);
	}

	function star(ctx, x, y, r, p, m, width) {
		ctx.save();
		ctx.beginPath();
		ctx.translate(x, y);
		ctx.moveTo(0, 0 - r);

		ctx.rotate(Math.PI / p);

		for ( var i = 0; i < p; i++) {
			ctx.rotate(Math.PI / p);
			ctx.lineTo(0, 0 - (r * m));
			ctx.rotate(Math.PI / p);
			ctx.lineTo(0, 0 - r);
		}

		if (width == 1) {
			ctx.fillStyle = settings.ratedStarColor;
		} else {
			ctx.fillStyle = settings.defaultStarColor;
		}

		ctx.fill();
		ctx.restore();
	}

}(jQuery))