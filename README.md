# App tvOS de teste para câmeras do ICSee

Este repositório contém um exemplo em **Swift + SwiftUI (tvOS)** para testar reprodução de câmeras em uma Apple TV (32 GB).

## Ponto importante sobre ICSee

O app ICSee normalmente usa fluxo proprietário (P2P). Para reproduzir no seu app de Apple TV, você precisa de um stream padrão, como:

- `rtsp://...`
- `http(s)://...m3u8` (HLS)

Se a câmera/NVR não expor RTSP/HLS, o app da Apple TV não conseguirá tocar diretamente.

## O que este exemplo faz

- Lista câmeras configuradas localmente.
- Faz uma checagem simples se a URL parece válida para streaming.
- Reproduz o stream com `AVPlayer` em tela cheia (`VideoPlayer`).

## Como testar na Apple TV

1. No Xcode, crie um projeto **App (tvOS)**.
2. Copie os arquivos de `Sources/` para dentro do projeto.
3. Defina `ICSeeTVTestApp` como ponto de entrada.
4. Ajuste as URLs das câmeras em `CameraListViewModel.swift`.
5. Rode em uma Apple TV física na mesma rede das câmeras.

## Observações de rede

- Em rede local, prefira IP fixo para câmeras.
- Se usar HTTP sem TLS, talvez seja necessário configurar ATS no `Info.plist`.
- Muitos streams RTSP podem exigir usuário/senha na própria URL.

## Próximos passos sugeridos

- Adicionar tela de login para credenciais.
- Salvar lista de câmeras em `UserDefaults` ou `CoreData`.
- Incluir visualização em grid para múltiplas câmeras.
