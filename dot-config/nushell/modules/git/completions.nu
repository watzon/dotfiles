# Command completions
export def "nu-complete git-commands" [] {
    [
        "help",
        "log",
        "status", 
        "diff",
        "branch",
        "files",
        "checkout",
        "commit",
        "add",
        "push",
        "pull",
        "merge",
        "rebase",
        "reset",
        "stash",
        "tag",
        "remote",
        "fetch",
        "yolo",
    ]
}

# Commit type completions
export def "nu-complete git-commit-type" [] {
    [
        "feat",     # New feature
        "fix",      # Bug fix
        "docs",     # Documentation only changes
        "style",    # Changes that do not affect the meaning of the code
        "refactor", # Code change that neither fixes a bug nor adds a feature
        "perf",     # Code change that improves performance
        "test",     # Adding missing tests or correcting existing tests
        "build",    # Changes that affect the build system or external dependencies
        "ci",       # Changes to CI configuration files and scripts
        "chore",    # Other changes that don't modify src or test files
        "revert",   # Reverts a previous commit
    ]
}

# Define command signatures for completions
export extern "g commit" [
    type: string@"nu-complete git-commit-type"   # Type of commit
    message: string                              # Commit message
    --scope(-s): string                         # Optional scope
] 