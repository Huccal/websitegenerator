#!/bin/bash

#$1 is the filename and $2 is the first line in the file
start(){
cat << EOF >> $1.html
<!DOCTYPE html>
<html>
<head>
	<title>Foundation Year Project | $2</title>
	<link rel="stylesheet" type="text/css" href="../css/style1.css">
</head>
<body>
	<header>
		<div class="container">
			<div id="branding">
				<h1>CompSci11</h1>
			</div>
			
			<nav>
				<ul class="menu">
EOF
}

menuvar(){
cat << EOF
		<li class="menu_item"><a href="$1.html">$2</a>
EOF
}

menuend(){
cat << EOF
		</li>
EOF
}

submenustart(){
cat << EOF
			<ul class="submenu">
EOF
}

submenuvar(){
cat << EOF
			<li class="submenu_item"><a href="$1.html">$2</a></li>
EOF
}

submenuend(){
cat << EOF
			</ul>
EOF
}

htmlpage3(){
cat << EOF >> $1.html
				</ul>
			</nav>
		</div>
	</header>
EOF

cat $1 | sed '1d' >> $1.html

cat << _EOF_ >> $1.html
	<footer>
		<p>Last modified: 
_EOF_

date +"%b %d %Y" | cat >> $1.html

cat << __EOF__ >> $1.html
		</p>
	</footer>
</body>
</html>
__EOF__
}


for file in "$@"; do
	file_name=$(head -n 1 $file)
	start $file "$file_name"
	for menu in $1 $2 $3 $4; do
		menu_name=$(head -n 1 $menu)
		menuvar $menu "$menu_name" >> $file.html
		if [ $menu = $3 ]; then
			submenustart >> $file.html
			for submenu in $5 $6 $7; do
				submenu_name=$(head -n 1 $submenu)
				submenuvar $submenu "$submenu_name" >> $file.html
			done
			submenuend >> $file.html
		fi
		if [ $menu = $4 ]; then
			submenustart >> $file.html
			for submenu in $8 $9; do
				submenu_name=$(head -n 1 $submenu)
				submenuvar $submenu "$submenu_name" >> $file.html
			done
			submenuend >> $file.html
		fi
		menuend >> $file.html
	done
	htmlpage3 $file
done
