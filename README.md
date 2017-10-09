# Cloud Inventory Management

## Setup

```bash
bundle
bin/rails db:setup
```

Populate accounts:

```bash
cat ~/.aws/credentials | \
  grep "^\[.\+\]$" | \
  sed s/"^\[\(.*\)]"/\\1/ | \
  xargs bin/rails runner 'ARGV.each { |s| Account.find_or_create_by(name: s) }'
```

Fetch cloud data:

```bash
bin/rake cloud_instance:fetch_all
```

## Testing

```bash
bin/rspec
```
