# Plugin configurations
export def get_plugin_config [] {
    {
        plugins: {}
        plugin_gc: {
            default: {
                enabled: true
                stop_after: 10sec
            }
            plugins: {}
        }
    }
} 