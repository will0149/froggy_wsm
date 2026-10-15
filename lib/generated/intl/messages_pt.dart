// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pt';

  static String m0(date) => "Inscrito em ${date}";

  static String m1(count) => "${count} vagas disponíveis";

  static String m2(id) => "Ingresso #${id}";

  static String m3(count) => "${count} ingressos próximos";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutEvent": MessageLookupByLibrary.simpleMessage("Sobre o evento"),
    "accessCode": MessageLookupByLibrary.simpleMessage("Código de acesso"),
    "accessCodeHint": MessageLookupByLibrary.simpleMessage(
      "Este evento é privado. Digite o código que o organizador te deu.",
    ),
    "accessCodeOwnerHint": MessageLookupByLibrary.simpleMessage(
      "Compartilhe com seus convidados para que possam se inscrever.",
    ),
    "accessCodeRequired": MessageLookupByLibrary.simpleMessage(
      "Digite o código",
    ),
    "addBanner": MessageLookupByLibrary.simpleMessage("Adicionar imagem"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Autenticar"),
    "avatarUpdated": MessageLookupByLibrary.simpleMessage("Foto atualizada"),
    "avatarUploadFailed": MessageLookupByLibrary.simpleMessage(
      "Não foi possível atualizar a foto",
    ),
    "bannerUploadFailed": MessageLookupByLibrary.simpleMessage(
      "O evento foi criado, mas a imagem não pôde ser enviada",
    ),
    "buyTicket": MessageLookupByLibrary.simpleMessage("Comprar bilhete"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "cancelTicket": MessageLookupByLibrary.simpleMessage("Cancelar inscrição"),
    "cancelTicketConfirm": MessageLookupByLibrary.simpleMessage(
      "Tem certeza de que quer cancelar sua inscrição?",
    ),
    "capacityHint": MessageLookupByLibrary.simpleMessage("Vazio = sem limite"),
    "catAdventure": MessageLookupByLibrary.simpleMessage("Aventura"),
    "catCamping": MessageLookupByLibrary.simpleMessage("Camping"),
    "catMusic": MessageLookupByLibrary.simpleMessage("Música"),
    "catWorkshops": MessageLookupByLibrary.simpleMessage("Oficinas"),
    "categories": MessageLookupByLibrary.simpleMessage("Categories"),
    "categoryNone": MessageLookupByLibrary.simpleMessage("Sem categoria"),
    "changeBanner": MessageLookupByLibrary.simpleMessage("Trocar imagem"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Alterar senha"),
    "changePhoto": MessageLookupByLibrary.simpleMessage("Trocar foto"),
    "codeCopied": MessageLookupByLibrary.simpleMessage("Código copiado"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirmar senha"),
    "costFree": MessageLookupByLibrary.simpleMessage("Grátis"),
    "costInvitation": MessageLookupByLibrary.simpleMessage("Com convite"),
    "costPaid": MessageLookupByLibrary.simpleMessage("Pago"),
    "costPrivate": MessageLookupByLibrary.simpleMessage("Privado"),
    "costType": MessageLookupByLibrary.simpleMessage("Tipo de acesso"),
    "couldNotOpenMaps": MessageLookupByLibrary.simpleMessage(
      "Não foi possível abrir o app de mapas",
    ),
    "createEvent": MessageLookupByLibrary.simpleMessage("Criar evento"),
    "dataAndPrivacy": MessageLookupByLibrary.simpleMessage(
      "Dados e privacidade",
    ),
    "dateMustBeFuture": MessageLookupByLibrary.simpleMessage(
      "A data deve ser futura",
    ),
    "deleteEvent": MessageLookupByLibrary.simpleMessage("Excluir evento"),
    "deleteEventConfirm": MessageLookupByLibrary.simpleMessage(
      "Todas as inscrições também serão excluídas. Essa ação não pode ser desfeita.",
    ),
    "devStudio": MessageLookupByLibrary.simpleMessage("Atheneox Studios"),
    "downloadTicket": MessageLookupByLibrary.simpleMessage("Baixar ingresso"),
    "editEvent": MessageLookupByLibrary.simpleMessage("Editar evento"),
    "email": MessageLookupByLibrary.simpleMessage("Correio eletrônico"),
    "enroll": MessageLookupByLibrary.simpleMessage("Inscrever-me"),
    "enrolledOn": m0,
    "enrolledSuccess": MessageLookupByLibrary.simpleMessage(
      "Pronto! Você está inscrito",
    ),
    "eventCapacity": MessageLookupByLibrary.simpleMessage("Capacidade"),
    "eventCategory": MessageLookupByLibrary.simpleMessage("Categoria"),
    "eventCreated": MessageLookupByLibrary.simpleMessage("Evento criado"),
    "eventCurrency": MessageLookupByLibrary.simpleMessage("Moeda"),
    "eventDateTime": MessageLookupByLibrary.simpleMessage("Data e hora"),
    "eventDeleted": MessageLookupByLibrary.simpleMessage("Evento excluído"),
    "eventDescription": MessageLookupByLibrary.simpleMessage("Descrição"),
    "eventFinished": MessageLookupByLibrary.simpleMessage("Evento encerrado"),
    "eventLocation": MessageLookupByLibrary.simpleMessage("Local"),
    "eventName": MessageLookupByLibrary.simpleMessage("Nome do evento"),
    "eventPlace": MessageLookupByLibrary.simpleMessage("Local"),
    "eventPrice": MessageLookupByLibrary.simpleMessage("Preço"),
    "eventShortDescription": MessageLookupByLibrary.simpleMessage(
      "Descrição curta",
    ),
    "eventUpdated": MessageLookupByLibrary.simpleMessage("Evento atualizado"),
    "eventsForAll": MessageLookupByLibrary.simpleMessage("Eventos para todos"),
    "eventsForYou": MessageLookupByLibrary.simpleMessage("Eventos para você"),
    "feedEmpty": MessageLookupByLibrary.simpleMessage("Ainda não há eventos"),
    "feedEnd": MessageLookupByLibrary.simpleMessage(
      "Você já viu todos os eventos",
    ),
    "feedLoadError": MessageLookupByLibrary.simpleMessage(
      "Não foi possível carregar os eventos",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "Este campo é obrigatório",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Esqueci minha senha",
    ),
    "getDirections": MessageLookupByLibrary.simpleMessage("Como chegar"),
    "getHelp": MessageLookupByLibrary.simpleMessage("Ajuda"),
    "haveResetLink": MessageLookupByLibrary.simpleMessage("Já tenho um link"),
    "hostedBy": MessageLookupByLibrary.simpleMessage("Organizado por"),
    "information": MessageLookupByLibrary.simpleMessage("Informação"),
    "invalidAccessCode": MessageLookupByLibrary.simpleMessage(
      "Código de acesso inválido",
    ),
    "invalidCurrency": MessageLookupByLibrary.simpleMessage(
      "Use um código de 3 letras, p. ex. USD",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("E-mail inválido"),
    "invalidNumber": MessageLookupByLibrary.simpleMessage("Número inválido"),
    "invitationOnly": MessageLookupByLibrary.simpleMessage(
      "Somente por convite",
    ),
    "joinOurUniverse": MessageLookupByLibrary.simpleMessage(
      "Junte-se ao nosso universo",
    ),
    "keepTicket": MessageLookupByLibrary.simpleMessage("Manter"),
    "login": MessageLookupByLibrary.simpleMessage("Iniciar sessão"),
    "logout": MessageLookupByLibrary.simpleMessage("Fechar Sessão"),
    "myEvents": MessageLookupByLibrary.simpleMessage("Eventos"),
    "myEventsEnrolled": MessageLookupByLibrary.simpleMessage("Inscrito"),
    "myEventsPaid": MessageLookupByLibrary.simpleMessage("Pago"),
    "myEventsSaved": MessageLookupByLibrary.simpleMessage("Salvou"),
    "myTickets": MessageLookupByLibrary.simpleMessage("Meus ingressos"),
    "name": MessageLookupByLibrary.simpleMessage("Nome"),
    "navHome": MessageLookupByLibrary.simpleMessage("Início"),
    "navProfile": MessageLookupByLibrary.simpleMessage("Perfil"),
    "navTickets": MessageLookupByLibrary.simpleMessage("Ingressos"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nova senha"),
    "noEnrolledEvents": MessageLookupByLibrary.simpleMessage(
      "Você não está inscrito em nenhum evento",
    ),
    "noOwnEvents": MessageLookupByLibrary.simpleMessage(
      "Você ainda não criou eventos",
    ),
    "noPastTickets": MessageLookupByLibrary.simpleMessage(
      "Nenhum ingresso anterior",
    ),
    "noSearchResults": MessageLookupByLibrary.simpleMessage(
      "Nenhum evento corresponde à sua busca",
    ),
    "noUpcomingTickets": MessageLookupByLibrary.simpleMessage(
      "Nenhum ingresso próximo",
    ),
    "ownEvent": MessageLookupByLibrary.simpleMessage("É o seu evento"),
    "parkeaAndShare": MessageLookupByLibrary.simpleMessage("Parkea & Comparte"),
    "parkeaAppName": MessageLookupByLibrary.simpleMessage("Parkea!"),
    "password": MessageLookupByLibrary.simpleMessage("Senha"),
    "passwordEntirelyNumeric": MessageLookupByLibrary.simpleMessage(
      "A senha não pode conter apenas números",
    ),
    "passwordResetDone": MessageLookupByLibrary.simpleMessage(
      "Senha atualizada. Faça login.",
    ),
    "passwordTooCommon": MessageLookupByLibrary.simpleMessage(
      "Esta senha é muito comum",
    ),
    "passwordTooShort": MessageLookupByLibrary.simpleMessage(
      "A senha deve ter pelo menos 8 caracteres",
    ),
    "passwordTooSimilar": MessageLookupByLibrary.simpleMessage(
      "A senha é muito parecida com seu usuário ou e-mail",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "As senhas não coincidem",
    ),
    "paymentsComingSoon": MessageLookupByLibrary.simpleMessage(
      "Pagamento em breve",
    ),
    "popularEvents": MessageLookupByLibrary.simpleMessage("Eventos Populares"),
    "pricePositive": MessageLookupByLibrary.simpleMessage(
      "O preço deve ser maior que 0",
    ),
    "province": MessageLookupByLibrary.simpleMessage("Província"),
    "publishEvent": MessageLookupByLibrary.simpleMessage("Publicar evento"),
    "register": MessageLookupByLibrary.simpleMessage("Inscrever-se"),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "Se o e-mail estiver cadastrado, enviamos um link para redefinir sua senha",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
    "retry": MessageLookupByLibrary.simpleMessage("Tentar novamente"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Salvar alterações"),
    "saveEvent": MessageLookupByLibrary.simpleMessage("Salvar Evento"),
    "searchEvents": MessageLookupByLibrary.simpleMessage("Buscar atividades"),
    "seeEvent": MessageLookupByLibrary.simpleMessage("ver evento"),
    "settings": MessageLookupByLibrary.simpleMessage("Definições"),
    "signUp": MessageLookupByLibrary.simpleMessage("Inscrever-se"),
    "similarEvents": MessageLookupByLibrary.simpleMessage(
      "Eventos Semelhantes",
    ),
    "soldOut": MessageLookupByLibrary.simpleMessage("Esgotado"),
    "spotsLeft": m1,
    "ticketCancelled": MessageLookupByLibrary.simpleMessage(
      "Inscrição cancelada",
    ),
    "ticketNumber": m2,
    "ticketsLoadError": MessageLookupByLibrary.simpleMessage(
      "Não foi possível carregar os ingressos",
    ),
    "ticketsPast": MessageLookupByLibrary.simpleMessage("Anteriores"),
    "ticketsUpcoming": MessageLookupByLibrary.simpleMessage("Próximos"),
    "upcomingTicketsCount": m3,
    "usernameOrEmail": MessageLookupByLibrary.simpleMessage(
      "Usuário ou e-mail",
    ),
    "usernameOrEmailRequired": MessageLookupByLibrary.simpleMessage(
      "Informe seu usuário ou e-mail",
    ),
    "viewEvent": MessageLookupByLibrary.simpleMessage("Ver evento"),
    "viewMyTicket": MessageLookupByLibrary.simpleMessage("Ver meu ticket"),
    "welcomeAgain": MessageLookupByLibrary.simpleMessage("¡Bem vindo de novo!"),
  };
}
