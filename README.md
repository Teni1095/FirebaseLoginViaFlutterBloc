# FirebaseLoginViaFlutterBloc
Login through Firebase Authentication system using Flutter and BLoC
This is a project that manages states using BLoC state management framework. This link contains more infoprmation about BLoC.
https://bloclibrary.dev/#/

Why BLoC?
For most data-oriented environment, the MVC framework is used to handle data management. Flutter is a state-oriented framework. It refreshes and updates based on states. 
For that purpose, the BLoC framework is a better fit. 

This project is structured in the following way: 

View ----communicates---> BLoC ----communicates---> Repository (Data and data management)

BLoC has the following modules: 
State
Event
Bloc functions

The view uses State to update and maintain it's classes and it uses event to call action for a certain function. 

Examples:-
  State Management:- 

    Widget createWidget(BuildContext context) {
      return BlocBuilder<AuthenticationBloc, AuthenticationState>( 
        builder: (context, state) { // Returns a widget based on the state variable
          if (state is Authenticated) {
            return const OtherView);
          }
          return const Scaffold(body: LoginView());
        },
      );
    }
  
  Event handling:- 
  
    ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context)    // Call to perform an event to authenticate using Google sign in
                        .add(AuthenticateUsingGmail());          
                  },
                  child: const Text("Sign up using Google"),
                )
              
The bloc will in turn update the state based on the event:

The AuthenticateBloc will handle it like this:- 

     @override
      Stream<AuthenticationState> mapEventToState(
        AuthenticationEvent event,
      ) async* {
        if (event is AuthenticateUsingGmail) {
          yield Authenticating(); \\State to convey that an action is currently being performed
          try {
            var user = await userRepository.signInWithGoogle();
            yield Authenticated(user); State to convey that an action is completed successfully
          } catch (e) {
            yield Unauthenticated(e);  State to convey that an action has failed
          }
      }
