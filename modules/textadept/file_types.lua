-- Copyright 2007-2016 Mitchell mitchell.att.foicica.com. See LICENSE.

local M = {}

--[[ This comment is for LuaDoc.
---
-- Handles file type detection for Textadept.
-- @field _G.events.LEXER_LOADED (string)
--   Emitted after loading a language lexer.
--   This is useful for overriding a language module's key bindings or other
--   properties since the module is not loaded when Textadept starts.
--   Arguments:
--
--   * *`lexer`*: The language lexer's name.
module('textadept.file_types')]]

-- Events.
events.LEXER_LOADED = 'lexer_loaded'

---
-- Map of file extensions to their associated lexer names.
-- If the file type is not recognized by its first-line, each file extension is
-- matched against the file's extension.
-- @class table
-- @name extensions
M.extensions = {--[[Actionscript]]as='actionscript',asc='actionscript',--[[Ada]]adb='ada',ads='ada',--[[ANTLR]]g='antlr',g4='antlr',--[[APDL]]ans='apdl',inp='apdl',mac='apdl',--[[APL]]apl='apl',--[[Applescript]]applescript='applescript',--[[ASM]]asm='asm',ASM='asm',s='asm',S='asm',--[[ASP]]asa='asp',asp='asp',hta='asp',--[[AutoIt]]au3='autoit',a3x='autoit',--[[AWK]]awk='awk',--[[Batch]]bat='batch',cmd='batch',--[[BibTeX]]bib='bibtex',--[[Boo]]boo='boo',--[[C#]]cs='csharp',--[[C/C++]]c='ansi_c',cc='ansi_c',C='ansi_c',cpp='cpp',cxx='cpp',['c++']='cpp',h='cpp',hh='cpp',hpp='cpp',hxx='cpp',['h++']='cpp',--[[ChucK]]ck='chuck',--[[CMake]]cmake='cmake',['cmake.in']='cmake',ctest='cmake',['ctest.in']='cmake',--[[CoffeeScript]]coffee='coffeescript',--[[CSS]]css='css',--[[CUDA]]cu='cuda',cuh='cuda',--[[D]]d='dmd',di='dmd',--[[Dart]]dart='dart',--[[Desktop]]desktop='desktop',--[[diff]]diff='diff',patch='diff',--[[Dockerfile]]Dockerfile='dockerfile',--[[dot]]dot='dot',--[[Eiffel]]e='eiffel',eif='eiffel',--[[Elixir]]ex='elixir',exs='elixir',--[[Erlang]]erl='erlang',hrl='erlang',--[[F#]]fs='fsharp',--[[Faust]]dsp='faust',--[[Fish]]fish='fish',--[[Forth]]forth='forth',frt='forth',fs='forth',--[[Fortran]]f='fortran',['for']='fortran',ftn='fortran',fpp='fortran',f77='fortran',f90='fortran',f95='fortran',f03='fortran',f08='fortran',--[[Gap]]g='gap',gd='gap',gi='gap',gap='gap',--[[Gettext]]po='gettext',pot='gettext',--[[Gherkin]]feature='gherkin',--[[GLSL]]glslf='glsl',glslv='glsl',--[[GNUPlot]]dem='gnuplot',plt='gnuplot',--[[Go]]go='go',--[[Groovy]]groovy='groovy',gvy='groovy',--[[Gtkrc]]gtkrc='gtkrc',--[[Haskell]]hs='haskell',--[[HTML]]htm='html',html='html',shtm='html',shtml='html',xhtml='html',--[[Icon]]icn='icon',--[[IDL]]idl='idl',odl='idl',--[[Inform]]inf='inform',ni='inform',--[[ini]]cfg='ini',cnf='ini',inf='ini',ini='ini',reg='ini',--[[Io]]io='io_lang',--[[Java]]bsh='java',java='java',--[[Javascript]]js='javascript',jsfl='javascript',--[[JSON]]json='json',--[[JSP]]jsp='jsp',--[[LaTeX]]bbl='latex',dtx='latex',ins='latex',ltx='latex',tex='latex',sty='latex',--[[Ledger]]ledger='ledger',journal='ledger',--[[LESS]]less='less',--[[LilyPond]]lily='lilypond',ly='lilypond',--[[Lisp]]cl='lisp',el='lisp',lisp='lisp',lsp='lisp',--[[Literate Coffeescript]]litcoffee='litcoffee',--[[Lua]]lua='lua',--[[Makefile]]GNUmakefile='makefile',iface='makefile',mak='makefile',makefile='makefile',Makefile='makefile',--[[Man]]['1']='man',['2']='man',['3']='man',['4']='man',['5']='man',['6']='man',['7']='man',['8']='man',['9']='man',['1x']='man',['2x']='man',['3x']='man',['4x']='man',['5x']='man',['6x']='man',['7x']='man',['8x']='man',['9x']='man',--[[Markdown]]md='markdown',--[[MoonScript]]moon='moon',--[[Nemerle]]n='nemerle',--[[Nim]]nim='nim',--[[NSIS]]nsh='nsis',nsi='nsis',nsis='nsis',--[[Objective C]]m='objective_c',mm='objective_c',objc='objective_c',--[[OCaml]]caml='caml',ml='caml',mli='caml',mll='caml',mly='caml',--[[Pascal]]dpk='pascal',dpr='pascal',p='pascal',pas='pascal',--[[Perl]]al='perl',perl='perl',pl='perl',pm='perl',pod='perl',--[[PHP]]inc='php',php='php',php3='php',php4='php',phtml='php',--[[PICO-8]]p8='pico',--[[Pike]]pike='pike',pmod='pike',--[[PKGBUILD]]PKGBUILD='pkgbuild',--[[Postscript]]eps='ps',ps='ps',--[[PowerShell]]ps1='powershell',--[[Prolog]]prolog='prolog',--[[Properties]]props='props',properties='props',--[[Pure]]pure='pure',--[[Python]]sc='python',py='python',pyw='python',--[[R]]R='rstats',Rout='rstats',Rhistory='rstats',Rt='rstats',['Rout.save']='rstats',['Rout.fail']='rstats',S='rstats',--[[REBOL]]r='rebol',reb='rebol',--[[reST]]rst='rest',--[[Rexx]]orx='rexx',rex='rexx',--[[RHTML]]erb='rhtml',rhtml='rhtml',--[[Ruby]]Rakefile='ruby',rake='ruby',rb='ruby',rbw='ruby',--[[Rust]]rs='rust',--[[Sass CSS]]sass='sass',scss='sass',--[[Scala]]scala='scala',--[[Scheme]]sch='scheme',scm='scheme',--[[Shell]]bash='bash',bashrc='bash',bash_profile='bash',configure='bash',csh='bash',sh='bash',zsh='bash',--[[Smalltalk]]changes='smalltalk',st='smalltalk',sources='smalltalk',--[[SNOBOL4]]sno='snobol4',SNO='snobol4',--[[SQL]]ddl='sql',sql='sql',--[[TaskPaper]]taskpaper='taskpaper',--[[Tcl]]tcl='tcl',tk='tcl',--[[Texinfo]]texi='texinfo',--[[TOML]]toml='toml',--[[Vala]]vala='vala',--[[vCard]]vcf='vcard',vcard='vcard',--[[Verilog]]v='verilog',ver='verilog',--[[VHDL]]vh='vhdl',vhd='vhdl',vhdl='vhdl',--[[Visual Basic]]asa='vb',bas='vb',cls='vb',ctl='vb',dob='vb',dsm='vb',dsr='vb',frm='vb',pag='vb',vb='vb',vba='vb',vbs='vb',--[[WSF]]wsf='wsf',--[[XML]]dtd='xml',svg='xml',xml='xml',xsd='xml',xsl='xml',xslt='xml',xul='xml',--[[Xtend]]xtend='xtend',--[[YAML]]yaml='yaml'}

---
-- Map of first-line patterns to their associated lexer names.
-- Each pattern is matched against the first line in the file.
-- @class table
-- @name patterns
M.patterns = {['^#!.+[/ ][gm]?awk']='awk',['^#!.+[/ ]lua']='lua',['^#!.+[/ ]octave']='matlab',['^#!.+[/ ]perl']='perl',['^#!.+[/ ]php']='php',['^#!.+[/ ]python']='python',['^#!.+[/ ]ruby']='ruby',['^#!.+[/ ]bash']='bash',['^#!.+/sh']='bash',['^%s*class%s+%S+%s*<%s*ApplicationController']='rails',['^%s*class%s+%S+%s*<%s*ActionController::Base']='rails',['^%s*class%s+%S+%s*<%s*ActiveRecord::Base']='rails',['^%s*class%s+%S+%s*<%s*ActiveRecord::Migration']='rails',['^%s*<%?xml%s']='xml'}

---
-- List of available lexer names.
-- @class table
-- @name lexers
M.lexers = {}

local GETLEXERLANGUAGE = _SCINTILLA.properties.lexer_language[1]
-- LuaDoc is in core/.buffer.luadoc.
local function get_lexer(buffer, current)
  local lexer = buffer:private_lexer_call(GETLEXERLANGUAGE)
  return current and lexer:match('[^/]+$') or lexer:match('^[^/]+')
end

-- Attempts to detect the language based on a buffer's first line of text or
-- that buffer's filename.
-- @param buffer The buffer to detect the language of.
-- @return lexer language
local function detect_language(buffer)
  local line = buffer:get_line(0)
  -- Detect from first line.
  for patt, lexer in pairs(M.patterns) do
    if line:find(patt) then return lexer end
  end
  -- Detect from file extension.
  return buffer.filename and M.extensions[buffer.filename:match('[^/\\.]+$')] or
         'text'
end

local SETDIRECTPOINTER = _SCINTILLA.properties.doc_pointer[2]
local SETLEXERLANGUAGE = _SCINTILLA.properties.lexer_language[2]
-- LuaDoc is in core/.buffer.luadoc.
local function set_lexer(buffer, lang)
  if not lang then lang = detect_language(buffer) end
  buffer:private_lexer_call(SETDIRECTPOINTER, buffer.direct_pointer)
  buffer:private_lexer_call(SETLEXERLANGUAGE, lang)
  buffer._lexer = lang
  if package.searchpath(lang, package.path) then _M[lang] = require(lang) end
  if buffer ~= ui.command_entry then events.emit(events.LEXER_LOADED, lang) end
  local last_line = buffer.first_visible_line + buffer.lines_on_screen
  buffer:colourise(0, buffer:position_from_line(last_line + 1))
end

-- Gives new buffers lexer-specific functions.
events.connect(events.BUFFER_NEW, function()
  buffer.get_lexer, buffer.set_lexer = get_lexer, set_lexer
  buffer.style_name = setmetatable({}, {
    __index = function(_, style_num) -- LuaDoc is in core/.buffer.luadoc
      return style_num >= 0 and style_num <= 255 and
             buffer:private_lexer_call(style_num) or nil
    end,
    __newindex = function() error('read-only property') end
  })
end, 1)

-- Auto-detect lexer on file open or save as.
events.connect(events.FILE_OPENED, function() buffer:set_lexer() end)
events.connect(events.FILE_AFTER_SAVE, function(_, saved_as)
  if saved_as then buffer:set_lexer() end
end)

-- Restores the buffer's lexer, primarily for the side-effect of emitting
-- `events.LEXER_LOADED`.
local function restore_lexer() buffer:set_lexer(buffer._lexer) end
events.connect(events.BUFFER_AFTER_SWITCH, restore_lexer)
events.connect(events.VIEW_AFTER_SWITCH, restore_lexer)
events.connect(events.VIEW_NEW, restore_lexer)
events.connect(events.RESET_AFTER, restore_lexer)

-- Generate lexer list.
local lexers_found = {}
for _, dir in ipairs{_HOME..'/lexers', _USERHOME..'/lexers'} do
  if lfs.attributes(dir) then
    for lexer in lfs.dir(dir) do
      if lexer:find('%.lua$') and lexer ~= 'lexer.lua' then
        lexers_found[lexer:match('^(.+)%.lua$')] = true
      end
    end
  end
end
for lexer in pairs(lexers_found) do
  M.lexers[#M.lexers + 1] = lexer:iconv('UTF-8', _CHARSET)
end
table.sort(M.lexers)

---
-- Prompts the user to select a lexer for the current buffer.
-- @see buffer.set_lexer
-- @name select_lexer
function M.select_lexer()
  local button, i = ui.dialogs.filteredlist{
    title = _L['Select Lexer'], columns = _L['Name'], items = M.lexers
  }
  if button == 1 and i then buffer:set_lexer(M.lexers[i]) end
end

return M
