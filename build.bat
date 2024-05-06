@echo off
rem Define variables
set PROJECT_NAME=flappy_ghost
set WASM_SRC_DIR=target\wasm32-unknown-unknown\release
set WASM_BUILD_DIR=wasm

rem Define default target
call :all

rem Define commands
:build
cargo build --release --target wasm32-unknown-unknown
goto :eof

:bindgen
wasm-bindgen %WASM_SRC_DIR%\%PROJECT_NAME%.wasm --out-dir %WASM_BUILD_DIR% --no-modules --no-typescript
goto :eof

:rename
move %WASM_BUILD_DIR%\%PROJECT_NAME%.js %WASM_BUILD_DIR%\myblob.js
move %WASM_BUILD_DIR%\%PROJECT_NAME%_bg.wasm %WASM_BUILD_DIR%\myblob_bg.wasm
goto :eof

:all
call :build
call :bindgen
call :rename
goto :eof
