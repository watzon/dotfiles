# Git wrapper with enhanced functionality
def g [
    command?: string@"nu-complete git-commands" # The git command to run
    ...args                                     # Additional arguments
] {
    match $command {
        "help" => {
            print $"(ansi green_bold)Enhanced Git Wrapper(ansi reset)"
            print ""
            print $"(ansi yellow_bold)Usage:(ansi reset) g <command> [args]"
            print ""
            print $"(ansi cyan_bold)Enhanced Commands:(ansi reset)"
            print "g log              # formatted git log with columns"
            print "g status          # formatted git status"
            print "g diff [pattern]  # git diff with optional file filter"
            print "g branch          # branches sorted by date"
            print "g files [count]   # files changed in last N commits"
            print "g checkout        # interactive branch selection"
            print "g commit         # conventional commit helper"
            print ""
            print $"(ansi cyan_bold)Filtering Examples:(ansi reset)"
            print "g log | where subject =~ 'fix'          # find fix commits"
            print "g status | where status == 'M'          # show modified files"
            print "g files 5 | where status == 'modified'  # recent modified files"
            print "g branch | where date > '2024-01-01'    # recent branches"
            print ""
            print $"(ansi cyan_bold)Conventional Commits:(ansi reset)"
            print "g commit feat 'new feature'"
            print "g commit fix 'bug fix' -s auth"
            print "g commit docs 'update README'"
        }
        "log" => { git-formatted-log }
        "status" => { git-formatted-status }
        "diff" => { git-formatted-diff ...$args }
        "branch" => { git-formatted-branches }
        "files" => { git-files-changed ...$args }
        "checkout" => { git-checkout ...$args }
        "commit" => { 
            # Check if we have at least type and message
            if ($args | length) < 2 {
                error make {msg: "Usage: g commit <type> <message> [--scope <scope>]"}
            }
            let type = $args.0
            let message = $args.1
            let rest_args = if ($args | length) > 2 { 
                $args | range 2.. 
            } else { 
                [] 
            }
            git-conventional-commit $type $message ...$rest_args
        }
        null => { git-formatted-status }  # default to status when no command given
        _ => { git $command ...$args }  # passthrough to git
    }
}

# Git command completions
def "nu-complete git-commands" [] {
    [
        # Help command
        "help",
        
        # Enhanced commands
        "log",
        "status",
        "diff",
        "branch",
        "files",
        "checkout",
        "commit",
        
        # Common git commands (passthrough)
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
    ]
}

# Completions for commit types when using 'g commit'
def "nu-complete git-commit-type" [] {
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

# Internal helper functions

def git-formatted-log [] {
    git log --pretty=%h»¦«%s»¦«%aN»¦«%aE»¦«%aD -n 25 
    | lines 
    | split column "»¦«" commit subject name email date 
    | upsert date {|d| $d.date | into datetime} 
    | sort-by date 
    | reverse
}

def git-formatted-status [] {
    git status --short --branch --long --untracked-files=all
}

def git-formatted-diff [
    ...args: string  # Optional file pattern and other git diff arguments
] {
    if ($args | length) > 0 {
        git diff --name-status ...$args
    } else {
        git diff --name-status
    }
}

def git-formatted-branches [] {
    git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)»¦«%(committerdate:iso8601)»¦«%(committername)»¦«%(subject)'
    | lines
    | split column "»¦«" branch date author message
    | upsert date {|d| $d.date | into datetime}
}

def git-files-changed [
    count?: int = 1  # Number of commits to look back (default: 1)
    ...args: string  # Additional git log arguments
] {
    git log --name-status -n $count --pretty=format:"»¦«%h»¦«%s»¦«%aN»¦«%aD" ...$args
    | lines
    | split column "»¦«" status commit subject author date
    | where status != ""
    | upsert status {|r| 
        match $r.status {
            /^M/ => "modified",
            /^A/ => "added",
            /^D/ => "deleted",
            /^R/ => "renamed",
            _ => $r.status
        }
    }
    | sort-by status
}

def git-checkout [
    pattern?: string  # Optional search pattern for branch names
    ...args: string  # Additional git checkout arguments
] {
    let branches = (git branch --all 
        | lines 
        | str trim 
        | where not ($it | str starts-with "*")
        | str replace "remotes/origin/" ""
        | uniq
        | sort)

    let selected = if ($pattern != null) {
        $branches | where $it =~ $pattern | input list -f "Select branch:"
    } else {
        $branches | input list -f "Select branch:"
    }

    if ($selected | is-empty) {
        error make {msg: "No branch selected"}
    }
    git checkout $selected ...$args
}

def git-conventional-commit [
    type: string@"nu-complete git-commit-type",  # Commit type
    message: string,                             # Commit message
    --scope(-s): string                         # Optional scope
    ...args: string                             # Additional git commit arguments
] {
    let commit_msg = if ($scope != null) {
        $"($type)($scope): ($message)"
    } else {
        $"($type): ($message)"
    }
    git commit -m $commit_msg ...$args
}

