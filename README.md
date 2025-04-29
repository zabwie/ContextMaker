# ContextMaker

A tool that transforms project ideas into detailed context specifications using LLaMA models through Ollama.

## Features

- Generate comprehensive project context documents from simple ideas
- Choose from different LLaMA model sizes (7B, 13B, 70B)
- Structured output with detailed sections covering all aspects of a project
- Saves generated contexts with timestamps for easy reference

## Requirements

- Python 3.x
- Ollama (for running LLaMA models)
- Internet connection (for pulling models)

## Installation

1. Clone this repository:
   ```
   git clone https://github.com/zabwie/ContextMaker.git
   cd ContextMaker
   ```

2. Install dependencies:
   ```
   pip install -r requirements.txt
   ```

3. Install Ollama from [https://ollama.ai/](https://ollama.ai/)

## Usage

Run the batch file:
```
run_contextmaker.bat
```

Follow the prompts to:
1. Select a model size
2. Enter your project idea
3. View the generated context

## Output Structure

The generated context includes detailed sections on:
- Project Overview
- Goals
- Features
- User Flow
- Technical Stack
- Development Plan
- Challenges
- Future Ideas
- Resources
- Appendix

## License

MIT 