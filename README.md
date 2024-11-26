# **GasTracker - Controle de Abastecimento**

**GasTracker** é um aplicativo desenvolvido em Flutter que permite o gerenciamento de veículos e o controle de abastecimentos, incluindo cálculo da média de consumo de combustível. Com ele, você pode cadastrar veículos, registrar abastecimentos, consultar o histórico e atualizar informações de perfil.

---

## **Funcionalidades Principais**

- **Cadastro e Login**:  
  - Criação de conta de usuário.
  - Login seguro com Firebase Authentication.
  - Recuperação de senha por e-mail.

- **Gerenciamento de Veículos**:  
  - Listagem de veículos cadastrados.
  - Adicionar, editar e excluir veículos.
  - Visualizar detalhes do veículo, incluindo cálculo da média de consumo.

- **Histórico de Abastecimentos**:  
  - Registro de cada abastecimento, incluindo data, quilometragem atual e quantidade de litros abastecidos.
  - Consulta do histórico de abastecimentos filtrado por veículo.

- **Cálculo da Média de Consumo**:  
  - Fórmula:  
    **Média de Consumo = (Quilometragem Atual - Quilometragem Anterior) ÷ Litros Abastecidos**  
  - Exibido na tela de detalhes do veículo.

- **Interface com Menu (Drawer)**:  
  - Navegação para diferentes telas, como Home, Meus Veículos, Adicionar Veículo, Histórico de Abastecimentos, Perfil e Logout.

---

## **Pré-requisitos**

1. **Flutter SDK** (versão 3.0 ou superior)  
   - Instale o Flutter seguindo a [documentação oficial](https://docs.flutter.dev/get-started/install).

2. **Firebase**:  
   - Configure um projeto no [Firebase Console](https://console.firebase.google.com/).  
   - Ative **Authentication** e **Cloud Firestore**.

3. **Dependências**:
   - Certifique-se de instalar todas as dependências listadas no `pubspec.yaml`:
     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       firebase_core: ^latest_version
       firebase_auth: ^latest_version
       cloud_firestore: ^latest_version
       uuid: ^latest_version
     ```

---

## **Configuração do Firebase**

1. **Adicionar o Firebase ao Projeto**:
   - Faça o download do arquivo `google-services.json` (Android) ou `GoogleService-Info.plist` (iOS) do Firebase Console.
   - Coloque o arquivo na pasta correta do projeto:
     - Android: `android/app/`
     - iOS: `ios/Runner/`

2. **Configuração do arquivo `firebase_options.dart`**:
   - Use o comando do Flutter para gerar o arquivo:
     ```bash
     flutterfire configure
     ```

---

## **Estrutura do Projeto**

```plaintext
lib/
├── main.dart                  # Entrada principal do app
├── models/                   # Modelos para veículos e abastecimentos
│   ├── vehicle_model.dart     # Modelo do veículo
│   └── refuel_model.dart      # Modelo do abastecimento
├── screens/                  # Telas do aplicativo
│   ├── login_screen.dart      # Tela de login
│   ├── register_screen.dart   # Tela de cadastro
│   ├── home_screen.dart       # Tela principal
│   ├── vehicle_screen.dart    # Lista de veículos
│   ├── vehicle_details_screen.dart # Detalhes do veículo
│   ├── add_vehicle_screen.dart      # Adicionar veículo
│   ├── refuel_history_screen.dart  # Histórico de abastecimentos
│   ├── add_refuel_screen.dart      # Registrar abastecimento
│   └── profile_screen.dart         # Tela de perfil
├── widgets/                  # Componentes reutilizáveis
│   ├── drawer_menu.dart       # Menu lateral
│   ├── vehicle_card.dart      # Card de veículo
│   └── refuel_card.dart       # Card de abastecimento
├── firebase_options.dart      # Configurações do Firebase
└── utils/                     # Funções auxiliares (se necessário)
