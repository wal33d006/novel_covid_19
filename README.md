# Novel Covid 19 Stats

A COVID-19 statistics Flutter application. This project is created for tutorial purposes. The related article (which
might now look outdated) can be
found [here](https://medium.com/flutterpub/architect-your-flutter-app-using-provider-mvc-fd61956795b4)

### Update

- The application is now updated to use a new architecture
- It's a combination of MVVM and MVP
- It also uses `Future<Either>` to simplify functions readability
- There are `use_cases` for every independent app level task
- Domain layer is created for large scale decoupling
- Abstractions have been used for things like repositories and local storage
- A variation of `MobX` is being used for state management (The state classes are hand-written instead of getting
  dependent of `build_runner`)
- `Stores` have been used for app-wide state changes like theme and country selection
- Each UI folder (except for `personal_info.dart`) now consists of the following
    - `foo_page.dart`
    - `foo_presentation_model.dart`
    - `foo_navigator.dart`
    - `foo_initial_params.dart`
    - `foo_presenter.dart`
- A custom navigation layer and http layer has been written over the original ones to keep more control
- Extensions on `dartz` and `future_either` have also been written to keep the main code readable and simple
- `GetIt` has been used for dependency injection. Pages have also been injected.

## This is how it looks like

![](git_img/img.png)
