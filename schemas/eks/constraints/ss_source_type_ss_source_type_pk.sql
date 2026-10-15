-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_source_type ss_source_type_pk
-- Type: CONSTRAINT

-- Name: ss_source_type ss_source_type_pk; Type: CONSTRAINT; Schema: eks; Owner: -
--

ALTER TABLE ONLY eks.ss_source_type
    ADD CONSTRAINT ss_source_type_pk PRIMARY KEY (cf_source_typeid);


--
