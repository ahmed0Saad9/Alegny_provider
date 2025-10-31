enum EnumGetOpportunities {
  tabOpportunities('tabOpportunities'),
  investmentOpportunities('investmentOpportunities'),
  company('company');

  const EnumGetOpportunities(this.type);
  final String type;
}

enum EnumAccountType {
  investor('investor'),
  company('company');

  const EnumAccountType(this.type);
  final String type;
}

enum EnumImageType {
  png,
  svg,
}
