-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_country_master ss_country_master_pk
-- Type: CONSTRAINT

-- Name: ss_country_master ss_country_master_pk; Type: CONSTRAINT; Schema: eks; Owner: -
--

ALTER TABLE ONLY eks.ss_country_master
    ADD CONSTRAINT ss_country_master_pk PRIMARY KEY (cf_countryid);


--
