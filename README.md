# Cloud Inventory Management

## Setup

```
bundle
bin/rails db:setup
bin/rails db:migrate
```

## Fetching Data

```
bin/rake cloud_instance:fetch_all
```

## Testing

```
bin/rspec
```