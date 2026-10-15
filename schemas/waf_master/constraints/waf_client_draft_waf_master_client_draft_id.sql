-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_client_draft waf_master_client_draft_id
-- Type: CONSTRAINT

-- Name: waf_client_draft waf_master_client_draft_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_client_draft
    ADD CONSTRAINT waf_master_client_draft_id PRIMARY KEY (client_draft_id);


--
