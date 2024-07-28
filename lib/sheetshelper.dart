import 'package:gsheets/gsheets.dart';

class SheetsHelper{

  static const _creds = r'''
  {
    "type": "service_account",
    "project_id": "snp-project-430722",
    "private_key_id": "95b68cf7b0b4ae170a04d6e4876788dabf4a1f99",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCXv02QqAq+66Yb\nbyKbJWTjKjGuJ6opKQTMCC8craIjeUe/tCIQhvcvjcJz3nWTVP/DlVPN87SCDStl\nbjyfJLrCrjDTz/0q1TEKlTqD5KxRZVKt5kWeJM+/pFeJ1QRd6ErnFGfF1jSqOksY\n/JAjJvwN4tNSl2n4V0mtVO41nuTD2OA75xsld9PD44TfphB+0UXsq6EhE3fKQUXY\nhxh6l1k0K7k0Qh+eGCjdBLnKFx19XdIovxmdZLEkMjl/0Ml2RU9bspu9iOMUcIaO\nZX5Aoa6FPB5TVPDsqk4djcLs/EYOO1itXjX3wbmLt4dfplJJAh8QgUYGJLROjVCv\n7YXwqEWXAgMBAAECggEADR4/FNXKFAYoFnANlE7vwUmZAN6x8Zv3q7G7bOW/wgRO\nhQ6L8VTRkp1VJZIiJOnwsFY85+18+c8spLiaagGRWZoYY38z+htzAWC0Lcm7cc/q\nDVl+RDUXdpA89w/gsEOQEhjr/ajOZbbjXhYbWcaZfJPSw+2N/ieBmYfhjeYeDaYU\nY0cr+Nv1Eydr3EePU9dxLh3O+8YmDnwotSbtEDh11vVHFWoNC0PWKgjDCRby/XdJ\nnxjQivc76mF4o6hjdyYCO7nOjkOQL/iGeVToBZzA+CeEQJ8DtxO2o5MPIo+cpn0m\ncxgjLGRocU51QtEk5jdOJWwUwP3gkZ33xUPzpeCpbQKBgQDOZY3tijgMtP0s2k4N\nmZNzztkHR2OcCq/BWqXGMdmCRgDHoMddl7DaNRlk2RC+jSzhAHnScAIJqw+MWTPl\nD4MI+t9vN8vnJ5gUtmGuooMQl+KSRDmIyunt5yjP4DFDyAqxjBBNV5xxw/zXcZQS\nrIPc5lxrEnD3tzTbnL3ueUbGtQKBgQC8N3j0fX9bYB8S7Dle2ly0So6dTaZ3p+Gf\niz/FxbluZZDbuFhUB1AKLseQaaYk5qT5ooYLp6sMEvm8tiTrHBz31bIyu3VvQqTG\n+vLrC2lZuS72trv1jyZCjr8EjdUZLcax6x9mgwUMPP2mRTdhpHtZpqSh+CtokYma\nGBniQanemwKBgC+wqX20jUTqYQGHI7fiv35n0h/rb+mzUm8D6gAErrR6Rl3aGZbX\noQaadFaoDUVqS29l88AbH21qeDo+tk38KpPdm9kP9G5h6LMIfUOjy1L/NVwEpaKk\n+C5/Vh/KNrfptgbWTUIBt2VWGssRNFyoPgPBuqMG7NFgJLeF3SEIJsFtAoGARJcG\nmjqdzePijxfM9HcpL364KDUjBBoHDAhH7j/XCpcyyg+NCNo9XeicS1Fk/a+b0Wlb\n5iVtHRJRNmc+Xvu4xsx2iyxraGdl+yl6mxNmig8FQV1oc919+OViUTuKvAlFjpL7\nt3TpwwL7ALvaqdeyKAKlnmz9DLd06NX9oMmDKR8CgYAn01ienShwL54diah4fszY\nPk6zXX4M6/TIH5PswKpq/OQMvBgW4pcvEfdNfZ88MFkb2teci8iCk8rvwunQrHQ7\nJGG34e/TrG3Jcs1KL7NZddHBcgyUgNXwj92LZcyOiQbH/vPxHf2pIm8g5Ux71kJa\ngUBZKmuewNjr1WfE3m9XSg==\n-----END PRIVATE KEY-----\n",
    "client_email": "snpprojectbackend@snp-project-430722.iam.gserviceaccount.com",
    "client_id": "105327546044461209375",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/snpprojectbackend%40snp-project-430722.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
  ''';

  

  static Future<Worksheet?> sheetSetup(String name ) async {
    final gsheets = GSheets(_creds);
    final ss = await gsheets.spreadsheet('1DSKtxwgjJz7p4a3ovVA9Jl9BvMff_EGAnFccaRpW5zo');
    final sheet = ss.worksheetByTitle(name); 
    return sheet;
  }


 
}

