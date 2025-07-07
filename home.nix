{ config, pkgs, ... }:

let
  # Define the Python environment Neovim will use.
  # This is the declarative equivalent of your old `~/.venv/nvim`.
  pythonForNeovim = pkgs.python3.withPackages (ps: [
    ps.pynvim  # The bridge package for Neovim
    ps.pillow  # Required by pastify.nvim
  ]);
in

{
	home.username = "taylor";
	home.homeDirectory = "/Users/taylor";
	home.stateVersion = "25.05"; # Please read the comment before changing.

	home.sessionPath = [ "$HOME/.local/bin" ];

	home.packages = with pkgs; [
    gnupg
    sops
		tree
    ripgrep
    fd
    tmux
		neovim
    python3

    # The core Rust toolchain
    rustc
    cargo

    # Optional but recommended tools
    clippy
    rustfmt
    bacon

    # LSPs, linters, debuggers
		deno
		nodejs
    vscode-js-debug
		marksman
    lua-language-server
    rust-analyzer
    vscode-extensions.vadimcn.vscode-lldb.adapter
    prettierd
	];

	home.file = {
		".config/zsh" = {
			source = ./zsh;
			recursive = true;
		};

		".local/bin/tmux-session-picker" = {
		  	source = ./scripts/tmux-session-picker.sh;
		    	executable = true;
		  };

		".config/tmux/.tmux.conf".source = ./dotfiles/.tmux.conf;

		".config/git/config-work" = {
			recursive = true;
			text = ''
				[user]
				name = taylor_monochrome
					email = taylor@monochrome.so
					# For work repos, tell git to use your work SSH key
					[core]
					sshCommand = "ssh -i ~/.ssh/id_ed25519_work"
				'';
		};
	};

	home.sessionVariables = {
		VISUAL = "nvim";
		EDITOR = "nvim";
		MANPAGER = "nvim +Man!";
    PYTHON_FOR_NVIM = "${pythonForNeovim}";
    VSCODE_JS_DEBUG_DIR = "${pkgs.vscode-js-debug}";
	};

# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;

	programs.fzf = {
		enable = true;
		enableZshIntegration = true;
		changeDirWidgetCommand = "fd --type d";
		changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];
		defaultOptions = ["--height 40%" "--border" ];
	};

	programs.git = {
		enable = true;
		userName = "teeeswift";
		userEmail = "chung.taylor1@gmail.com";
		extraConfig = {
			init.defaultBranch = "main";
			includeIf."gitdir:~/projects/work/".path = "~/.config/git/config-work";
		};
	};

	programs.zsh = {
		enable = true;
		autosuggestion = {enable = true;};
		syntaxHighlighting = {enable = true;};
		initContent = ''
			source $HOME/.config/zsh/options.sh
			source $HOME/.config/zsh/aliases.sh
			'';
	};

  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
		# sensible
		yank
		{
			plugin = dracula;
			extraConfig = ''
				set -g @dracula-show-battery false
				set -g @dracula-show-powerline false
				set -g @dracula-refresh-rate 10
				set -g @dracula-plugins " "
				set -g @dracula-show-left-icon "🖤"
			'';
		}
	];

	extraConfig = ''
		source-file $HOME/.config/tmux/.tmux.conf
	'';

  };
}
