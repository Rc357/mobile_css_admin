enum AdminTypeEnum {
  Unknown('Unknown'),
  LibraryAdmin('Library'),
  Admin("Admin's Office"),
  SecurityAdmin('Security Office'),
  RegistrarAdmin('Registrar'),
  CashierAdmin('Cashier'),
  SuperAdmin('Super Admin');

  const AdminTypeEnum(this.description);
  final String description;
}
