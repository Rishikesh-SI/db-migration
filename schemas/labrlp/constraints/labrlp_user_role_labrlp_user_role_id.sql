-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: labrlp_user_role labrlp_user_role_id
-- Type: CONSTRAINT

-- Name: labrlp_user_role labrlp_user_role_id; Type: CONSTRAINT; Schema: labrlp; Owner: -
--

ALTER TABLE ONLY labrlp.labrlp_user_role
    ADD CONSTRAINT labrlp_user_role_id PRIMARY KEY (user_role_id);


--
