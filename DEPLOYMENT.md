# 🚀 Guia de Deployment - Duelo Metabólico

Este documento fornece instruções detalhadas para publicar o aplicativo **Duelo Metabólico** nas stores oficiais (Google Play Store e Apple App Store).

## 📋 Pré-requisitos

### Certificados e Chaves
- [ ] Certificado de assinatura Android (keystore.jks)
- [ ] Certificado de distribuição iOS (.p12)
- [ ] Provisioning Profile iOS (.mobileprovision)
- [ ] Conta de desenvolvedor Google Play Console
- [ ] Conta de desenvolvedor Apple Developer Program

### Arquivos de Configuração
- [ ] `android/key.properties` configurado
- [ ] `ios/Runner/GoogleService-Info.plist` 
- [ ] `android/app/google-services.json`
- [ ] Firebase projeto configurado

## 🤖 Deployment Android

### 1. Preparação do Build

```bash
# Limpar build anterior
flutter clean
flutter pub get

# Gerar código necessário
flutter packages pub run build_runner build --delete-conflicting-outputs

# Verificar configurações
flutter doctor
```

### 2. Configurar Keystore

Criar arquivo `android/key.properties`:
```properties
storeFile=keystore.jks
keyAlias=duelo-metabolico-key
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
```

### 3. Build de Produção

```bash
# Gerar App Bundle (recomendado)
flutter build appbundle --release

# Ou gerar APK
flutter build apk --release --split-per-abi
```

### 4. Verificação do Build

```bash
# Analisar tamanho do bundle
bundletool build-apks --bundle=build/app/outputs/bundle/release/app-release.aab --output=app.apks

# Extrair APKs para teste
bundletool extract-apks --apks=app.apks --output-dir=extracted-apks
```

### 5. Upload para Google Play Console

