A suggested walkthrough if you're using this as training material.

### Sequential user ID
* Sign up and view signed up page

### No failed auth attempt limits
* Run script in stupid-bank/scripts/bruteforce.rb

### Unchecked access control
* Change id on /accounts path

### XSS (reflected)
* Create account
* Change PIN
* Show cross-domain attack at https://operator.nz/security/xss.html

### Insecure use of untrusted data
* Change admin cookie

### Session replay
* Copy cookie and replay

### XSS (persistent)
* Send mail
* Read mail

### SQL injection
* Change account name

### CSRF
* Show cross-domain attack at https://operator.nz/security/csrf.html

### Data validation
* Negative transfer amount

### Non-atomic db transactions
* Pay someone with too-long field
