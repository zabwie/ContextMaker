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

# Project
- Clear and concise project title

# Summary
- 1-2 paragraph summary of the project

# Project Overview
- Problem Statement: What problem does this project solve?
- Target Audience: Who is this project for?
- Value Proposition: What unique value does it provide?

# Goals
- Primary Objectives: What are the main goals?
- Success Criteria: How will we measure success?
- Key Performance Indicators (KPIs): What metrics will we track?

# Features
- Core Features: What are the main functionalities?
- User Interface: How will users interact with it?
- Data Management: How will data be handled?
- Security & Privacy: What security measures are needed?

# User Flow
- User Journey: How will users navigate through the system?
- Use Cases: What are the main use cases?
- User Stories: What are the key user stories?

# Technical Stack
- Frontend: What frontend technologies will be used?
- Backend: What backend technologies will be used?
- Database: What database solutions will be used?
- Infrastructure: What infrastructure will be needed?
- Third-Party Services: What external services will be integrated?

# Development Plan
- Phase 1: MVP - What features will be included in the initial release?
- Phase 2: Enhancement - What improvements will be made after MVP?
- Phase 3: Scale - How will the project scale?

# Challenges
- Technical Challenges: What technical obstacles might we face?
- Business Challenges: What business challenges should we consider?
- Risk Mitigation: How will we address potential risks?

# Future Ideas
- Short-term Enhancements: What improvements can be made soon?
- Long-term Vision: What is the long-term vision for the project?
- Potential Integrations: What other systems could be integrated?

# Resources
- Development Team: What team structure is needed?
- Budget: What are the estimated costs?
- Timeline: What is the projected timeline?

# Appendix
- Glossary: Key terms and definitions
- References: Relevant resources and documentation
- Documentation: What documentation will be needed?

## License

MIT 