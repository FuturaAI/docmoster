# wait for the docmost to be ready
echo "Waiting for docmost to boot up; this may take a minute or two..."
echo "If this takes more than ~5 minutes, check the logs of the docmost container for errors with the following command:"
echo
echo "docker logs docmost-stack_docmost"
echo

while true; do
  # Use curl to send a request and capture the HTTP status code
  status_code=$(curl -o /dev/null -s -w "%{http_code}\n" "http://docmost:3000/")
  
  # Check if the status code is 200
  if [ "$status_code" -eq 200 ]; then
    echo "docmost responded with 200, starting nginx..."
    break  # Exit the loop
  else
    echo "docmost responded with $status_code, retrying in 5 seconds..."
    sleep 5  # Sleep for 5 seconds before retrying
  fi
done

# Start nginx and reload every 6 hours
while :; do sleep 6h & wait; nginx -s reload; done & nginx -g "daemon off;"
