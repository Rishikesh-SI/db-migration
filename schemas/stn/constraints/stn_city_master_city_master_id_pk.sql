-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_city_master city_master_id_pk
-- Type: CONSTRAINT

-- Name: stn_city_master city_master_id_pk; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_city_master
    ADD CONSTRAINT city_master_id_pk PRIMARY KEY (city_id);


--
