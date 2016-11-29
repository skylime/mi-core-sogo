# mi-core-sogo

## description

Create zone with [SOGo](https://sogo.nu) groupware.
Share your calendars, address books and mails in your community.


## mdata variables

- `submission_addr` [*]: hostname for submission smtp server
- `mbox_addr` [*]: hostname of imap (and sieve) server
- `sogo_ssl`: ssl cert, key and CA for https in pem format

[*] is required to work properly.

## services

- `80/tcp`: http (redirects to https)
- `443/tcp`: https

