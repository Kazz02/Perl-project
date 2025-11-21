# Perl Log Analyzer

A simple Perl script to analyze web server log files.

## Features

- Parses standard access logs.
- Counts requests by IP address.
- Summarizes HTTP status codes (200, 404, etc.).
- Lists the most frequently requested URLs.

## Usage

1. Ensure you have Perl installed.
2. Place your log file in the directory and name it `access.log` (or update the script variable).
3. Run the script:

```bash
perl analyzer.pl
```

To get real data from localhost traffic, you need to run it from Python server:

```
python -m http.server 8080 2>> access.log
```

## Example Output

```text
--- Log Analysis Report ---

Top 5 IP Addresses:
  127.0.0.1       : 3 requests
  192.168.1.1     : 3 requests

Status Codes:
  Code 200  : 7 times
  Code 404  : 1 times
```
