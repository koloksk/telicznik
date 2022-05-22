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
      String MeterGenerationValue1,
      String MeterGenerationValue2,
      String MeterUsedValue1,
      String MeterUsedValue2,
      String lastupdate) {
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
    this.MeterGenerationValue1 = MeterGenerationValue1;
    this.MeterGenerationValue2 = MeterGenerationValue2;
    this.MeterUsedValue1 = MeterUsedValue1;
    this.MeterUsedValue2 = MeterUsedValue2;

    this.lastupdate = lastupdate;
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

  late List DailyUsage = [];
  late List DailyGeneration = [];

  late String MeterGenerationValue1;
  late String MeterGenerationValue2 = "0";
  late String MeterUsedValue1;
  late String MeterUsedValue2 = "0";

  late String lastupdate;

  late List MonthlyUsage = [];
  late List MonthlyGeneration = [];

  late List HourlyUsage = [];
  late List HourlyGeneration = [];

  Meter.fromJson(Map json)
      : Description = json['Description'],
        City = json['City'],
        Street = json['Street'],
        Nr = json['Nr'],
        PostalCode = json['PostalCode'],
        Tarrif = json['Tarrif'],
        DateFrom = json['DateFrom'],
        DateTo = json['DateTo'],
        MocUmowna = json['MocUmowna'],
        TypLicznika = json['TypLicznika'],
        NREW = json['NREW'],
        LinkIMG = json['LinkIMG'],
        NrLicznika = json['NrLicznika'],
        Fazowosc = json['Fazowosc'],
        Hanplus = json['Hanplus'],
        DailyUsage = json['DailyUsage'],
        DailyGeneration = json['DailyGeneration'],
        MeterGenerationValue1 = json['MeterGenerationValue1'],
        MeterGenerationValue2 = json['MeterGenerationValue2'],
        MeterUsedValue1 = json['MeterUsedValue1'],
        lastupdate = json['lastupdate'],
        HourlyUsage = json['HourlyUsage'],
        HourlyGeneration = json['HourlyGeneration'],
        MonthlyUsage = json['MonthlyUsage'],
        MonthlyGeneration = json['MonthlyGeneration'];

  Map<String, dynamic> toJson() {
    return {
      'Description': Description,
      'City': City,
      'Street': Street,
      'Nr': Nr,
      'PostalCode': PostalCode,
      'Tarrif': Tarrif,
      'DateFrom': DateFrom,
      'DateTo': DateTo,
      'MocUmowna': MocUmowna,
      'TypLicznika': TypLicznika,
      'NREW': NREW,
      'LinkIMG': LinkIMG,
      'NrLicznika': NrLicznika,
      'Fazowosc': Fazowosc,
      'Hanplus': Hanplus,
      'DailyUsage': DailyUsage,
      'DailyGeneration': DailyGeneration,
      'MeterGenerationValue1': MeterGenerationValue1,
      'MeterGenerationValue2': MeterGenerationValue2,
      'MeterUsedValue1': MeterUsedValue1,
      'lastupdate': lastupdate,
      'HourlyUsage': HourlyUsage,
      'HourlyGeneration': HourlyGeneration,
      'MonthlyUsage': MonthlyUsage,
      'MonthlyGeneration': MonthlyGeneration,
    };
  }
}
