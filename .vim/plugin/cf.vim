" Author: Igorjan94, Igorjan94@{mail.ru, gmail.com, yandex.ru}, https://github.com/Igorjan94

" ------------------------------------------------------------------------------
" Exit when your app has already been loaded (or "compatible" mode set)
if exists("g:loaded_cf") || &cp
  finish
endif
let g:loaded_cf          = 0.0 " your version number
let s:keepcpo            = &cpo
set cpo&vim
" ------------------------------------------------------------------------------

let g:CodeForcesContestId = 0
let g:CodeForcesFrom = 1
let g:CodeForcesCount = 20
let g:CodeForcesLang = "ru"
let g:CodeForcesDomain = "ru"
let g:CodeForcesCountOfSubmits = 5
let g:CodeForcesUpdateInterval = 2

if !hasmapto('<Plug>AppFunction')
  map  <unique> <leader>igor <Plug>AppFunction
endif

map <silent> <unique> <script> <Plug>AppFunction
 \ :set lz<CR>:call <SID>AppFunction()<CR>:set nolz<CR>

fun! s:AppFunction()
  echom "okey"
  call s:InternalAppFunction("lol")
endfun

fun! s:InternalAppFunction(f)
    echom a:f
endfun

function! CodeForcesColor()
    highlight Red     ctermfg=red 
    highlight Yellow  ctermfg=yellow
    highlight Purple  ctermfg=magenta
    highlight Blue    ctermfg=blue
    highlight Green   ctermfg=green
    highlight Gray    ctermfg=gray
    highlight Unrated ctermfg=white

    let x = matchadd("Green", '+[0-9]')
    let x = matchadd("Green", ' [0-9][0-9][0-9]')
    let x = matchadd("Green", ' [0-9][0-9][0-9][0-9]')
    let x = matchadd("Green", ' [0-9][0-9][0-9][0-9][0-9]')
    let x = matchadd("Red", '-[0-9]')
python << EOF
import vim
users = open('codeforces.users', 'r')
for user in users:
    [handle, color] = user[:-1].split(' ', 1)
    s = 'let x = matchadd(\"' + color + '\", \"' + handle + '\")'
    vim.command(s)
EOF
endfunction

function! CodeForcesSubmission(...)
python << EOF
import vim
(row, col) = vim.current.window.cursor
[n, handle, hacks, score, tasks] = vim.current.buffer[row - 1].split('|', 4)
col -= len(n + handle + hacks + score) + 4
if col >= 0 and tasks[col] != '|':
    submissions = tasks.split('|')
    i = 0
    while col > len(submissions[i]):
        col -= len(submissions[i]) + 1
        i += 1
    if i != -1:
        submission = i
        handle = handle.replace(' ', '')
EOF
endfunction

function! CodeForcesSetRound(id)
    let g:CodeForcesContestId = id
endfunction

function! CodeForcesUserSubmissions(...)
python << EOF
import vim
import requests
from time import sleep

username = vim.eval("g:CodeForcesUsername")
updateInterval = vim.eval("g:CodeForcesUpdateInterval")
countOfSubmits = vim.eval("g:CodeForcesCountOfSubmits")

def formatString(s):
    return str(s['problem']['contestId']) + s['problem']['index'] + " " + \
        '{:>25}'.format(s['verdict'] + "(" + str(s['passedTestCount'] + 1) + ") ") + str(s['timeConsumedMillis']) + " ms"

while True:
    try:
        data = requests.get("http://codeforces.ru/api/user.status?handle=" + username + "&from=1&count=" + str(countOfSubmits)).json()['result']
    except:
        sleep(updateInterval)
        continue
    print("last submits")
    for s in reversed(data):
        try:
            print(formatString(s))
        except:
            print('IN QUEUE')
    sys.stdout.flush()
    if s['verdict'] != 'TESTING':
        break
    sleep(updateInterval)

EOF
endfunction

function! CodeForcesSubmit(...)
python << EOF
import vim
import requests

filename = vim.eval("expand(\'%:r\')").upper()
directory = vim.eval("expand(\'%:p:h:t\')")
extension = vim.eval("expand(\'%:e\')").lower()

