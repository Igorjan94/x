" Author: Igor Kolobov, Igorjan94, Igorjan94@{mail.ru, gmail.com, yandex.ru}, https://github.com/Igorjan94, http://codeforces.ru/profile/Igorjan94

" ------------------------------------------------------------------------------
"{{{
if exists("g:loaded_cf") || &cp
  finish
endif
let g:loaded_cf          = 0.0
let s:keepcpo            = &cpo
set cpo&vim
"}}}
" ------------------------------------------------------------------------------
"{{{

if !exists('g:CodeForcesContestId') 
    let g:CodeForcesContestId      = 0
endif
if !exists('g:CodeForcesCount')
    let g:CodeForcesCount          = 50
endif
if !exists('g:CodeForcesLang')
    let g:CodeForcesLang           = "ru"
endif
if !exists('g:CodeForcesDomain')
    let g:CodeForcesDomain         = "ru"
endif
if !exists('g:CodeForcesCountOfSubmits')
    let g:CodeForcesCountOfSubmits = 5
endif
if !exists('g:CodeForcesUpdateInterval')
    let g:CodeForcesUpdateInterval = 2
endif
if !exists('g:CodeForcesShowUnofficial')
    let g:CodeForcesShowUnofficial = 0
endif
if !exists('g:CodeForcesFriends')
    let g:CodeForcesFriends        = 0
endif
"}}}       

command! -nargs=0 CodeForcesNextStandings     call CodeForces#CodeForcesNextStandings()
command! -nargs=0 CodeForcesPrevStandings     call CodeForces#CodeForcesPrevStandings()
command! -nargs=1 CodeForcesPageStandings     call CodeForces#CodeForcesPageStandings(<args>)
command! -nargs=* CodeForcesStandings         call CodeForces#CodeForcesStandings(<args>)
command! -nargs=0 CodeForcesFriendsSet        call CodeForces#CodeForcesFriendsSet()
command! -nargs=0 CodeForcesUnofficial        call CodeForces#CodeForcesUnofficial()
command! -nargs=1 CodeForcesSetRound          call CodeForces#CodeForcesSetRound(<args>)
command! -nargs=0 CodeForcesColor             call CodeForces#CodeForcesColor()
command! -nargs=0 CodeForcesSubmission        call CodeForces#CodeForcesSubmission()
command! -nargs=0 CodeForcesUserSubmissions   call CodeForces#CodeForcesUserSubmissions()
command! -nargs=+ CodeForcesSubmitIndexed     call CodeForces#CodeForcesSubmitIndexed(<f-args>)
command! -nargs=0 CodeForcesSubmit            call CodeForces#CodeForcesSubmit()
command! -nargs=1 CodeForcesLoadTask          call CodeForces#CodeForcesLoadTask(<q-args>)
command! -nargs=+ CodeForcesLoadTaskContestId call CodeForces#CodeForcesLoadTaskContestId(<f-args>)

function! Tester() "{{{
let x=expand('<sfile>:p')
echom(x)
python << EOF
import vim
print(vim.eval("resolve(expand(\'<sfile>:p\'))"))
EOF
endfunction
command! -nargs=0 Cf call Tester()
"}}}

" ------------------------------------------------------------------------------
let &cpo= s:keepcpo
unlet s:keepcpo
