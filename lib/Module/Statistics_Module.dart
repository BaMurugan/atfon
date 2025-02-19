import 'dart:convert';

class Statistics {
  int quoteEnquiries;
  int quotes;
  int submittedQuotes;
  int orders;
  int paidOrders;
  dynamic conversionRate;
  String revenue;

  Statistics({
    required this.quoteEnquiries,
    required this.quotes,
    required this.submittedQuotes,
    required this.orders,
    required this.paidOrders,
    required this.conversionRate,
    required this.revenue,
  });

  factory Statistics.fromJson(String str) =>
      Statistics.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Statistics.fromMap(Map<String, dynamic> json) => Statistics(
        quoteEnquiries: json["quoteEnquiries"],
        quotes: json["quotes"],
        submittedQuotes: json["submittedQuotes"],
        orders: json["orders"],
        paidOrders: json["paidOrders"],
        conversionRate: json["conversionRate"],
        revenue: json["revenue"],
      );

  Map<String, dynamic> toMap() => {
        "quoteEnquiries": quoteEnquiries,
        "quotes": quotes,
        "submittedQuotes": submittedQuotes,
        "orders": orders,
        "paidOrders": paidOrders,
        "conversionRate": conversionRate,
        "revenue": revenue,
      };
}
