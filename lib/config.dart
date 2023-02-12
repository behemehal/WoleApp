int language = 1;

Map<int, String> langs = {
  1: "Türkçe",
  2: "English",
};

Map<String, String> data = {
  '11': "Favorilerde hiçbir şey yok",
  '12': "Geçmişte hiçbir şey yok",
  '13': "Yeni Bağlantı",
  '14': "Paket Gönder",
  '15': "Bağlantı Adı",
  '16': "IP Adresi",
  '17': "MAC Adresi",
  '18': "Lütfen bir bağlantı adı girin",
  '19': "Lütfen doğru bir IP adresi girin",
  '110': "Lütfen doğru bir MAC adresi girin",
  '111': "Paket Gönderildi",
  '112': "Paket Gönderilemedi",
  '113': "Favoriler",
  '114': "Geçmiş",
  '116': "Favorilere Ekle",
  '117': "Favorilerden Çıkar",
  '119': 'Bağlantıyı Sil',
  '120': 'Hakkında',
  '121':
      "Wole Wake-On-Lan uygulaması ağ üzerinden cihazlarınızı uyandırmaya yarar.",
  '122': "Açık-Kaynak Lisansları",
  '123': "Gizlilik Politikası",
  '124': "Kaynak kodunu buradan bulabilirsiniz",
  '125': "GPL-2 lisansı ile lisanslanmıştır",
  '126': "Uygulama Dili",
  '127': "Bağlantı Silindi",
  '128': "Favorilere Eklendi",
  '129': "Favorilerden Çıkarıldı",
  '21': "There is nothing in favorites",
  '22': "There is nothing in history",
  '23': "New Connection",
  '24': "Send Packet",
  '25': "Connection Name",
  '26': "IP Address",
  '27': "MAC Address",
  '28': "Please enter a connection name",
  '29': "Please enter a valid IP address",
  '210': "Please enter a valid MAC address",
  '211': "Packet Sent",
  '212': "Failed to send package",
  '213': "Favorites",
  '214': "History",
  '216': "Add to Favorites",
  '217': "Remove from Favorites",
  '219': 'Delete Connection',
  '220': 'About',
  '221':
      "Wole is a Wake-On-Lan application that allows you to wake up your devies over the network.",
  '222': "Open Source Licenses",
  '223': "Privacy Policy",
  '224': "Source code is on",
  '225': "Licensed under GPL-2",
  '226': "App Language",
  "227": "Connection Deleted",
  '228': "Added to Favorites",
  '229': "Removed from Favorites",
};

String getLangContext(String key) {
  return data[language.toString() + key]!;
}
