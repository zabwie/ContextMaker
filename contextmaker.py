#!/usr/bin/env python3
import os
import click
import ollama
from dotenv import load_dotenv
import yaml
from pathlib import Path

# Load environment variables
load_dotenv()

SYSTEM_PROMPT = """You are a software architect helping to develop project ideas into detailed specifications.
Your task is to expand a brief project description into a comprehensive markdown document.
Be professional but accessible in your tone. Be specific and practical in your suggestions.
Focus on the most important aspects of the project and provide clear, actionable details."""

USER_PROMPT_TEMPLATE = """Based on this project idea:
"{user_idea}"

Generate a detailed markdown document with the following structure:

# Project
[Provide a clear and concise project title]

# Summary
[Provide a 1-2 paragraph summary of the project]

# Project Overview
## Problem Statement
[What problem does this project solve?]

## Target Audience
[Who is this project for?]

## Value Proposition
[What unique value does it provide?]

# Goals
## Primary Objectives
[What are the main goals?]

## Success Criteria
[How will we measure success?]

## Key Performance Indicators (KPIs)
[What metrics will we track?]

# Features
## Core Features
[What are the main functionalities?]

## User Interface
[How will users interact with it?]

## Data Management
[How will data be handled?]

## Security & Privacy
[What security measures are needed?]

# User Flow
## User Journey
[How will users navigate through the system?]

## Use Cases
[What are the main use cases?]

## User Stories
[What are the key user stories?]

# Technical Stack
## Frontend
[What frontend technologies will be used?]

## Backend
[What backend technologies will be used?]

## Database
[What database solutions will be used?]

## Infrastructure
[What infrastructure will be needed?]

## Third-Party Services
[What external services will be integrated?]

# Development Plan
## Phase 1: MVP
[What features will be included in the initial release?]

## Phase 2: Enhancement
[What improvements will be made after MVP?]

## Phase 3: Scale
[How will the project scale?]

# Challenges
## Technical Challenges
[What technical obstacles might we face?]

## Business Challenges
[What business challenges should we consider?]

## Risk Mitigation
[How will we address potential risks?]

# Future Ideas
## Short-term Enhancements
[What improvements can be made soon?]

## Long-term Vision
[What is the long-term vision for the project?]

## Potential Integrations
[What other systems could be integrated?]

# Resources
## Development Team
[What team structure is needed?]

## Budget
[What are the estimated costs?]

## Timeline
[What is the projected timeline?]

# Appendix
## Glossary
[Key terms and definitions]

## References
[Relevant resources and documentation]

## Documentation
[What documentation will be needed?]

Focus on practical, implementable solutions and be specific about technical details.
Keep responses concise but informative."""

def generate_context(prompt: str, model: str = "llama3:8b-q4_0") -> str:
    """Generate context.md content using LLaMA 3 through Ollama."""
    try:
        response = ollama.chat(
            model=model,
            messages=[
                {"role": "system", "content": SYSTEM_PROMPT},
                {"role": "user", "content": USER_PROMPT_TEMPLATE.format(user_idea=prompt)}
            ],
            options={
                "temperature": 0.7,
                "num_predict": 1500,
                "top_k": 40,
                "top_p": 0.9,
                "repeat_penalty": 1.1
            }
        )
        return response['message']['content']
    except Exception as e:
        print(f"Error generating context: {e}")
        raise

def save_context(content: str, output_file: str = "context.md"):
    """Save the generated content to a file."""
    try:
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Successfully created {output_file}")
    except Exception as e:
        print(f"Error saving context file: {e}")
        raise

@click.command()
@click.argument('prompt')
@click.option('--output', '-o', default='context.md', help='Output file path')
@click.option('--model', '-m', default='llama3:8b-q4_0', help='Ollama model to use')
def main(prompt: str, output: str, model: str):
    """Transform a project idea into a detailed context.md file."""
    print("Generating context from prompt...")
    content = generate_context(prompt, model)
    save_context(content, output)

if __name__ == '__main__':
    main() 