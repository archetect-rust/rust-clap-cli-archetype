# {{ project_name }}

{{ description | default("A Rust CLI application.") }}

## Quick start

```bash
cargo run -- hello
cargo run -- hello Ada
```

## Development

This project ships with an `xtask` workflow for all SDLC operations.

| Command | Purpose |
|---|---|
{% for c in components.xtask.dev_commands %}
| `{{ c.name }}` | {{ c.description }} |
{% end %}

## License

{{ license | default("Unlicensed") }}
