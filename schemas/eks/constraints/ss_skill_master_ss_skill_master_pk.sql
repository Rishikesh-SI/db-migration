-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_skill_master ss_skill_master_pk
-- Type: CONSTRAINT

-- Name: ss_skill_master ss_skill_master_pk; Type: CONSTRAINT; Schema: eks; Owner: -
--

ALTER TABLE ONLY eks.ss_skill_master
    ADD CONSTRAINT ss_skill_master_pk PRIMARY KEY (cf_skillid);


--
