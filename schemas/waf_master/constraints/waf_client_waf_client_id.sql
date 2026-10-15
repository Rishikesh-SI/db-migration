-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_client waf_client_id
-- Type: CONSTRAINT

-- Name: waf_client waf_client_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_client
    ADD CONSTRAINT waf_client_id PRIMARY KEY (client_id);


--
