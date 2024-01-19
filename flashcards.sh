#!/bin/bash
set +x

# This script was designed with the purpose of making studying a little easier
# Hopefully it helps!

# Set colors
QUESTION=$(tput setaf 11)
ANSWER=$(tput setaf 10)
RESET=$(tput sgr0)

# Check for jq binary as a pre-requisite
if ! command -v jq >/dev/null; then echo "Must have jq binary installed... Exiting."; exit 1; fi

# Set question count
Q_COUNT=$(expr $(jq < questions.json | jq .questions[] | wc -l) - 1)

# Start flashcard session
while :; do
    RANDOM_Q=$(shuf -i 0-"${Q_COUNT}" -n 1)
    clear
    echo
    echo "${QUESTION}$(jq -r .questions[${RANDOM_Q}] < questions.json)${RESET}"
    echo
    echo
    read -p "Press enter for answer..."
    echo
    echo "${ANSWER}$(jq -r .answers[${RANDOM_Q}] < questions.json)${RESET}"
    echo
    echo
    read -p "Press enter for next question..."
    clear
done
