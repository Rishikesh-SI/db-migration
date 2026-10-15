-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: labrlp_user_activity labrlp_user_activity_id
-- Type: CONSTRAINT

-- Name: labrlp_user_activity labrlp_user_activity_id; Type: CONSTRAINT; Schema: labrlp; Owner: -
--

ALTER TABLE ONLY labrlp.labrlp_user_activity
    ADD CONSTRAINT labrlp_user_activity_id PRIMARY KEY (user_activity_id);


--
