-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_poll hsl_poll_id
-- Type: CONSTRAINT

-- Name: hsl_poll hsl_poll_id; Type: CONSTRAINT; Schema: hsl; Owner: -
--

ALTER TABLE ONLY hsl.hsl_poll
    ADD CONSTRAINT hsl_poll_id PRIMARY KEY (poll_id);


--
