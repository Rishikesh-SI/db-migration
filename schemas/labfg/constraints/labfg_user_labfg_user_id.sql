-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_user labfg_user_id
-- Type: CONSTRAINT

-- Name: labfg_user labfg_user_id; Type: CONSTRAINT; Schema: labfg; Owner: -
--

ALTER TABLE ONLY labfg.labfg_user
    ADD CONSTRAINT labfg_user_id PRIMARY KEY (user_id);


--
