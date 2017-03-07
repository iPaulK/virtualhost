Bash Script to Create Apache Virtual Hosts
==========================================

## Prerequisites
- Apache 2.2+

## Usage

1. Download or clone the script from https://github.com/iPaulK/virtualhost
2. Make it executable:

```
$ chmod +x /path/to/script/virtualhost.sh
```

3. Run the command:

```
$ sudo /path/to/script/virtualhost.sh [domain] [optional directory]
```

## Explanation

Script expects 2 strings as input:

1. Hostname that the server uses to identify itself. E.g.: example.local
2. Directory that Apache looks at to find content to serve. E.g.: /var/www/example.local