lua <<EOF
	require('trim').setup({
		patterns = {
    		[[%s/\(\n\n\)\n\+/\1/]],
  		},
	})
EOF
