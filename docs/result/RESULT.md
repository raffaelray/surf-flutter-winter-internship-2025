## Пояснения
По рекомендации из ТЗ, проект разделён на три слоя:
- *data* (содержит подгрузку api, локальные хранилища, модели фруктов и рецептов, репозитории с обращениями к api);
- *domain* (абстрактные репозитории, миллион use_case'ов);
- *presentation* (экраны, стейты, тема и виджеты);
- *вне папок* — main.dart и tabs.dart.

Помимо перечисленных в ТЗ требований, подключены так же http: ^1.6.0 (для подхвата из api), shared_preferences: ^2.5.0 (для реализации избранного и сохранения рецептов), provider: ^6.1.2 (для состояний через контекст).

UX написан по ТЗ, UI по зову сердца.

## Доказательства
1. **Экран списка фруктов**

https://github.com/user-attachments/assets/0417a3c0-4c80-4c30-b2b6-e33bad24356f

2. **Экран сортировки**

https://github.com/user-attachments/assets/6d26b644-0264-446f-b82b-12e6ba10f2e5

3. **Экран избранного**

https://github.com/user-attachments/assets/471cf89d-7e11-417a-a31e-7c15189cc899

4. **Экран деталки фруктов**

https://github.com/user-attachments/assets/be9ed1fe-6b61-4a12-be90-5f9f93f43224

5. **Экран рецептов и экран создания рецепта**

https://github.com/user-attachments/assets/b84cca26-fa9c-480f-a966-05ef446844c0

6. **Поведение при ошибке загрузки**

https://github.com/user-attachments/assets/7d83ef08-142f-4635-bd44-ad642f47d9dd
