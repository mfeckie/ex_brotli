if Code.ensure_loaded?(Phoenix) do
  defmodule ExBrotli.DigesterCompressor do
    @behaviour Phoenix.Digester.Compressor

    def compress_file(file_path, content) do
      valid_extension =
        Path.extname(file_path) in Application.fetch_env!(:phoenix, :gzippable_exts)

      if valid_extension do
        compressed_content = ExBrotli.compress!(content)
        {:ok, compressed_content}
      else
        :error
      end
    end

    def file_extensions() do
      [".br"]
    end
  end
end
