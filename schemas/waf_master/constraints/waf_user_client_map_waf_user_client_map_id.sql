-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_user_client_map waf_user_client_map_id
-- Type: CONSTRAINT

-- Name: waf_user_client_map waf_user_client_map_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_user_client_map
    ADD CONSTRAINT waf_user_client_map_id PRIMARY KEY (user_client_map_id);


--
