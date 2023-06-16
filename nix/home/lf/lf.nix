{ config, pkgs, lib, ... }:
let
	dateGoFmt = config.customVars.dateGoFmt;
in
{
	config = {
		programs.lf = {
			extraConfig = ''
				set autoquit on
				set dircache on
				# set dironly off
				set incfilter on
				set hiddenfiles ".*"
				set infotimefmtnew "${dateGoFmt}"
				set infotimefmtold "${dateGoFmt}"
				set mouse off
				set shellflag "-c"
				# set tagfmt "\033[31m%s\033[0m"
				set tempmarks ""
				set truncatechar "~"
				set waitmsg "Press any key to continue..."
			'';

			settings = {
				# autoquit = true;
				# dircache = true;
				dircounts = false;
				dirfirst = true;
				# dironly = false;
				drawbox = true;
				globsearch = true;
				hidden = true;
				icons = true;
				ignorecase = true;
				ignoredia = true;
				incsearch = true;
				# incfilter = true;
				info = "";
				# infotimefmtnew = "${dateGoFmt}";
				# infotimefmtold = "${dateGoFmt}";
				# mouse = false;
				number = true;
				period = 0;
				preview = true;
				promptfmt = ''\033[32;1m%u@%h\033[0m:\033[34;1m%d\033[0m\033[1m%f\033[0m'';
				relativenumber = true;
				reverse = false;
				scrolloff = 0;
				shell = "${pkgs.dash}/bin/dash";
				# shellflag = "-c";
				shellopts = "-eu";
				smartcase = true;
				smartdia = true;
				sortby = "natural";
				tabstop = 4;
				# tagfmt = "\033[31m%s\033[0m";
				# tempmarks = "";
				# truncatechar = "~";
				# waitmsg = "Press any key to continue...";
				wrapscan = true;
				wrapscroll = false;
				ratios = "1:2:3";
			};
		};

		xdg.configFile.lficons = lib.mkIf config.programs.lf.enable {
			target = "lf/icons";

			text = ''
				# These examples require Nerd Fonts or a compatible font to be used.
				# See https://www.nerdfonts.com for more information.

				# default values from lf (with matching order)
				# ln      l       # LINK
				# or      l       # ORPHAN
				# tw      t       # STICKY_OTHER_WRITABLE
				# ow      d       # OTHER_WRITABLE
				# st      t       # STICKY
				# di      d       # DIR
				# pi      p       # FIFO
				# so      s       # SOCK
				# bd      b       # BLK
				# cd      c       # CHR
				# su      u       # SETUID
				# sg      g       # SETGID
				# ex      x       # EXEC
				# fi      -       # FILE

				# file types (with matching order)
				ln             # LINK
				or             # ORPHAN
				tw      t       # STICKY_OTHER_WRITABLE
				ow             # OTHER_WRITABLE
				st      t       # STICKY
				di             # DIR
				pi      p       # FIFO
				so      s       # SOCK
				bd      b       # BLK
				cd      c       # CHR
				su      u       # SETUID
				sg      g       # SETGID
				ex             # EXEC
				fi             # FILE

				# file extensions (vim-devicons)
				*.styl          
				*.sass          
				*.scss          
				*.htm           
				*.html          
				*.slim          
				*.haml          
				*.ejs           
				*.css           
				*.less          
				*.md            
				*.mdx           
				*.markdown      
				*.rmd           
				*.json          
				*.webmanifest   
				*.js            
				*.mjs           
				*.jsx           
				*.rb            
				*.gemspec       
				*.rake          
				*.php           
				*.py            
				*.pyc           
				*.pyo           
				*.pyd           
				*.coffee        
				*.mustache      
				*.hbs           
				*.conf          
				*.ini           
				*.yml           
				*.yaml          
				*.toml          
				*.bat           
				*.mk            
				*.jpg           
				*.jpeg          
				*.bmp           
				*.png           
				*.webp          
				*.gif           
				*.ico           
				*.twig          
				*.cpp           
				*.c++           
				*.cxx           
				*.cc            
				*.cp            
				*.c             
				*.cs            
				*.h             
				*.hh            
				*.hpp           
				*.hxx           
				*.hs            
				*.lhs           
				*.nix           
				*.lua           
				*.java          
				*.sh            
				*.fish          
				*.bash          
				*.zsh           
				*.ksh           
				*.csh           
				*.awk           
				*.ps1           
				*.ml            λ
				*.mli           λ
				*.diff          
				*.db            
				*.sql           
				*.dump          
				*.clj           
				*.cljc          
				*.cljs          
				*.edn           
				*.scala         
				*.go            
				*.dart          
				*.xul           
				*.sln           
				*.suo           
				*.pl            
				*.pm            
				*.t             
				*.rss           
				'*.f#'          
				*.fsscript      
				*.fsx           
				*.fs            
				*.fsi           
				*.rs            
				*.rlib          
				*.d             
				*.erl           
				*.hrl           
				*.ex            
				*.exs           
				*.eex           
				*.leex          
				*.heex          
				*.vim           
				*.ai            
				*.psd           
				*.psb           
				*.ts            
				*.tsx           
				*.jl            
				*.pp            
				*.vue           
				*.elm           
				*.swift         
				*.xcplayground  
				*.tex           ﭨ
				*.r             ﳒ
				*.rproj         鉶
				*.sol           ﲹ
				*.pem           

				# file names (vim-devicons) (case-insensitive not supported in lf)
				*gruntfile.coffee       
				*gruntfile.js           
				*gruntfile.ls           
				*gulpfile.coffee        
				*gulpfile.js            
				*gulpfile.ls            
				*mix.lock               
				*dropbox                
				*.ds_store              
				*.gitconfig             
				*.gitignore             
				*.gitattributes         
				*.gitlab-ci.yml         
				*.bashrc                
				*.zshrc                 
				*.zshenv                
				*.zprofile              
				*.vimrc                 
				*.gvimrc                
				*_vimrc                 
				*_gvimrc                
				*.bashprofile           
				*favicon.ico            
				*license                
				*node_modules           
				*react.jsx              
				*procfile               
				*dockerfile             
				*docker-compose.yml     
				*rakefile               
				*config.ru              
				*gemfile                
				*makefile               
				*cmakelists.txt         
				*robots.txt             ﮧ

				# file names (case-sensitive adaptations)
				*Gruntfile.coffee       
				*Gruntfile.js           
				*Gruntfile.ls           
				*Gulpfile.coffee        
				*Gulpfile.js            
				*Gulpfile.ls            
				*Dropbox                
				*.DS_Store              
				*LICENSE                
				*React.jsx              
				*Procfile               
				*Dockerfile             
				*Docker-compose.yml     
				*Rakefile               
				*Gemfile                
				*Makefile               
				*CMakeLists.txt         

				# file patterns (vim-devicons) (patterns not supported in lf)
				# .*jquery.*\.js$         
				# .*angular.*\.js$        
				# .*backbone.*\.js$       
				# .*require.*\.js$        
				# .*materialize.*\.js$    
				# .*materialize.*\.css$   
				# .*mootools.*\.js$       
				# .*vimrc.*               
				# Vagrantfile$            

				# file patterns (file name adaptations)
				*jquery.min.js          
				*angular.min.js         
				*backbone.min.js        
				*require.min.js         
				*materialize.min.js     
				*materialize.min.css    
				*mootools.min.js        
				*vimrc                  
				Vagrantfile             

				# archives or compressed (extensions from dircolors defaults)
				*.tar   
				*.tgz   
				*.arc   
				*.arj   
				*.taz   
				*.lha   
				*.lz4   
				*.lzh   
				*.lzma  
				*.tlz   
				*.txz   
				*.tzo   
				*.t7z   
				*.zip   
				*.z     
				*.dz    
				*.gz    
				*.lrz   
				*.lz    
				*.lzo   
				*.xz    
				*.zst   
				*.tzst  
				*.bz2   
				*.bz    
				*.tbz   
				*.tbz2  
				*.tz    
				*.deb   
				*.rpm   
				*.jar   
				*.war   
				*.ear   
				*.sar   
				*.rar   
				*.alz   
				*.ace   
				*.zoo   
				*.cpio  
				*.7z    
				*.rz    
				*.cab   
				*.wim   
				*.swm   
				*.dwm   
				*.esd   

				# image formats (extensions from dircolors defaults)
				*.jpg   
				*.jpeg  
				*.mjpg  
				*.mjpeg 
				*.gif   
				*.bmp   
				*.pbm   
				*.pgm   
				*.ppm   
				*.tga   
				*.xbm   
				*.xpm   
				*.tif   
				*.tiff  
				*.png   
				*.svg   
				*.svgz  
				*.mng   
				*.pcx   
				*.mov   
				*.mpg   
				*.mpeg  
				*.m2v   
				*.mkv   
				*.webm  
				*.ogm   
				*.mp4   
				*.m4v   
				*.mp4v  
				*.vob   
				*.qt    
				*.nuv   
				*.wmv   
				*.asf   
				*.rm    
				*.rmvb  
				*.flc   
				*.avi   
				*.fli   
				*.flv   
				*.gl    
				*.dl    
				*.xcf   
				*.xwd   
				*.yuv   
				*.cgm   
				*.emf   
				*.ogv   
				*.ogx   

				# audio formats (extensions from dircolors defaults)
				*.aac   
				*.au    
				*.flac  
				*.m4a   
				*.mid   
				*.midi  
				*.mka   
				*.mp3   
				*.mpc   
				*.ogg   
				*.ra    
				*.wav   
				*.oga   
				*.opus  
				*.spx   
				*.xspf  

				# other formats
				*.pdf   

				# vim:ft=conf
			'';
		};

		xdg.configFile.lfcolors = lib.mkIf config.programs.lf.enable {
			target = "lf/colors";

			text = ''
				# file types (with matching order)
				ln		36			# LINK
				or		31			# ORPHAN
				tw		01;37;44	# STICKY_OTHER_WRITABLE
				ow		01;04;34	# OTHER_WRITABLE
				st		04;37;44	# STICKY
				di		01;34		# DIR
				pi		04;01;36   	# FIFO
				so		04;33		# SOCK
				bd		01;33		# BLK
				cd		33			# CHR
				su		01;04;37	# SETUID
				sg		01;04;37	# SETGID
				ex		01;36		# EXEC
				fi		00   		# FILE

				#+-------------------+
				#+ Extension Pattern +
				#+-------------------+
				#+--- Archives ---+
				*.7z	01;32
				*.ace	01;32
				*.alz	01;32
				*.arc	01;32
				*.arj	01;32
				*.bz	01;32
				*.bz2	01;32
				*.cab	01;32
				*.cpio	01;32
				*.deb	01;32
				*.dz	01;32
				*.ear	01;32
				*.gz	01;32
				*.jar	01;32
				*.lha	01;32
				*.lrz	01;32
				*.lz	01;32
				*.lz4	01;32
				*.lzh	01;32
				*.lzma	01;32
				*.lzo	01;32
				*.rar	01;32
				*.rpm	01;32
				*.rz	01;32
				*.sar	01;32
				*.t7z	01;32
				*.tar	01;32
				*.taz	01;32
				*.tbz	01;32
				*.tbz2	01;32
				*.tgz	01;32
				*.tlz	01;32
				*.txz	01;32
				*.tz	01;32
				*.tzo	01;32
				*.tzst	01;32
				*.war	01;32
				*.xz	01;32
				*.z		01;32
				*.Z		01;32
				*.zip	01;32
				*.zoo	01;32
				*.zst	01;32

				#+--- Audio ---+
				*.aac	32
				*.au	32
				*.flac	32
				*.m4a	32
				*.mid	32
				*.midi	32
				*.mka	32
				*.mp3	32
				*.mpa	32
				*.mpeg	32
				*.mpg	32
				*.ogg	32
				*.opus	32
				*.ra	32
				*.wav	32

				#+--- Customs ---+
				*.3des	01;35
				*.aes	01;35
				*.gpg	01;35
				*.pgp	01;35

				#+--- Documents ---+
				*.doc	32
				*.docx	32
				*.dot	32
				*.odg	32
				*.odp	32
				*.ods	32
				*.odt	32
				*.otg	32
				*.otp	32
				*.ots	32
				*.ott	32
				*.pdf	32
				*.ppt	32
				*.pptx	32
				*.xls	32
				*.xlsx	32

				#+--- Executables ---+
				*.app	01;36
				*.bat	01;36
				*.btm	01;36
				*.cmd	01;36
				*.com	01;36
				*.exe	01;36
				*.reg	01;36

				#+--- Ignores ---+
				*~		02;37
				*.bak	02;37
				*.BAK	02;37
				*.log	02;37
				*.log	02;37
				*.old	02;37
				*.OLD	02;37
				*.orig	02;37
				*.ORIG	02;37
				*.swo	02;37
				*.swp	02;37

				#+--- Images ---+
				*.bmp	32
				*.cgm	32
				*.dl	32
				*.dvi	32
				*.emf	32
				*.eps	32
				*.gif	32
				*.jpeg	32
				*.jpg	32
				*.JPG	32
				*.mng	32
				*.pbm	32
				*.pcx	32
				*.pgm	32
				*.png	32
				*.PNG	32
				*.ppm	32
				*.pps	32
				*.ppsx	32
				*.ps	32
				*.svg	32
				*.svgz	32
				*.tga	32
				*.tif	32
				*.tiff	32
				*.xbm	32
				*.xcf	32
				*.xpm	32
				*.xwd	32
				*.xwd	32
				*.yuv	32

				#+--- Video ---+
				*.anx	32
				*.asf	32
				*.avi	32
				*.axv	32
				*.flc	32
				*.fli	32
				*.flv	32
				*.gl	32
				*.m2v	32
				*.m4v	32
				*.mkv	32
				*.mov	32
				*.MOV	32
				*.mp4	32
				*.mpeg	32
				*.mpg	32
				*.nuv	32
				*.ogm	32
				*.ogv	32
				*.ogx	32
				*.qt	32
				*.rm	32
				*.rmvb	32
				*.swf	32
				*.vob	32
				*.webm	32
				*.wmv	32

				# (This is not a dircolors file but it helps to highlight colors and comments)
				# vim:ft=dircolors
			'';
		};
	};
}
