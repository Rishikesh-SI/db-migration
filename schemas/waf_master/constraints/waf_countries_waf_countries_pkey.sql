-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_countries waf_countries_pkey
-- Type: CONSTRAINT

-- Name: waf_countries waf_countries_pkey; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_countries
    ADD CONSTRAINT waf_countries_pkey PRIMARY KEY (country_id);


--
