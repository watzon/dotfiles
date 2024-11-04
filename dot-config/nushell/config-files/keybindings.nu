# Keybinding configurations
export def get_keybindings [] {
    [
        {
            name: completion_menu
            modifier: none
            keycode: tab
            mode: [emacs vi_normal vi_insert]
            event: {
                until: [
                    { send: menu name: completion_menu }
                    { send: menunext }
                    { edit: complete }
                ]
            }
        }
        {
            name: reload_config
            modifier: none
            keycode: f5
            mode: [emacs vi_normal vi_insert]
            event: {
                send: executehostcommand
                cmd: $"source '($nu.env-path)';source '($nu.config-path)'"
            }
        }
    ]
} 