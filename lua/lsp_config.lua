vim.lsp.handlers["textDocument/publishDiagnostic"] = vim.lsp.with (
	vim.lsp.diagnostic.on_publish_diafnostics, {
		underline = true,
		virtual_text = false,
		signs = false,
		update_in_insert = true,
	}
)
