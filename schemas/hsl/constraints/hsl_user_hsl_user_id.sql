-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_user hsl_user_id
-- Type: CONSTRAINT

-- Name: hsl_user hsl_user_id; Type: CONSTRAINT; Schema: hsl; Owner: -
--

ALTER TABLE ONLY hsl.hsl_user
    ADD CONSTRAINT hsl_user_id PRIMARY KEY (user_id);


--
