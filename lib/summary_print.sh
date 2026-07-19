#!/bin/bash

summary_print() {
    echo ""
    echo "=================================================="
    echo -e "${YELLOW}                  Audit Summary${NC}"
    echo "=================================================="
    echo -e "${RED}Critical: $CRITICAL_COUNT${NC}"
    echo -e "${YELLOW}Warning:  $WARNING_COUNT${NC}"
    echo -e "${BLUE}Info:     $INFO_COUNT${NC}"
    echo "=================================================="
}
