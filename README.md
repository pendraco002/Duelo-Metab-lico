# 🔥 Duelo Metabólico

**Arena de batalhas de conhecimento nutricional para estudantes e profissionais de nutrição**

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-Clean_Architecture-green?style=for-the-badge)
![State Management](https://img.shields.io/badge/State_Management-BLoC-blue?style=for-the-badge)

## 📱 Sobre o Projeto

O **Duelo Metabólico** é um aplicativo mobile gamificado desenvolvido para iOS e Android que transforma o aprendizado de nutrição em uma experiência competitiva e envolvente. Os usuários podem participar de duelos de conhecimento em tempo real, ganhar pontos (NumScore), subir de nível e conquistar achievements.

### ✨ Características Principais

- 🏆 **Arena de Batalhas**: Duelos em tempo real com outros nutricionistas
- 🎯 **Modos de Jogo**: Solo, Online e Local (até 6 jogadores)
- 📊 **Sistema de Ranking**: Leaderboard global e estatísticas detalhadas  
- 🏅 **Conquistas**: Sistema de achievements para motivar o aprendizado
- 🎨 **Interface Premium**: Design moderno com animações fluidas
- 📱 **Multiplataforma**: Funciona em iOS e Android

## 🏗️ Arquitetura

Este projeto segue as melhores práticas de desenvolvimento Flutter com uma arquitetura robusta e escalável:

### 🧱 Clean Architecture + DDD

```
lib/
├── core/                    # Camada de infraestrutura
│   ├── constants/          # Constantes da aplicação
│   ├── di/                 # Injeção de dependência
│   ├── errors/            # Tratamento de erros
│   ├── routing/           # Sistema de navegação
│   └── theme/             # Design system
├── data/                   # Camada de dados
│   ├── datasources/       # Fontes de dados (API, Local)
│   ├── models/            # Modelos de dados
│   └── repositories/      # Implementação dos repositórios
├── domain/                 # Camada de domínio
│   ├── entities/          # Entidades de negócio
│   ├── repositories/      # Contratos dos repositórios
│   └── usecases/          # Casos de uso
└── presentation/           # Camada de apresentação
    ├── bloc/              # Gerenciamento de estado
    ├── pages/             # Telas da aplicação
    └── widgets/           # Componentes reutilizáveis
```

### 🔧 Stack Tecnológica

| Categoria | Tecnologia | Propósito |
|-----------|------------|-----------|
| **Framework** | Flutter 3.16+ | Desenvolvimento multiplataforma |
| **Linguagem** | Dart 3.2+ | Linguagem de programação |
| **Estado** | BLoC/Cubit | Gerenciamento de estado reativo |
| **Navegação** | GoRouter | Navegação declarativa |
| **DI** | GetIt + Injectable | Injeção de dependência |
| **Serialização** | Freezed + JsonAnnotation | Imutabilidade e serialização |
| **Animações** | Flutter Animate | Animações avançadas |
| **Armazenamento** | Hive + SharedPreferences | Persistência local |
| **Rede** | Dio + Retrofit | Cliente HTTP |
| **Design** | Material 3 + Google Fonts | Sistema de design |

## 🚀 Recursos Implementados

### ✅ Concluído

- [x] **Arquitetura Clean Architecture** com Domain-Driven Design
- [x] **Sistema de Navegação** declarativo com GoRouter
- [x] **Gerenciamento de Estado** avançado com BLoC
- [x] **Injeção de Dependência** com GetIt e Injectable
- [x] **Design System** completo com tokens de design
- [x] **Animações Premium** com micro-interações
- [x] **Tela de Splash** com loading animado
- [x] **Home Screen** com cards interativos dos modos de jogo
- [x] **Background Animado** com partículas flutuantes
- [x] **Navigation Bar** responsiva
- [x] **Arquitetura de Entidades** robusta (User, Game, Achievement)

### 🔄 Em Desenvolvimento

- [ ] **Gameplay Engine**: Lógica completa dos jogos
- [ ] **Sistema de Perguntas**: Base de dados de questões
- [ ] **Multiplayer**: Funcionalidade online em tempo real
- [ ] **Sistema de Chat**: Comunicação entre jogadores
- [ ] **Push Notifications**: Notificações inteligentes
- [ ] **Analytics**: Métricas de engajamento
- [ ] **Testes Automatizados**: Cobertura completa

## 🎮 Modos de Jogo

### 🎯 Desafio Solo
- Pratique contra IA inteligente
- Feedback detalhado após cada pergunta
- Sem pressão de tempo
- Ideal para estudos

### 🌐 Arena Online  
- Duelos em tempo real
- Ranking global
- Matchmaking inteligente
- Máximo de pontuação

### 👥 Arena Local
- Partidas locais (1v1 até 3v3)
- Suporte para até 6 jogadores
- Poderes especiais únicos
- Perfeito para grupos de estudo

## 🏅 Sistema de Progressão

### NumScore
- Moeda virtual do jogo
- Ganhe respondendo corretamente
- Use para desbloquear conteúdos
- Sistema de bonificação por velocidade

### Níveis e Ligas
- **Liga Bronze** (Níveis 1-10)
- **Liga Prata** (Níveis 11-25)  
- **Liga Ouro** (Níveis 26-50)
- **Liga Platina** (Níveis 51-100)
- **Liga Diamante** (Níveis 100+)

### Conquistas
- **Primeira Vitória**: Complete seu primeiro duelo
- **Sequência de Fogo**: 5 vitórias consecutivas
- **Mestre da Velocidade**: Responda em menos de 5s
- **Especialista**: 100% de acerto em uma categoria
- **Social**: Convide 10 amigos

## 🎨 Design e UX

### Princípios de Design
- **Minimalismo Funcional**: Interface limpa focada na experiência
- **Cores Vibrantes**: Palette que estimula energia e competição
- **Animações Fluidas**: 60 FPS garantidos em todas as transições
- **Feedback Tátil**: Vibrações sutis para confirmar ações
- **Acessibilidade**: Suporte completo para leitores de tela

### Tema Dark-First
- Background gradient dinâmico
- Contraste otimizado para longas sessões
- Modo claro disponível via configurações
- Cores semânticas para feedback instantâneo

## 📊 Métricas de Performance

### Objetivos de Performance
- **Startup Time**: < 3 segundos
- **Frame Rate**: 60 FPS constante
- **Memory Usage**: < 150MB em uso normal
- **Bundle Size**: < 50MB (Android), < 40MB (iOS)
- **Battery Impact**: Baixo consumo energético

## 🔧 Como Executar

### Pré-requisitos
- Flutter 3.16.0 ou superior
- Dart 3.2.0 ou superior
- Android Studio / VS Code
- Git

### Instalação

```bash
# Clone o repositório
git clone https://github.com/seu-usuario/duelo-metabolico.git

# Entre no diretório
cd duelo-metabolico

# Instale as dependências
flutter pub get

# Execute o code generation
flutter packages pub run build_runner build

# Execute no emulador/dispositivo
flutter run
```

### Comandos Úteis

```bash
# Gerar código (modelos, injeção de dependência)
flutter packages pub run build_runner build --delete-conflicting-outputs

# Executar testes
flutter test

# Analisar código
flutter analyze

# Gerar APK de release
flutter build apk --release

# Gerar bundle do iOS
flutter build ios --release
```

## 🧪 Testes

### Estratégia de Testes
- **Unit Tests**: Lógica de negócio (use cases, entidades)
- **Widget Tests**: Componentes de UI isolados  
- **Integration Tests**: Fluxos completos da aplicação
- **Golden Tests**: Testes visuais para regressões de UI

### Cobertura Objetivo
- **Domínio**: 100% (crítico para regras de negócio)
- **Apresentação**: 80% (componentes principais)
- **Infraestrutura**: 70% (configurações e utilities)

## 📈 Roadmap

### v1.0.0 - MVP (Q1 2024)
- [x] Arquitetura base
- [ ] Jogo solo funcional
- [ ] Sistema de pontuação
- [ ] 500 perguntas iniciais

### v1.1.0 - Multiplayer (Q2 2024)
- [ ] Arena online
- [ ] Sistema de ranking
- [ ] Chat básico
- [ ] Push notifications

### v1.2.0 - Social (Q3 2024)
- [ ] Sistema de amigos
- [ ] Torneios
- [ ] Compartilhamento social
- [ ] Estatísticas avançadas

### v2.0.0 - Premium (Q4 2024)
- [ ] Modo offline completo
- [ ] IA personalizada
- [ ] Análise de performance
- [ ] Recursos premium

## 👥 Contribuindo

Adoramos contribuições! Por favor, leia nosso [Guia de Contribuição](CONTRIBUTING.md) antes de enviar PRs.

### Processo de Contribuição
1. Fork o projeto
2. Crie uma feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está licenciado sob a MIT License - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 🤝 Contato

**Rennan Lima** - Desenvolvedor Principal
- Email: rennan@duelometabolico.com
- LinkedIn: [linkedin.com/in/rennan-lima](https://linkedin.com/in/rennan-lima)
- GitHub: [@rennan-lima](https://github.com/rennan-lima)

---

<p align="center">
  <strong>Feito com ❤️ e muito ☕ para revolucionar o ensino de nutrição</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Status-Em_Desenvolvimento-yellow?style=for-the-badge" alt="Status">
  <img src="https://img.shields.io/badge/Versão-1.0.0--alpha-blue?style=for-the-badge" alt="Version">
  <img src="https://img.shields.io/badge/Licença-MIT-green?style=for-the-badge" alt="License">
</p>
