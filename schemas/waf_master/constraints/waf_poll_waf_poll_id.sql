-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_poll waf_poll_id
-- Type: CONSTRAINT

-- Name: waf_poll waf_poll_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_poll
    ADD CONSTRAINT waf_poll_id PRIMARY KEY (poll_id);


--
