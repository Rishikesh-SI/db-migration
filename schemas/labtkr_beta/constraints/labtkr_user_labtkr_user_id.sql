-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: labtkr_user labtkr_user_id
-- Type: CONSTRAINT

-- Name: labtkr_user labtkr_user_id; Type: CONSTRAINT; Schema: labtkr_beta; Owner: -
--

ALTER TABLE ONLY labtkr_beta.labtkr_user
    ADD CONSTRAINT labtkr_user_id PRIMARY KEY (user_id);


--
