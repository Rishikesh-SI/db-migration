-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_user labgrl_user_id
-- Type: CONSTRAINT

-- Name: labgrl_user labgrl_user_id; Type: CONSTRAINT; Schema: labgrl; Owner: -
--

ALTER TABLE ONLY labgrl.labgrl_user
    ADD CONSTRAINT labgrl_user_id PRIMARY KEY (user_id);


--
