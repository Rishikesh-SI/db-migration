-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_user_activity labrao_user_activity_id
-- Type: CONSTRAINT

-- Name: labmao_user_activity labrao_user_activity_id; Type: CONSTRAINT; Schema: labmao; Owner: -
--

ALTER TABLE ONLY labmao.labmao_user_activity
    ADD CONSTRAINT labrao_user_activity_id PRIMARY KEY (user_activity_id);


--
