# 💬 Flutter Chat App - Exemplo de Arquitetura

Este repositório é um **projeto de exemplo** que demonstra como construir uma aplicação Flutter escalável e modular.

Ele utiliza uma estrutura de **Monorepo** gerenciada pelo **Melos**, com o objetivo de separar responsabilidades, maximizar o reuso de código e facilitar o desenvolvimento de features em paralelo.

---

## 🏗 Estrutura do Projeto

O workspace é dividido em duas categorias principais:

-   **`apps/`**: Contém os dois pontos de entrada "buildáveis" do projeto.
    -   `chat_app`: O aplicativo principal, que integra todas as features e a lógica de negócio.
    -   `ui_catalog`: Um app "Showcase" para visualizar os componentes do `design_system` de forma isolada.
-   **`packages/`**: Contém os módulos compartilhados (bibliotecas).
    -   `design_system`: Nosso UI Kit. Contém apenas widgets visuais, temas e cores.
    -   *(outros pacotes... ex: `feature_login`, `core_network`)*

---

## 🛠 Tech Stack (Guia para Devs Android)

O "De/Para" arquitetural do Flutter em relação ao Android Nativo:

| Conceito           | Android (Kotlin/Jetpack) | Flutter (Nossa Arquitetura) |
|:-------------------|:-------------------------|:----------------------------|
| **Monorepo Build** | Gradle (include project) | **Melos**                   |
| **Architecture**   | MVVM / MVI               | **Bloc / Cubit**            |
| **View State**     | StateFlow / LiveData     | **Bloc State (Equatable)**  |
| **User Intent**    | UIEvent / Intent         | **Bloc Event**              |
| **Navigation**     | Jetpack Navigation       | **GoRouter**                |
| **DI**             | Hilt / Koin              | **GetIt + Injectable**      |
| **Localization**   | `strings.xml`            | **`.arb` Files (gen-l10n)** |

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
O aplicativo final com lógica de negócio.

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
-   **`packages/*`**: Módulos de código. Onde a lógica de UI (`design_system`), features (`feature_chat`), ou core (`core_network`) vivem.

### Passo a passo: Criando um novo módulo

Exemplo: Criando um novo módulo chamado `feature_example`.

**1. Gerar o pacote Flutter:**
Rode o comando na raiz do workspace alterando o 'feature_example' para o nome do módulo que será criado.
'.
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

---
