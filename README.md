# Seçim Sistemi - Motoko

Motoko ile yazılmış basit bir seçim yönetim sistemi. Bu sistem, seçmen ve aday ekleme, oy verme ve seçim sonuçlarını hesaplama özelliklerini sunar.

---

## Özellikler
- **Seçmen Yönetimi**:
  - Benzersiz kimliklerle seçmen ekleme.
  - Kimliğe göre seçmen bilgisi getirme.
  - Tüm seçmenleri listeleme.
- **Aday Yönetimi**:
  - Benzersiz kimliklerle aday ekleme.
  - Kategoriye göre adayları getirme.
  - Tüm adayları listeleme.
- **Oy Verme Sistemi**:
  - Seçmen ID ve aday ID'ye göre oy verme.
  - Bir seçmenin yalnızca bir kez oy vermesini sağlama.
  - Oy sonuçlarını hesaplama.
  - Yeni bir seçim için oyları sıfırlama.

---

## Gereksinimler
- [Internet Computer SDK](https://smartcontracts.org/docs/developers-guide/install-upgrade-remove.html)

---

## Kurulum

1. Depoyu klonlayın:
   ```bash
   git clone https://github.com/whatupdoan/secim-sistemi-motoko.git
   cd secim-sistemi-motoko
