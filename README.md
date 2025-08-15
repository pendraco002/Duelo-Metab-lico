# Duelo Metabólico 🏥⚔️

Um aplicativo Android Flutter para duelos de conhecimento em nutrição, onde estudantes de nutrição competem resolvendo casos clínicos em tempo real.

## 📱 Sobre o Aplicativo

O **Duelo Metabólico** é uma plataforma gamificada onde dois nutricionistas se enfrentam para resolver casos clínicos. O vencedor não é quem responde mais rápido, mas quem monta a melhor estratégia nutricional e metabólica para um paciente virtual, rodada por rodada.

### 🎯 Características Principais

- **Duelos em Tempo Real**: Enfrente oponentes do seu nível em partidas dinâmicas
- **Casos Clínicos Reais**: Diabetes, obesidade, doenças cardiovasculares, pediatria, geriatria e mais
- **Sistema de Progressão**: Ganhe XP, suba de nível e avance nas ligas
- **Ranking Competitivo**: Bronze, Prata, Ouro, Platina e Diamante
- **Perfil Personalizado**: Crie sua identidade como nutricionista

## 🎮 Como Funciona

### 1. Criação do Perfil
- Escolha seu apelido de nutricionista (ex: "NutriAtleta", "Dr.Glicose")
- Comece no Nível 1 da Liga Bronze
- Acompanhe suas estatísticas e progresso

### 2. Sistema de Duelos
Cada partida possui **4 rodadas temáticas**:

1. **Diagnóstico**: Analise sintomas e histórico para identificar a condição
2. **Tratamento**: Escolha a melhor abordagem terapêutica
3. **Nutrição**: Defina recomendações dietéticas específicas
4. **Avaliação**: Determine o acompanhamento adequado

### 3. Pontuação e Progressão
- **100 pontos** por resposta correta
- **XP baseado na performance**: 200 XP para vitórias, 100 XP para derrotas
- **Sistema de Ligas**:
  - 🥉 Bronze (Nível 1-9)
  - 🥈 Prata (Nível 10-19)
  - 🥇 Ouro (Nível 20-29)
  - 💎 Platina (Nível 30-49)
  - ⭐ Diamante (Nível 50+)

## 🏗️ Arquitetura Técnica

### Tecnologias Utilizadas
- **Flutter 3.10+** - Framework de desenvolvimento
- **Provider** - Gerenciamento de estado
- **SharedPreferences** - Armazenamento local
- **Google Fonts** - Tipografia personalizada
- **Flutter Animate** - Animações fluidas

### Estrutura do Projeto
```
lib/
├── main.dart                 # Ponto de entrada da aplicação
├── models/                   # Modelos de dados
│   ├── user.dart            # Modelo do usuário
│   ├── match.dart           # Modelo de partida
│   └── clinical_case.dart   # Modelo de caso clínico
├── providers/               # Gerenciamento de estado
│   ├── user_provider.dart   # Estado do usuário
│   └── match_provider.dart  # Estado das partidas
├── screens/                 # Telas da aplicação
│   ├── splash_screen.dart   # Tela de carregamento
│   ├── profile_setup_screen.dart # Criação de perfil
│   ├── home_screen.dart     # Tela principal
│   ├── match_screen.dart    # Tela de duelo
│   └── profile_screen.dart  # Perfil do usuário
├── widgets/                 # Componentes reutilizáveis
│   ├── user_stats_card.dart # Card de estatísticas
│   ├── quick_actions.dart   # Ações rápidas
│   └── recent_matches.dart  # Histórico de partidas
├── data/                    # Dados estáticos
│   └── clinical_cases_data.dart # Casos clínicos
└── theme/                   # Tema e estilos
    └── app_theme.dart       # Configurações visuais
```

## 🚀 Como Executar

### Pré-requisitos
- Flutter SDK 3.10 ou superior
- Android SDK configurado
- Dispositivo Android ou emulador

### Instalação
1. Clone o repositório:
```bash
git clone [url-do-repositorio]
cd duelo_metabolico
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Execute o aplicativo:
```bash
flutter run
```

## 📚 Casos Clínicos Incluídos

### 🩺 Categorias Disponíveis
- **Diabetes**: Casos de DM tipo 1 e 2, complicações
- **Obesidade**: Sobrepeso, obesidade infantil e adulta
- **Cardiovascular**: Hipertensão, dislipidemia
- **Renal**: Doença renal crônica, nefropatias
- **Hepático**: Esteatose, cirrose
- **Pediátrico**: Nutrição infantil especializada
- **Geriátrico**: Desnutrição em idosos
- **Esportivo**: Nutrição para atletas

### 📊 Níveis de Dificuldade
- **Fácil**: Casos básicos para iniciantes
- **Médio**: Casos intermediários
- **Difícil**: Casos complexos
- **Expert**: Casos avançados para especialistas

## 🎨 Design e UX

### Paleta de Cores
- **Primária**: Azul Médico (#2E7D8A)
- **Secundária**: Verde Saúde (#4CAF50)
- **Destaque**: Laranja Energia (#FF6B35)
- **Ligas**: Bronze, Prata, Ouro, Platina, Diamante

### Experiência do Usuário
- Interface intuitiva e responsiva
- Animações suaves para feedback visual
- Design Material com elementos de gamificação
- Acessibilidade e usabilidade otimizadas

## 🔮 Funcionalidades Futuras

### Próximas Atualizações
- [ ] **Modo Multiplayer Online**: Duelos contra jogadores reais
- [ ] **Campanhas Temáticas**: Séries de casos por especialidade
- [ ] **Sistema de Amigos**: Convide colegas e acompanhe progressos
- [ ] **Conquistas Avançadas**: Badges e títulos especiais
- [ ] **Modo Estudo**: Biblioteca de casos para prática
- [ ] **Análise de Performance**: Estatísticas detalhadas por categoria
- [ ] **Torneios**: Competições sazonais com premiações
- [ ] **Integração com Universidades**: Conteúdo oficial de instituições

### Melhorias Técnicas
- [ ] **Backend Real**: API para sincronização de dados
- [ ] **Chat no Duelo**: Comunicação durante partidas
- [ ] **Notificações Push**: Alertas de novos desafios
- [ ] **Modo Offline**: Duelos contra IA quando sem internet
- [ ] **Analytics**: Métricas de engajamento e aprendizado

## 📄 Licença

Este projeto é um protótipo educacional desenvolvido para demonstrar um aplicativo de gamificação em nutrição.

## 👥 Contribuição

Interessado em contribuir? 
- Reporte bugs através das issues
- Sugira novos casos clínicos
- Proponha melhorias na UX
- Contribua com código

---

**Desenvolvido com ❤️ para a comunidade de nutrição**

*"Transformando o aprendizado em nutrição através da gamificação"*
