# Cloud Inventory Management

## Setup

```bash
bundle && yarn
bin/rails db:reset
```

Fetch cloud data:

```bash
bin/rake cloud_instance:fetch_all
```

## Testing

```bash
bin/rspec
```
