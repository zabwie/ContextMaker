@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion
cls
python --version > nul 2>&1
if errorlevel 1 (
    echo Python is not installed! Please install Python 3.x
    pause
    exit /b 1
)

if not exist "venv" (
    echo Creating virtual environment...
    python -m venv venv
    call venv\Scripts\activate
    echo Installing dependencies...
    pip install -r requirements.txt
) else (
    call venv\Scripts\activate
)

ollama --version > nul 2>&1
if errorlevel 1 (
    echo Ollama is not installed! Please install from https://ollama.ai/
    pause
    exit /b 1
)

:model_select
cls
echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║                  LLaMA 2 Model Selection                   ║
echo ╠════════════════════════════════════════════════════════════╣
echo ║                                                            ║
echo ║      Select a model:                                       ║
echo ║                                                            ║
echo ║      1. 7B model (smallest size, fastest)                  ║
echo ║      2. 13B model (balanced size/speed)                    ║
echo ║      3. 70B model (largest size, best quality)             ║
echo ║                                                            ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

set /p "model_choice=Your choice (1-3): "

if "%model_choice%"=="1" (
    set "model=llama2:7b"
    set "model_desc=7B parameter model"
    echo Pulling LLaMA 2 7B model... This might take a while.
    ollama pull llama2:7b
    if errorlevel 1 (
        echo Failed to pull model. Please check your internet connection and try again.
        pause
        goto model_select
    )
    goto menu
) else if "%model_choice%"=="2" (
    set "model=llama2:13b"
    set "model_desc=13B parameter model"
    echo Pulling LLaMA 2 13B model... This might take a while.
    ollama pull llama2:13b
    if errorlevel 1 (
        echo Failed to pull model. Please check your internet connection and try again.
        pause
        goto model_select
    )
    goto menu
) else if "%model_choice%"=="3" (
    set "model=llama2:70b"
    set "model_desc=70B parameter model"
    echo Pulling LLaMA 2 70B model... This might take a while.
    ollama pull llama2:70b
    if errorlevel 1 (
        echo Failed to pull model. Please check your internet connection and try again.
        pause
        goto model_select
    )
    goto menu
) else (
    echo Invalid choice! Please select 1, 2, or 3.
    timeout /t 2 > nul
    goto model_select
)

:: Why do I have an "indent" in the echo? Well, it's because when I run it, it isn't alighned with the other text.
:menu
cls
echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║                     CONTEXT MAKER v1.0                     ║
echo ╠════════════════════════════════════════════════════════════╣
echo ║                                                            ║
echo ║      Current Model: %model_desc%                     ║
echo ║      Enter your project idea below:                        ║
echo ║                                                            ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

set /p "project_idea=Your idea: "

if "%project_idea%"=="" (
    echo Please enter a project idea!
    timeout /t 2 > nul
    goto menu
)

echo.
echo Generating context.md... This might take a while.
echo.

:: Create contexts directory if it doesn't exist
if not exist "contexts" mkdir contexts

:: Generate timestamp for unique filename
set "timestamp=%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "timestamp=!timestamp: =0!"

:: Set the output file path
set "output_file=contexts\context_!timestamp!.md"

:: Run the Python script with the output file and redirect stderr to null
python contextmaker.py "%project_idea%" --model "%model%" --output "%output_file%" 2>nul

if errorlevel 1 (
    echo An error occurred while generating the context.
    pause
    exit /b 1
)

echo.
echo Context generated successfully!
echo Opening: !output_file!
timeout /t 2 > nul

:: Try to open with default markdown viewer, fallback to notepad
start "" "!output_file!" 2>nul || notepad "!output_file!"

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║                     CONTEXT MAKER v1.0                     ║
echo ╠════════════════════════════════════════════════════════════╣
echo ║                                                            ║
echo ║      What would you like to do?                            ║
echo ║      1. Generate another context                           ║
echo ║      2. Change model                                       ║
echo ║      3. Exit                                               ║
echo ║                                                            ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

set /p "choice=Your choice (1-3): "

if "%choice%"=="1" goto menu
if "%choice%"=="2" goto model_select
if "%choice%"=="3" goto end

:end
echo.
echo Thanks for using Context Maker! Goodbye!
timeout /t 2 > nul
exit /b 0 