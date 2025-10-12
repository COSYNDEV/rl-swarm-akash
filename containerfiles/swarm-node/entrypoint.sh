#!/usr/bin/env bash

set -euo pipefail

ROOT=/home/gensyn/rl_swarm

# Check if this is first run (no credentials exist)
if [ ! -f "$ROOT/keys/swarm.pem" ] || [ ! -f "$ROOT/modal-login/temp-data/userData.json" ]; then
    echo "=============================================="
    echo "First-time setup required!"
    echo "=============================================="
    echo ""
    echo "Please run the setup script manually:"
    echo "  $ROOT/run_rl_swarm.sh"
    echo ""
    echo "After setup completes, the swarm will auto-start on container restart."
    echo ""

    # Keep container running for user to attach and run setup
    tail -f /dev/null
else
    echo "=============================================="
    echo "Existing setup detected - auto-starting swarm"
    echo "=============================================="

    # Run the script in auto-start mode
    exec /home/gensyn/rl_swarm/run_rl_swarm.sh
fi
