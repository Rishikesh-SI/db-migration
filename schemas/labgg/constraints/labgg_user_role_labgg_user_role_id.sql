-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: labgg_user_role labgg_user_role_id
-- Type: CONSTRAINT

-- Name: labgg_user_role labgg_user_role_id; Type: CONSTRAINT; Schema: labgg; Owner: -
--

ALTER TABLE ONLY labgg.labgg_user_role
    ADD CONSTRAINT labgg_user_role_id PRIMARY KEY (user_role_id);


--
