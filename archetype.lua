-- rust-clap-cli-archetype
--
-- Scaffolds a Rust CLI binary using clap derive, composed with
-- rust-xtask-component for a full SDLC workflow.

local context = Context.new()

-- ── Identity prompts (composed) ────────────────────────────────────
context:merge(catalog.render("org-prompts", context))

context:set("suffix_options", { "cli" })
context:set("suffix_default", "cli")
context:merge(catalog.render("project-prompts", context))

context:merge(catalog.render("author-prompts", context))

-- ── Optional GitHub ────────────────────────────────────────────────
context:prompt_confirm("Publish to GitHub?", "use_github", { default = false })
if context:get("use_github") then
    context:set("repo_name", context:get("project_name"))
    context:merge(catalog.render("github-prompts", context))
end

-- ── Compose xtask component (always) ───────────────────────────────
context:merge(catalog.render("xtask", context))

-- ── Render project tree ────────────────────────────────────────────
directory.render("contents", context)

-- ── Post-render: git init + initial commit ─────────────────────────
-- Renders into the destination directly (no `{{ project_name }}/` wrapper)
-- so the parent and xtask component land in a single workspace root.
local git = require("archetect.git")
local repo = git.init(nil, { branch = "main" })
repo:add_all()
repo:commit("initial commit")

if context:get("use_github") then
    log.info("")
    log.info("Next steps:")
    log.info("  gh repo create " .. context:get("github_slug") .. " --public --source=. --remote=origin")
    log.info("  git push -u origin HEAD")
    log.info("")
end
