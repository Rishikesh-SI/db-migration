-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_user hsl_user_id
-- Type: CONSTRAINT

-- Name: labhsl_user hsl_user_id; Type: CONSTRAINT; Schema: labhsl; Owner: -
--

ALTER TABLE ONLY labhsl.labhsl_user
    ADD CONSTRAINT hsl_user_id PRIMARY KEY (user_id);


--
