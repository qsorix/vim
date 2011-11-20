if exists("g:loaded_Refactoring_Uninline_Definition")
	finish
endif

let g:loaded_Refactoring_Uninline_Definition = 1

if !hasmapto('<Plug>Refactoring_Uninline')
  map <unique> <Leader><c-r>u <Plug>Refactoring_Uninline
endif

nmap <unique> <script> <Plug>Refactoring_Uninline :call <SID>Refactoring_Uninline()<CR>


" ---------------------------------------------------------------------

function! s:GetBuffersSection(start, end)
	let lines = getline(a:start[0], a:end[0])
	let lines[0] = lines[0][a:start[1]-1:]
	let lines[-1] = lines[-1][:a:end[1]]

	return join(lines, "\n")
endfunction

function! s:MatchHeaderAtCursorPos()
	let ws = '\_s\+'
	let cvqualifiers = '\(const\)\?'
	let ows = '\_s\{-}'
	let type = '\w\+'
	let result = '\(' . type . '\)'
	let name = '\(\w\+\)'
	let arguments = '\((.\{-})\)'
	let body = '\%(\(' . ows . '\)\%#\){\@='
	let func_header = result . ws . name . ows . arguments . ows . cvqualifiers
	let func_decl = func_header . body
	call setreg('/', func_decl)
	let match_pos = searchpos(func_decl, 'bcnW')
	if match_pos == [0, 0]
		return []
	endif
	let cur_pos = getpos('.')
	let text_to_match = s:GetBuffersSection(match_pos, cur_pos[1:2])
	let matched_header = matchlist(text_to_match, substitute(func_decl, '\\%#', '', ''))
	return matched_header
endfunction

function! s:MatchBodyAtCursorPos()
	let tmp = @a
	silent normal "aya{
	let body = @a
	let @a = tmp
	return body
endfunction

function! s:FormatFunctionDefinition(parents, type, name, args, cvqualifiers, body)
	let name = a:parents + [a:name]
	let qualifiers = ''
	if a:cvqualifiers
		let qualifiers = " " + a:cvqualifiers
	endif

	let body = matchstr(a:body, '^{\_s*\zs\_.\{-}\ze\_s*}$')
	if body =~ '\S'
		let body = "{\n" . body . "\n}"
	else
		let body = "{\n}"
	endif

	return a:type . "\n" . join(name, '::') . a:args . qualifiers . "\n" .  body . "\n\n"
endfunction

function! s:RemoveFunctionBody(chars_to_body)
	let bscount = len(a:chars_to_body)
	if bscount
		execute "normal " . bscount . "i\<BS>"
		normal l
	endif
	silent normal i;
	silent normal lda{
endfunction

function! s:FindParentClass()
	let pattern = '\%(class\|struct\)\_s\+\zs\(\i\+\)'
	let start = searchpos(pattern, 'bnW')
	if start == [0, 0]
		return []
	endif
	let end = searchpos(pattern, 'bnWe')
	return [s:GetBuffersSection(start, end)]
endfunction

function! s:Refactoring_Uninline()
	let matched_header = s:MatchHeaderAtCursorPos()
	if matched_header == []
		echoerr "Cursor is not at function's body opening bracket"
		return []
	endif

	let type = matched_header[1]
	let name = matched_header[2]
	let args = matched_header[3]
	let cvqualifiers = matched_header[4]
	let chars_to_body = matched_header[5]
	let body = s:MatchBodyAtCursorPos()
	let parents = s:FindParentClass()

	let @" = s:FormatFunctionDefinition(parents, type, name, args, cvqualifiers, body)

	let orig_file_type = &filetype

	new
	set buftype=nofile
	execute 'setlocal filetype='.orig_file_type
	normal p
	normal =G
	normal dG
	close

	let prev_quote = @"

	call s:RemoveFunctionBody(chars_to_body)
	let @" = prev_quote
endfunction

