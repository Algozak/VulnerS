#!/bin/bash

#Formula
#Penalty_i = Weight_i × Coefficient_i
#Total_Penalty = Σ(Penalty_i)
#Max_Penalty = Σ(Weight_i)
#Security_Score = 10 × (1 - (Total_Penalty / Max_Penalty))

#Weight_i       - importance weight of the check
#Coefficient_i  - impact coefficient based on found issues (0.0 - 1.0)
#Penalty_i      - penalty of one security check
#Total_Penalty  - sum of all penalties
#Max_Penalty    - maximum possible penalty
#Security_Score - final security rating (0-10)

#Final Formula
#Security_Score = 10 × (1 - (Σ(Weight_i × Coefficient_i) / Σ(Weight_i)))

penalty() {

    for check in "${!COEF[@]}"; do

    if [[ -n "${WEIGHT[$check]}" && -n "${COEF[$check]}" ]]; then
        PENALTY[$check]=$(awk "BEGIN {printf \"%.2f\", ${WEIGHT[$check]} * ${COEF[$check]}}")
    fi
    done
}

MAX_PENALTY=0
TOTAL_PENALTY=0

total_penalty() {
    TOTAL_PENALTY=0
    for check in "${!PENALTY[@]}"; do
         TOTAL_PENALTY=$(awk "BEGIN {print $TOTAL_PENALTY + ${PENALTY[$check]}}")
    done
}

max_penalty() {
    MAX_PENALTY=0
    for check in "${!WEIGHT[@]}"; do
         MAX_PENALTY=$(awk "BEGIN {print $MAX_PENALTY + ${WEIGHT[$check]}}")
    done

}

max_penalty
penalty
total_penalty


calculate_score() {
    if (( $(echo "$MAX_PENALTY == 0" | bc -l) )); then
  SCORE=0
        
    else
        SCORE=$(echo "scale=2; 10 * (1 - $TOTAL_PENALTY / $MAX_PENALTY)" | bc)
    fi



    if (( $(echo "$SCORE < 0" | bc -l) )); then
        SCORE=0
    elif (( $(echo "$SCORE > 10" | bc -l) )); then 
        SCORE=10                          
    fi

}

