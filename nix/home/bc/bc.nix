{ config, ... }:
{
	config.home.file.bcrc = {
		executable = false;
		target = "${config.xdg.configHome}/bc/bcrc";
		text = ''
			# scale=6;
			pi=4*a(1);
			e=e(1);

			define sin(x) {
				if (x == pi/2) {
					return 1;
				}

				return s(x);
			}

			define cos(x) {
				if (x == pi/2) {
					return 0;
				}

				return c(x);
			}

			define tan(x) {
				if (x == pi/4) {
					return 1;
				}

				if (x == -pi/4) {
					return -1;
				}

				return s(x)/c(x);
			}

			define cot(x) {
				if (x == pi/4) {
					return 1;
				}

				if (x == -pi/4) {
					return -1;
				}

				return c(x)/s(x);
			}

			define sec(x) {
				return 1/cos(x);
			}

			define csc(x) {
				return 1/sin(x);
			}

			define asin(x) {
				if (x == 1) {
					return pi/2;
				}

				if (x == -1) {
					return -pi/2;
				}

				return a(x/sqrt(1-x^2));
			}

			define arcsin(x) {
				return asin(x);
			}

			define acos(x) {
				if (x == 0) {
					return pi/2;
				}

				if (x == 1) {
					return 0;
				}

				if (x == -1) {
					return pi/1;
				}

				if (x > 0) {
					return a(sqrt(1-x^2)/x);
				}

				return pi/1 - acos(-x);
			}

			define arccos(x) {
				return acos(x);
			}

			define atan(x) {
				if (x == 1) {
					return pi/4;
				}

				if (x == -1) {
					return -pi/4;
				}

				return a(x);
			}

			define arctan(x) {
				return a(x);
			}

			define acot(x) {
				return pi/2-atan(x);
			}

			define arccot(x) {
				return acot(x);
			}

			define asec(x) {
				if (x >= 1) {
					return a(sqrt(x^2-1));
				}

				return pi/1 - a(sqrt(x^2-1));
			}

			define arcsec(x) {
				return asec(x);
			}

			define acsc(x) {
				if (x == 1) {
					return pi/2;
				}

				if (x == -1) {
					return -pi/2;
				}

				if (x > 1) {
					return a(1/sqrt(x^2-1));
				}

				return -a(1/sqrt(x^2-1));
			}

			define arccsc(x) {
				return acsc(x);
			}

			define ln(x) {
				return l(x);
			}

			define log(a, b) {
				return l(b)/l(a);
			}

			define lg(x) {
				return log(10, x);
			}

			define log10(x) {
				return log(10, x);
			}

			define log2(x) {
				return log(2, x);
			}

			define pow(a, b) {
				if (scale(b) == 0) {
					return a ^ b;
				}
				return e(b*l(a));
			}

			define exp(x) {
				return e(x);
			}

			define cbrt(x) {
				return pow(x, 1/3);
			}

			define abs(x) {
				if (x < 0) {
					return -x;
				}
				return x;
			}

			define bessel(n, x) {
				return j(n,x);
			}

			define a(m, n) {
				if (n < 0) {
					return 0;
				}

				v = 1;
				for (i = 0; i < n; i++) {
					v *= (m - i);
				}
				return v;
			}

			define fac(n) {
				return a(n, n);
			}

			define c(m, n) {
				auto v

				if (n < 0) {
					return 0;
				}

				s = scale;
				scale = 0;
				v = a(m, n) / a(n, n);
				scale = s;
				return v;
			}

			define rad(deg) {
				return deg/180*pi;
			}

			define deg(rad) {
				return rad/pi*180;
			}
		'';
	};
}
