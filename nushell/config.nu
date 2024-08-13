$env.config = {
  show_banner: false
  edit_mode: vi
  hooks: {
    pre_prompt: [{ ||
      if (which direnv | is-empty) {
        return
      }

      direnv export json | from json | default {} | load-env
    }]
  }
}
$env.EDITOR = 'hx'
