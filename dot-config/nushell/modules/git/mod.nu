use completions.nu *

# Main command
export def --wrapped g [command?: string, ...args: string] {
    ^git $command ...$args
}

# Git log with better formatting
export def "g log" [] {
    git log --pretty=%h»¦«%s»¦«%aN»¦«%aE»¦«%aD -n 25 
    | lines 
    | split column "»¦«" commit subject name email date 
    | upsert date {|d| $d.date | into datetime} 
    | sort-by date 
    | reverse
}

# Git status with better formatting
export def "g status" [] {
    git status --short --branch --long --untracked-files=all
}

# Git diff with better formatting
export def "g diff" [...args: string] {
    if ($args | length) > 0 {
        git diff --name-status ...$args
    } else {
        git diff --name-status
    }
}

# Git branch with better formatting
export def "g branch" [] {
    git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)»¦«%(committerdate:iso8601)»¦«%(committername)»¦«%(subject)'
    | lines
    | split column "»¦«" branch date author message
    | upsert date {|d| $d.date | into datetime}
}

# Get files changed in last N commits
export def "g files" [
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

# Interactive branch selection
export def "g checkout" [
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

# Conventional commit helper
export def "g commit" [
    type: string@"nu-complete git-commit-type"  # Commit type
    message: string                             # Commit message
    --scope(-s): string                        # Optional scope
    ...args: string                            # Additional git commit arguments
] {
    let commit_msg = if ($scope != null) {
        $"($type)($scope): ($message)"
    } else {
        $"($type): ($message)"
    }
    git commit -m $commit_msg ...$args
}

# YOLO commit
export def "g yolo" [] {
    # Get a random commit message from whatthecommit.com
    let msg = (http get http://whatthecommit.com/index.txt | str trim)
    
    # Stage all changes, commit with random message, and force push
    git add -A
    git commit -m $msg
    git push -f origin main
}