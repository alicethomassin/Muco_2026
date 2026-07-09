before <- C4_B5 %>% 
  group_by(id_anonymat) %>% 
  filter(any(!is.na(sf_an_conjt_nais))) %>% 
  select(id_anonymat, id_date_nais, sf_conjt_an_nais, sf_an_conjt_nais)

after <- C4_C0 %>% 
  filter(id_anonymat %in% before$id_anonymat) %>% 
  select(id_anonymat, id_date_nais, sf_conjt_an_nais)


help <- C4_C0 %>% 
  filter(id_anonymat %in% c("AGJKE", "NOPFV", "AMTKY", "AXWBV",
                              "KHDKI", "NWUFG")) %>% 
  select(id_anonymat, id_date_nais, sf_conjt_an_nais, sf_conjt_an_union)


final <- Couple %>% 
  filter(id_anonymat %in% help$id_anonymat) %>% 
  select(fa_cp_nb_unions, fa_cp_nb_ints, id_anonymat, id_date_nais, 
         ends_with("conjt_nais_an"), ends_with("union_an"), ends_with("union_int"),
         ends_with("union_int_an"))