#TODO: parsing of directory or filename to find CodeForcesContestId

fullPath = vim.eval("expand(\'%:p\')")
contest_id = vim.eval("g:CodeForcesContestId")
cf_domain = vim.eval("g:CodeForcesDomain")
csrf_token = vim.eval("g:CodeForcesToken")
x_user = vim.eval("g:CodeForcesXUser")

contest_id = directory # ONLY FOR ME NOW

ext_id          =  {
    "cpp":   "16",
    "cs":    "9",
    "c":     "10",
    "hs":    "12",
    "java":  "36",
    "py":    "41",
    "py2":   "40",
    "py3":   "41",
    "d":     "28",
    "go":    "32",
    "ml":    "19",
    "pas":   "4",
    "dpr":   "3",
    "pl":    "13",
    "php":   "6",
    "rb":    "8",
    "scala": "20",
    "js":    "34"
}

parts = {
        "csrf_token":            csrf_token,
        "action":                "submitSolutionFormSubmitted",
        "submittedProblemIndex": filename,
        "source":                open(fullPath, "rb"),
        "programTypeId":         ext_id[extension],
        "sourceFile":            "",
        "_tta":                  "222"
}

print("you' ve submitted " + contest_id + filename + extension)
r = requests.post("http://codeforces." + cf_domain + "/contest/" + contest_id + "/problem/" + filename,
              params = {"csrf_token": csrf_token},
              files = parts,
              cookies = {"X-User": x_user})
print(r)
if r.status_code == requests.codes.ok:
    print("Solution is successfully sent. Current time is " + time.strftime("%H:%M:%S"))
EOF
endfunction

function! CodeForcesStandings(...)
python << EOF
import vim
import requests
import json

if vim.eval("a:1") != '':
    vim.command("let g:CodeForcesContestId = a:1")
if vim.eval("g:CodeForcesContestId") == 0:
    vim.command("echom \"CodeForcesContestId is not set. Add it in .vimrc or just call CodeForcesStandings <CodeForcesContestId>\"")
else:
    api = "http://codeforces." + vim.eval("g:CodeForcesLang") + "/api/"

    url = api + 'contest.standings?contestId=' + vim.eval("g:CodeForcesContestId") + '&from=' + vim.eval("g:CodeForcesFrom") + '&count=' + vim.eval("g:CodeForcesCount")

    try:
#    vim.command('badd codeforces.standings')
#    vim.command('bn')
        del vim.current.buffer[:]
        x = requests.get(url).json()
        if x['status'] != 'OK':
            vim.current.buffer.append('FAIL')
        else:
            x = x['result']
            contestName = x['contest']['name']
            problems = 'N|Party|Hacks|Score'
            for problem in x['problems']:
                price = ""
                if 'points' in problem.keys():
                    price = ' (' + str(int(problem['points'])) + ')'
                problems += ' | ' + problem['index'] + price
            vim.current.buffer.append(contestName)
            vim.current.buffer.append(problems)
            for y in x['rows']:
                hacks = ' '
                if y['successfulHackCount'] > 0:
                    hacks += '+' + str(y['successfulHackCount'])
                if y['unsuccessfulHackCount'] > 0:
                    if len(hacks) > 1:
                        hacks += '/'
                    hacks += '-' + str(y['unsuccessfulHackCount'])
                s = ' ' + str(y['rank']) + ' | ' + y['party']['members'][0]['handle'] + ' | ' + hacks + '|' + str(int(y['points']))
                for pr in y['problemResults']:
                    s += ' | '
                if pr['points'] == 0.0:
                    if pr['rejectedAttemptCount'] != 0:
                        s += '-' + str(pr['rejectedAttemptCount'])
                else:
                    s += str(int(pr['points']))
            vim.current.buffer.append(s)
        vim.command("3,$EasyAlign *| {'a':'c'}")

    except Exception, e:
        print e

EOF
endfunction

command! -nargs=* CodeForcesStandings call CodeForcesStandings('<args>')

" ------------------------------------------------------------------------------
let &cpo= s:keepcpo
unlet s:keepcpo
