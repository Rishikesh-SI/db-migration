-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_user_activity rfg_user_activity_id
-- Type: CONSTRAINT

-- Name: rfg_user_activity rfg_user_activity_id; Type: CONSTRAINT; Schema: rfg; Owner: -
--

ALTER TABLE ONLY rfg.rfg_user_activity
    ADD CONSTRAINT rfg_user_activity_id PRIMARY KEY (user_activity_id);


--