1. **Acesse**: [Google Play Console](https://play.google.com/console)
2. **Navegue**: App → Release → Production
3. **Upload**: `build/app/outputs/bundle/release/app-release.aab`
4. **Configurar**:
   - Release notes em português e inglês
   - Screenshots (mínimo 2 por categoria)
   - Descrição da store atualizada
   - Configurações de distribuição por país

### 6. Metadados da Store

**Título**: Duelo Metabólico - Arena Nutricional

**Descrição Curta** (80 caracteres):
Arena de batalhas de conhecimento para estudantes de nutrição

**Descrição Completa**:
```
🔥 Duelo Metabólico - A Arena Definitiva de Conhecimento Nutricional!

Transforme seus estudos de nutrição em uma experiência competitiva e envolvente! Enfrente outros nutricionistas em duelos de conhecimento em tempo real e prove suas habilidades.

🏆 RECURSOS PRINCIPAIS:
• Arena de Batalhas Online - Duelos em tempo real
• Modo Solo - Pratique contra IA inteligente  
• Arena Local - Jogue com amigos (até 6 players)
• Sistema de Ranking Global
• Conquistas e Badges
• NumScore - Sistema de pontuação gamificado

🎯 MODOS DE JOGO:
• Desafio Solo: Perfeito para estudos, sem pressão
• Arena Online: Competição global com ranking
• Arena Local: Diversão em grupo

📊 SISTEMA DE PROGRESSÃO:
• Ligas: Bronze, Prata, Ouro, Platina, Diamante
• XP e Níveis: Evolua suas habilidades
• Estatísticas Detalhadas: Acompanhe seu progresso
• Conquistas: Desbloqueie achievements únicos

🎨 DESIGN PREMIUM:
• Interface moderna e intuitiva
• Animações fluidas em 60 FPS
• Tema dark otimizado
• Responsivo para tablets

Ideal para estudantes de nutrição, nutricionistas e profissionais da área que querem aprender de forma divertida e competitiva!

Baixe agora e entre na arena! 🥇
```

**Palavras-chave**:
nutrição, educação, quiz, duelo, medicina, saúde, estudantes, gamificação, conhecimento, competição

## 🍎 Deployment iOS

### 1. Configuração Xcode

```bash
# Abrir projeto iOS
open ios/Runner.xcworkspace

# Configurar no Xcode:
# - Team de desenvolvimento
# - Bundle Identifier: com.duelometabolico.app
# - Version e Build Number
# - Signing & Capabilities
```

### 2. Build de Produção

```bash
# Build para iOS
flutter build ios --release

# Archive no Xcode:
# Product → Archive → Distribute App → App Store Connect
```

### 3. App Store Connect

1. **Acesse**: [App Store Connect](https://appstoreconnect.apple.com)
2. **Configure**:
   - App Information
   - Pricing and Availability
   - App Privacy
   - App Review Information

### 4. Metadados iOS

**App Name**: Duelo Metabólico

**Subtitle**: Arena de Conhecimento Nutricional

**Description**:
```
Duelo Metabólico é a arena definitiva para estudantes e profissionais de nutrição testarem seus conhecimentos!

🔥 RECURSOS DESTACADOS:
• Duelos em tempo real com outros nutricionistas
• Modo solo para prática individual
• Sistema de ranking global
• Conquistas e progressão gamificada
• Interface premium com animações fluidas

🎯 TRÊS MODOS EMOCIONANTES:
• Arena Online: Compete globalmente
• Desafio Solo: Estude sem pressão
• Arena Local: Diversão com amigos

Transforme seus estudos em uma experiência competitiva e divertida. Suba de nível, desbloqueie conquistas e torne-se o mestre da nutrição!

Baixe agora e prove suas habilidades na arena! 🏆
```

**Keywords**: nutrição,educação,quiz,medicina,saúde,estudantes,competição,conhecimento

**App Category**: Education

**Content Rating**: 4+ (Ages 4 and up)

## 🖼️ Assets para as Stores

### Screenshots Necessários

**Android**:
- Phone: 2-8 screenshots (1080x1920)
- 7-inch Tablet: 1-8 screenshots (1200x1920)
- 10-inch Tablet: 1-8 screenshots (1920x1200)

**iOS**:
- iPhone 6.7": 1-10 screenshots (1290x2796)
- iPhone 6.5": 1-10 screenshots (1242x2688)
- iPhone 5.5": 1-10 screenshots (1242x2208)
- iPad Pro 6th Gen: 1-10 screenshots (2048x2732)

### Feature Graphic
- Android: 1024x500 (obrigatório)
- iOS: Não necessário

### App Icons
- Android: 512x512 (PNG, não transparente)
- iOS: 1024x1024 (PNG, sem bordas arredondadas)

## 🔧 Configurações de Release

### Version Bumping

```bash
# Atualizar versão no pubspec.yaml
version: 1.0.1+2

# Build com nova versão
flutter build appbundle --build-number=2 --build-name=1.0.1
```

### Release Notes Template

**Português**:
```
🔥 Nova Atualização!

✨ Novidades:
• [Descrever novas funcionalidades]

🐛 Correções:
• [Listar bugs corrigidos]

⚡ Melhorias:
• Performance otimizada
• Interface mais fluida
• Correções de estabilidade

Obrigado por jogar Duelo Metabólico! 🏆
```

**English**:
```
🔥 New Update!

✨ What's New:
• [Describe new features]

🐛 Bug Fixes:
• [List fixed bugs]

⚡ Improvements:
• Optimized performance
• Smoother interface
• Stability improvements

Thanks for playing Duelo Metabólico! 🏆
```

## 🔍 Checklist de Pré-lançamento

### Testes Finais
- [ ] Testado em dispositivos físicos (Android/iOS)
- [ ] Testado em diferentes tamanhos de tela
- [ ] Navegação funciona corretamente
- [ ] Push notifications funcionando
- [ ] Performance aceitável (60 FPS)
- [ ] Não há crashes ou bugs críticos

### Compliance
- [ ] LGPD/GDPR compliance implementado
- [ ] Política de privacidade atualizada
- [ ] Termos de uso atualizados
- [ ] Age rating apropriado

### Marketing
- [ ] Website do app criado
- [ ] Material promocional preparado
- [ ] Estratégia de ASO (App Store Optimization)
- [ ] Press kit disponível

## 🚨 Troubleshooting

### Problemas Comuns Android
```bash
# Erro de keystore
keytool -list -v -keystore android/app/keystore.jks

# Limpar cache do Gradle
cd android && ./gradlew clean

# Verificar dependências
flutter doctor --verbose
```

### Problemas Comuns iOS
```bash
# Limpar build iOS
flutter clean
cd ios && rm -rf Pods Podfile.lock
cd .. && flutter pub get
cd ios && pod install
```

## 📈 Monitoramento Pós-lançamento

### Métricas a Acompanhar
- Downloads e instalações
- Reviews e ratings
- Crash reports (Firebase Crashlytics)
- Performance metrics (Firebase Performance)
- User engagement (Firebase Analytics)

### Ferramentas de Monitoramento
- Google Play Console (Android)
- App Store Connect (iOS)
- Firebase Console
- Sentry (opcional para crash reporting adicional)

## 🎯 Estratégia de Release

### Rollout Gradual
1. **Internal Testing** (1-2 dias)
2. **Closed Testing** (3-5 dias, 50 usuários)
3. **Open Testing** (1 semana, 1000 usuários)
4. **Production** (100% dos usuários)

### A/B Testing
- Testar diferentes screenshots
- Testar descrições da store
- Testar preços (se aplicável)

## 📞 Suporte

Para dúvidas sobre o deployment:
- **Tech Lead**: rennan@duelometabolico.com
- **DevOps**: devops@duelometabolico.com
- **Documentação**: [docs.duelometabolico.com](https://docs.duelometabolico.com)

---

**Última atualização**: Dezembro 2023
**Versão do documento**: 1.0.0