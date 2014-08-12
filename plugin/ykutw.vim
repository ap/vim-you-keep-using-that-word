" Vim global plugin for making cw consistent with dw, yw, et al
" Licence:     The MIT License (MIT)
" {{{ Copyright (c) 2014 Aristotle Pagaltzis <pagaltzis@gmx.de>
" 
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
" 
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
" 
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.
" }}}

if exists('g:loaded_ykutw') | finish | endif
let g:loaded_ykutw = 1

function s:DoWordMotion(wordmotion, endmotion)
	let before = line('.')
	execute 'normal! v'.v:count1.a:wordmotion

	" when the cursor wraps, we must check whether it went too far
	if line('.') != before
		" try backing up to the end of the previous word
		" and then see if we stay on the same line
		let target = winsaveview()
		let before = line('.')
		exe 'normal! g'.a:endmotion
		if line('.') != before
			" we are now at the end of the word at the end of previous line,
			" which is exactly where we want to be
			return
		else
			" we were (almost) in the right place, so go back there
			call winrestview(target)
		endif
	endif

	" visual selections are inclusive; to avoid erasing the first char
	" of the following word, we must back off one column
	execute 'normal! h'
endfunction

onoremap w :<C-U>call <SID>DoWordMotion('w','e')<CR>
onoremap W :<C-U>call <SID>DoWordMotion('W','E')<CR>

" vim: fdm=marker fmr={{{,}}}
