package com.inmotion.viewswitcher {
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import fl.transitions.easing.*;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	
	public class ViewSwitcher {
		
		public static var arView:Array = new Array();
		public static var width_:Number = 550;
		public static var height_:Number = 400;
		public static var defaultEase:Function;

		public function ViewSwitcher() {
			// constructor code
		}
		
		public static function prepare(_dimensi:Rectangle, _defaultEase:Function):void {
			//menyiapkan kelas agar efek animasi dll dapat berjalan lancar.
			width_ = _dimensi.width;
			height_ = _dimensi.height;
			
			defaultEase = _defaultEase;
		}
		
		public static function addView(_mc:MovieClip):Boolean {
			//memasukkan tampilan ke dalam kelas, jika berhasil maka bernilai true
			if (arView.indexOf(_mc) >= 0) {
				return false;
			} else {
				arView.push(_mc);
				return true;
			}
		}
		
		public static function showView(_mc:MovieClip, _hideAll:Boolean = true) {
			if (_hideAll) {
				hideAll(_mc);
			}
			
			_mc.visible = true;
			motion(_mc, 'alpha', 1, defaultEase, 1);
		}
		
		public static function hideAll(_except:MovieClip = null):void {
			for (var i:int = 0; i < arView.length; i++) {
				if (arView[i] != _except) {
					motion(arView[i], 'alpha', 0, defaultEase, 1, function(e:Object) {
						   		e.visible = false;
						   });
				}
			}
		}
		public static function motion(_obj:Object, _type:String, _newValue:Number, _ease:Function, _time:Number = 2, _callback:Function = null):void {
			if (_ease == null) {
				_ease = defaultEase;
			}
			var tw:Tween = new Tween(_obj, _type, _ease, _obj[_type], _newValue, _time, true);
			tw.addEventListener(TweenEvent.MOTION_FINISH, function() {
									if (_callback != null) {
										_callback.apply(ViewSwitcher, new Array(_obj));
									}
								});
		}
		

	}
	
}
