FROM cypress/included:10.6.0

# Use libnss-wrapper to get around editing /etc/passwd
RUN apt install libnss-wrapper

# Ensure we have a cypress config so verify doesn't complain.
WORKDIR /app
COPY . /app

# Follow suggested changes from running cypress as non-root
RUN chmod 775 /root

#ENV DEBUG=cypress.*

ENV CYPRESS_CACHE_LOCATION "/root/.cache/Cypress"

# Additional change to prevent complaints about binary_state.json
# Wildcard to be version-agnostic
RUN chmod 775 /root/.cache/Cypress/*

# Replaces entrypoint from upstream of ["cypress" "run"]

ENTRYPOINT ["/app/prepare.sh"]

CMD ["cypress", "run"]
