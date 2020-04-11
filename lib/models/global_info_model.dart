class GlobalInfo {
  int cases;
  int deaths;
  int recovered;

  GlobalInfo({this.cases, this.deaths, this.recovered});

  GlobalInfo.fromJson(Map<String, dynamic> json) {
    cases = json['cases'];
    deaths = json['deaths'];
    recovered = json['recovered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cases'] = this.cases;
    data['deaths'] = this.deaths;
    data['recovered'] = this.recovered;
    return data;
  }
}