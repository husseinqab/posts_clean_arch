import '../widgets_helpers/custom_dropdown_widget.dart';

class KycData {
  static List<DropDownItem> occupations = [
    DropDownItem(name: 'ACCOUNTING', value: 'ACCOUNTING'),
    DropDownItem(name: 'AUDIT', value: 'AUDIT'),
    DropDownItem(name: 'FINANCE', value: 'FINANCE'),
    DropDownItem(
        name: 'PUBLIC SECTOR ADMINISTRATION',
        value: 'PUBLIC_SECTOR_ADMINISTRATION'),
    DropDownItem(name: 'ART ENTERTAINMENT', value: 'ART_ENTERTAINMENT'),
    DropDownItem(name: 'AUTO AVIATION', value: 'AUTO_AVIATION'),
    DropDownItem(name: 'BANKING LENDING', value: 'BANKING_LENDING'),
    DropDownItem(
        name: 'BUSINESS CONSULTANCY LEGAL',
        value: 'BUSINESS_CONSULTANCY_LEGAL'),
    DropDownItem(name: 'CONSTRUCTION REPAIR', value: 'CONSTRUCTION_REPAIR'),
    DropDownItem(
        name: 'EDUCATION PROFESSIONAL SERVICES',
        value: 'EDUCATION_PROFESSIONAL_SERVICES'),
    DropDownItem(
        name: 'INFORMATIONAL TECHNOLOGIES',
        value: 'INFORMATIONAL_TECHNOLOGIES'),
    DropDownItem(name: 'TOBACCO ALCOHOL', value: 'TOBACCO_ALCOHOL'),
    DropDownItem(name: 'GAMING GAMBLING', value: 'GAMING_GAMBLING'),
    DropDownItem(name: 'MEDICAL SERVICES', value: 'MEDICAL_SERVICES'),
    DropDownItem(name: 'MANUFACTURING', value: 'MANUFACTURING'),
    DropDownItem(name: 'PR MARKETING', value: 'PR_MARKETING'),
    DropDownItem(
        name: 'PRECIOUS GOODS JEWELRY', value: 'PRECIOUS_GOODS_JEWELRY'),
    DropDownItem(
        name: 'NON GOVERNMENTAL ORGANIZATION',
        value: 'NON_GOVERNMENTAL_ORGANIZATION'),
    DropDownItem(name: 'INSURANCE SECURITY', value: 'INSURANCE_SECURITY'),
    DropDownItem(name: 'RETAIL WHOLESALE', value: 'RETAIL_WHOLESALE'),
    DropDownItem(name: 'TRAVEL TOURISM', value: 'TRAVEL_TOURISM'),
    DropDownItem(name: 'FREELANCER', value: 'FREELANCER'),
    DropDownItem(name: 'STUDENT', value: 'STUDENT'),
    DropDownItem(name: 'UNEMPLOYED', value: 'UNEMPLOYED'),
    DropDownItem(name: 'RETIRED', value: 'RETIRED'),
  ];

  static List<DropDownItem> sourceOfFunds = [
    DropDownItem(name: 'PERSONAL SAVINGS', value: 'PERSONAL_SAVINGS'),
    DropDownItem(name: 'FAMILY SAVINGS', value: 'FAMILY_SAVINGS'),
    DropDownItem(name: 'LABOUR CONTRACT', value: 'LABOUR_CONTRACT'),
    DropDownItem(name: 'CIVIL CONTRACT', value: 'CIVIL_CONTRACT'),
    DropDownItem(name: 'RENT', value: 'RENT'),
    DropDownItem(
        name: 'FUNDS FROM OTHER AUXILIARY SOURCES',
        value: 'FUNDS_FROM_OTHER_AUXILIARY_SOURCES'),
    DropDownItem(
        name: 'SALE OF MOVABLE ASSETS', value: 'SALE_OF_MOVABLE_ASSETS'),
    DropDownItem(name: 'SALE OF REAL ESTATE', value: 'SALE_OF_REAL_ESTATE'),
    DropDownItem(
        name: 'ORDINARY BUSINESS ACTIVITY',
        value: 'ORDINARY_BUSINESS_ACTIVITY'),
    DropDownItem(name: 'DIVIDENDS', value: 'DIVIDENDS'),
    DropDownItem(
        name: 'LOAN FROM FINANCIAL INSTITUTIONS CREDIT UNIONS',
        value: 'LOAN_FROM_FINANCIAL_INSTITUTIONS_CREDIT_UNIONS'),
    DropDownItem(
        name: 'LOAN FROM THIRD PARTIES', value: 'LOAN_FROM_THIRD_PARTIES'),
    DropDownItem(name: 'INHERITANCE', value: 'INHERITANCE'),
    DropDownItem(
        name: 'SALE OF COMPANY SHARES BUSINESS',
        value: 'SALE_OF_COMPANY_SHARES_BUSINESS'),
    DropDownItem(name: 'OTHER', value: 'OTHER'),
  ];

  static List<DropDownItem> purposeOfAccount = [
    DropDownItem(name: 'CARD INSIDE EEA', value: 'CARD_INSIDE_EEA'),
    DropDownItem(name: 'CARD OUTSIDE EEA', value: 'CARD_OUTSIDE_EEA'),
    DropDownItem(name: 'CRYPTO PAYMENTS', value: 'CRYPTO_PAYMENTS'),
    DropDownItem(name: 'FIAT PAYMENTS', value: 'FIAT_PAYMENTS'),
    DropDownItem(name: 'OTHER', value: 'OTHER'),
  ];

  static List<DropDownItem> expectedVolumeItems = [
    DropDownItem(name: 'LESS THAN 1000 EUR', value: 'LESS_THAN_1000_EUR'),
    DropDownItem(
        name: 'BETWEEN 1000 AND 5000 EUR', value: 'BETWEEN_1000_AND_5000_EUR'),
    DropDownItem(
        name: 'BETWEEN 5000 AND 10000 EUR',
        value: 'BETWEEN_5000_AND_10000_EUR'),
    DropDownItem(
        name: 'BETWEEN 10000 AND 15000 EUR',
        value: 'BETWEEN_10000_AND_15000_EUR'),
    DropDownItem(name: 'MORE THAN 15000 EUR', value: 'MORE_THAN_15000_EUR'),
  ];

  static List<String> unSupportedCountries = [
    "AF",
    "AL",
    "AS",
    "BB",
    "BW",
    "BF",
    "KH",
    "KY",
    "CN",
    "FJ",
    "GH",
    "GU",
    "HT",
    "IR",
    "JM",
    "JO",
    "ML",
    "MU",
    "MA",
    "MM",
    "NI",
    "KP",
    "PK",
    "PW",
    "PA",
    "PH",
    "WS",
    "SN",
    "SS",
    "SY",
    "RU",
    "BY",
    "TT",
    "TR",
    "UG",
    "US",
    "VI",
    "VU",
    "YE",
    "ZW",
  ];
}
