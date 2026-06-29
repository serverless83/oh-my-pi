FROM ghcr.io/serverless83/oh-my-pi:latest

RUN apt-get update && apt-get install -y --no-install-recommends tmux \
    && rm -rf /var/lib/apt/lists/*

RUN printf '%s\n' \
    '#!/bin/sh' \
    'set -euo pipefail' \
    '' \
    'if ! tmux has-session -t omp 2>/dev/null; then' \
    '  tmux new-session -d -s omp "/usr/local/bin/omp $@"' \
    '  echo "=== omp avviato in tmux ==="' \
    '  echo "Apri una shell e fai: tmux attach -t omp"' \
    'fi' \
    'exec sleep infinity' \
    > /entrypoint.sh \
    && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["cli"]
