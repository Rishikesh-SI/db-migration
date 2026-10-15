-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ttgl_poll_option ttgl_poll_option_id
-- Type: CONSTRAINT

-- Name: ttgl_poll_option ttgl_poll_option_id; Type: CONSTRAINT; Schema: ttgl; Owner: -
--

ALTER TABLE ONLY ttgl.ttgl_poll_option
    ADD CONSTRAINT ttgl_poll_option_id PRIMARY KEY (poll_option_id);


--
