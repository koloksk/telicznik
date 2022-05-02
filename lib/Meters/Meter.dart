class Meter {
  // constructor
  Meter(
      String Description,
      String City,
      String Street,
      String Nr,
      String PostalCode,
      String Tarrif,
      String DateFrom,
      String DateTo,
      String MocUmowna,
      String TypLicznika,
      String NREW,
      String LinkIMG,
      String NrLicznika,
      String Fazowosc,
      String Hanplus,
      String DailyUsage,
      String DailyGeneration,
      String MeterGenerationValue,
      String MeterUsedValue) {
    this.Description = Description;
    this.City = City;
    this.Street = Street;
    this.Nr = Nr;
    this.PostalCode = PostalCode;
    this.Tarrif = Tarrif;
    this.DateFrom = DateFrom;
    this.DateTo = DateTo;
    this.MocUmowna = MocUmowna;
    this.TypLicznika = TypLicznika;
    this.NREW = NREW;
    this.LinkIMG = LinkIMG;
    this.NrLicznika = NrLicznika;
    this.Fazowosc = Fazowosc;
    this.Hanplus = Hanplus;
    this.DailyUsage = DailyUsage;
    this.DailyGeneration = DailyGeneration;
    this.MeterGenerationValue = MeterGenerationValue;
    this.MeterUsedValue = MeterUsedValue;
  }

  late String Description;
  late String City;
  late String Street;
  late String Nr;
  late String PostalCode;
  late String Tarrif;

  late String DateFrom;
  late String DateTo;
  late String MocUmowna;
  late String TypLicznika;
  late String NREW;
  late String LinkIMG;
  late String NrLicznika;
  late String Fazowosc;
  late String Hanplus;

  late String DailyUsage;
  late String DailyGeneration;

  late String MeterGenerationValue;
  late String MeterUsedValue;
  String getDescription() {
    return Description;
  }
}
