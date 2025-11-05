enum EnumGetOpportunities {
  tabOpportunities('tabOpportunities'),
  investmentOpportunities('investmentOpportunities'),
  company('company');

  const EnumGetOpportunities(this.type);
  final String type;
}

enum EnumServiceType {
  doctor('دكتور بشري'),
  company('company');

  const EnumServiceType(this.type);
  final String type;
}

enum EnumImageType {
  png,
  svg,
}
