# rust-clap-cli-archetype

Scaffolds a Rust CLI application using `clap` derive macros, composed
with [`rust-xtask-component`](https://github.com/archetect-rust/rust-xtask-component)
for a full SDLC workflow.

## Layout produced

```
{{ project_name }}/
├── Cargo.toml             # workspace-of-one + main crate
├── .cargo/config.toml     # cargo aliases (xtask)
├── .editorconfig
├── .gitattributes
├── .gitignore
├── rust-toolchain.toml
├── README.md
├── .github/workflows/
│   └── ci.yml             # runs `cargo xtask ci`
├── src/
│   └── main.rs            # clap derive, `hello <name>` subcommand
└── xtask/                 # from rust-xtask-component
    └── ...
```

## Design opinions

- **Single-crate workspace-of-one.** Starts modest; xtask lives
  alongside the main crate from day one.
- **`clap` derive only.** The modern, terse API. Builder variant
  not included.
- **Always includes xtask.** `cargo xtask ci` is the golden entry
  point: runs fmt check, clippy `-D warnings`, and all tests.
- **Error handling via `anyhow`.** Appropriate for a CLI.

## Usage

```bash
archetect render https://github.com/archetect-rust/rust-clap-cli-archetype.git .
```

Or via the master catalog:

```bash
archetect render archetect rust/archetypes/cli/clap-cli
```

## Prompts

Composed from:

| Component | Prompts |
|---|---|
| `org-prompts` | organization, solution name |
| `project-prompts` | project prefix (`suffix` fixed to `cli`) |
| `author-prompts` | author name, email, license |
| `github-prompts` (optional) | GitHub owner, visibility, default branch |

Plus one local prompt: **Publish to GitHub?** (`use_github`).

## Composition contract

Consumes `rust-xtask-component` via `context:merge(...)`. The parent
reads the xtask contribution bag under `components.xtask.*`:

- `workspace_members` → added to top-level `Cargo.toml`
- `cargo_aliases` → emitted into `.cargo/config.toml`
- `dev_commands` → rendered into the project README

## Author

Jimmie Fulton <jimmie.fulton@gmail.com>
