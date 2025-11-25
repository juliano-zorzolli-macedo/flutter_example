# 💬 Flutter Chat App - Exemplo de Arquitetura

Este repositório é um **projeto de exemplo** que demonstra como construir uma aplicação Flutter escalável e modular.

Ele utiliza uma estrutura de **Monorepo** gerenciada pelo **Melos**, com o objetivo de separar responsabilidades, maximizar o reuso de código e facilitar o desenvolvimento de features em paralelo.

---

## 🏗 Estrutura do Projeto

O workspace é dividido em duas categorias principais:

-   **`apps/`**: Contém os dois pontos de entrada "buildáveis" do projeto.
    -   `chat_app`: O aplicativo principal. Orquestra as features e injeção de dependência.
    -   `ui_catalog`: Um app "Showcase" para visualizar os componentes do `design_system` de forma isolada.
-   **`packages/`**: Contém os módulos compartilhados (bibliotecas).
    -   **`design_system`**: Nosso UI Kit. Contém apenas widgets visuais, temas e cores.
    -   **`feature_chat_list`**: Módulo funcional que implementa a listagem de conversas utilizando **Clean Architecture** e **Cubit**.
    -   **`core_secure_storage`**: Plugin que implementa a comunicação com nativo (MethodChannels) para criptografia e persistência segura.

---

## 🛠 Tech Stack (Guia para Devs Android)

O "De/Para" arquitetural do Flutter em relação ao Android Nativo:

| Conceito           | Android (Kotlin/Jetpack)          | Flutter (Nossa Arquitetura)         |
|:-------------------|:----------------------------------|:------------------------------------|
| **Monorepo Build** | Gradle (include project)          | **Melos**                           |
| **Architecture**   | MVVM / MVI + Clean                | **Clean Arch + Bloc/Cubit**         |
| **View State**     | StateFlow / LiveData              | **Bloc State (Equatable)**          |
| **Navigation**     | Jetpack Navigation                | **GoRouter**                        |
| **DI**             | Hilt / Koin                       | **GetIt + Injectable**              |
| **Security/Cache** | DataStore + KeyStore              | **MethodChannel + Core Module**     |
| **Localization**   | `strings.xml`                     | **`.arb` Files (gen-l10n)**         |

---

## 🔐 Segurança e Integração Nativa

O projeto possui um módulo dedicado à segurança (`packages/core_secure_storage`) que demonstra como **Flutter e Android Nativo** conversam.

**Fluxo de Persistência Segura:**
1.  **Flutter:** O repositório converte os modelos (ex: Lista de Chats) para JSON.
2.  **Bridge:** Envia a string via `MethodChannel` para o Android.
3.  **Android (Kotlin):**
    *   Gera/Recupera uma chave secreta no **Android KeyStore** (Hardware-backed security).
    *   Encripta os dados usando o algoritmo **AES/GCM**.
    *   Salva os bytes encriptados no **Jetpack DataStore**.

Isso garante que dados sensíveis não fiquem em texto plano no dispositivo.

---

## 🚀 Setup Inicial

Para rodar este projeto, você precisa do [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado.

**1. Instale o Melos Globalmente**
Ferramenta que gerencia o monorepo.
```bash
dart pub global activate melos
```

**2. Bootstrap (Sincronizar Dependências)**
Rode este comando sempre que clonar o projeto ou mudar de branch. Ele "liga" os pacotes locais.
```bash
melos bootstrap
```

---

## 🏃🏻‍♂️ Como Rodar os Apps

Clique no **Play** (▶) ao lado do bloco para rodar diretamente no emulador/device conectado ou então navegar até o app que quer rodar pelo terminal e digitar o comando flutter run.

### 📱 UI Catalog (Design System)
Use para desenvolver e testar componentes visuais isoladamente.

### 💬 Chat App (Produto Principal)
O aplicativo final. Ao iniciar, ele carrega a **Lista de Conversas** (Feature Module) e, em background, salva o cache encriptado no Android.

**Nota para Android Studio:**
Para que o Android Studio reconheça o contexto nativo (Gradle, Logcat, SDK), abra a pasta `apps/chat_app/android` como um projeto separado (File > Open).

---

## 🌍 Internacionalização (L10n)

Utilizamos arquivos `.arb` para traduções. Os arquivos Dart são gerados **fisicamente** na pasta `lib/l10n/` para evitar erros de importação.

### 🔄 Scripts para Gerar Strings (Gen L10n)

Se você editou um arquivo `.arb` e o texto não atualizou, rode o script correspondente abaixo:

**Atualizar Strings do UI Catalog:**
```bash
melos run l10n:ui_catalog
```

### 🧹 Script de Limpeza Total (Deep Clean)

Se houver problemas de cache, erros de "Invalid depfile" ou strings antigas persistindo:

**Limpar e Reconstruir UI Catalog:**
```bash
melos run clean:ui_catalog
```

---

## 📦 Modularização

### Como funciona

-   **`apps/*`**: Pontos de entrada. Orquestram a navegação, DI e configuração de temas. Não contêm regras de negócio.
-   **`packages/*`**: Módulos de código.
    -   **Features:** (ex: `feature_chat_list`) Contêm Domain, Data (Repositories/Datasources) e Presentation (Bloc/Pages).
    -   **Core/Shared:** (ex: `design_system`, `core_secure_storage`) Utilitários e UI compartilhada.

### Passo a passo: Criando um novo módulo

Exemplo: Criando um novo módulo chamado `feature_example`.

**1. Gerar o pacote Flutter:**
Rode o comando na raiz do workspace alterando o 'feature_example' para o nome do módulo que será criado.
```bash
flutter create --template=package packages/feature_example
```

**2. Adicionar dependência:**
No `pubspec.yaml` do app consumidor (ex: `apps/chat_app`), adicione:
```yaml
dependencies:
  feature_profile:
    path: ../../packages/feature_example
```

**3. Bootstrap (Sincronizar Dependências)**
Sincronize as novas dependências no workspace.
```bash
melos bootstrap
```
